/* sim.c: simulator functions
 * $Id: sim.c,v 1.9 2003/07/13 10:12:47 martinus Exp $
 */

/* This file is part of `exhaust', a memory array redcode simulator.
 * Copyright (C) 2002 M Joonas Pihlaja
 * Public Domain.
 * Thread Safe API modifications by Joseph Espy 2020
 * Also Public Domain
 */

/*
 * Thanks go to the pMARS authors and Ken Espiritu whose ideas have
 * been used in this simulator.  Especially Ken's effective addressing
 * calculation code in pMARS 0.8.6 has been adapted for use here.
 */

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "asm.h"
#include "exhaust.h"
#include "insn.h"
#include "sim.h"

/******************************************************************************
 * File scoped internal #defines, internal structures, and internal prototypes
 *****************************************************************************/

// TODO: you also cannot have both HARDCODED and SINGLETHREADED at the same time
// fix this #define HARDCODED_CONSTANTS 1
#define SINGLE_THREADED_API 1

/* Should we hardcode koth contstants?  By default no */
#ifdef HARDCODED_CONSTANTS
#define HC_CORESIZE 8000
#define HC_PSPACESIZE 500
#define HC_MAXCYCLES 80000
#define HC_MAXPROCESSES 8000
#define HC_WARRIORS 2
#define HC_MAXLENGTH 100
#endif

/* Should we strip flags from instructions when loading?  By default,
 *  yes.  If so, then the simulator won't bother masking them off.
 */
#ifndef SIM_STRIP_FLAGS
#define SIM_STRIP_FLAGS 1
#endif

/* DEBUG level:
 *     0: none
 *   >=1: disassemble each instruction (no output)
 *     2: print each instruction as it is executed
 */
#ifndef DEBUG
#define DEBUG 0
#endif

/* internal and opaque structures */

/* warrior internal representation */
typedef struct _warrior_st {
  insn_t **tail;            /* next free location to queue a process */
  insn_t **head;            /* next process to run from queue */
  struct _warrior_st *succ; /* next warrior alive */
  uint32_t nProcs;          /* number of live processes in this warrior */
  struct _warrior_st *pred; /* previous warrior alive */
  int id;                   /* index (or identity) of warrior */
} w_t;

/* Simulator state.  Opaque to external API users */
typedef struct {
  /* typical cases, these are not hardcoded and we dynamically allocate buffers
   */
#ifndef HARDCODED_CONSTANTS
  unsigned int coreSize;
  unsigned int pspaceSize;
  unsigned int cycles;
  unsigned int maxProcesses;
  unsigned int numWarriors;
  w_t *warTab;
  insn_t *coreMem;
  insn_t **queueMem;
  pspace_t **pspaces;
#endif

  /* If we do hardcode parameters, our struct does not dynamically allocate
   * anything */
#ifdef HARDCODED_CONSTANTS
  /* numeric constants like coreSize etc are taken from #defines */
  w_t warTab[HC_WARRIORS];
  insn_t coreMem[HC_CORESIZE];
  insn_t *queueMem[HC_WARRIORS * HC_MAXPROCESSES + 1];
  pspace_t pspaces[HC_WARRIORS][HC_PSPACESIZE];
#endif

} SimState_t;

/* Default values for the simulator */
#define DEF_MAX_WARS 2
#define DEF_CORESIZE 8000
#define DEF_PROCESSES 8000
#define DEF_CYCLES 80000

/* prototypes for internal functions */
static int simulate(SimState_t *sim, const field_t *const war_pos_tab,
                    unsigned int *death_tab);
static SimState_t *alloc_sim();
static void free_sim(SimState_t *sim);
static void clear_sim(SimState_t *sim);
static pspace_t **alloc_pspaces(unsigned int nwars, unsigned int pspacesize);
static void free_pspaces(unsigned int nwar, pspace_t **pspaces);

/******************************************************************************
 * Thread Safe Public API Implementation
 *****************************************************************************/

/******************************************************************************
 * Thread Unsafe Public API Implementation
 *****************************************************************************/
#ifdef SINGLE_THREADED_API

static SimState_t *globalstate;

insn_t *sim_alloc_bufs(unsigned int nwar, unsigned int coresize,
                       unsigned int processes, unsigned int cycles) {
  int pspacesize = coresize / 16 == 0 ? 1 : coresize / 16;
  return sim_alloc_bufs2(nwar, coresize, processes, cycles, pspacesize);
}
insn_t *sim_alloc_bufs2(unsigned int nwar, unsigned int coresize,
                        unsigned int processes, unsigned int cycles,
                        unsigned int pspace) {
  free_sim(globalstate);
  globalstate = alloc_sim(coresize, pspace, cycles, processes, nwar);
  if (globalstate) return globalstate->coreMem;
  return NULL;
}

void sim_free_bufs() { free_sim(globalstate); }

void sim_clear_core(void) { clear_sim(globalstate); }

pspace_t **sim_get_pspaces(void) {
  if (globalstate) return globalstate->pspaces;
  return NULL;
}

pspace_t *sim_get_pspace(unsigned int war_id) {
  if (globalstate) return globalstate->pspaces[war_id];
  return NULL;
}

void sim_clear_pspaces() {
  unsigned int i;
  for (i = 0; i < globalstate->numWarriors; i++) {
    pspace_clear(globalstate->pspaces[i]);
    pspace_set(globalstate->pspaces[i], 0, globalstate->coreSize - 1);
  }
}

void sim_reset_pspaces() {
  for (int i = 0; i < globalstate->numWarriors; i++) {
    pspace_privatise(globalstate->pspaces[i]);
  }
  sim_clear_pspaces();
}

int sim_load_warrior(unsigned int pos, const insn_t *const code,
                     unsigned int len) {
  unsigned int i;
  field_t k;
  uint32_t in;

  if (globalstate->coreMem == NULL) return -1;
  if (len > globalstate->coreSize) return -2;

  for (i = 0; i < len; i++) {
    k = (pos + i) % globalstate->coreSize;

#if SIM_STRIP_FLAGS
    in = code[i].in & iMASK;
#else
    in = code[i].in;
#endif

    globalstate->coreMem[k].in = in;
    globalstate->coreMem[k].a = code[i].a;
    globalstate->coreMem[k].b = code[i].b;
  }
  return 0;
}

int sim(int nwar, field_t w1_start, field_t w2_start, unsigned int cycles,
        void **ptr_result) {
  field_t war_pos_tab[2];
  unsigned int death_tab[2];
  int alive_cnt;

  /* if the caller requests for the address of core, allocate
   * the default buffers and give it
   */
  if (nwar < 0) {
    if (nwar == -1 && ptr_result) {
      *ptr_result =
          sim_alloc_bufs(DEF_MAX_WARS, DEF_CORESIZE, DEF_PROCESSES, DEF_CYCLES);
      return 0;
    }
    return -1;
  }
  if (nwar > 2) return -1;

  /* otherwise set up things for sim_mw() */
  globalstate->cycles = cycles;
  war_pos_tab[0] = w1_start;
  war_pos_tab[1] = w2_start;

  alive_cnt = sim_mw(nwar, war_pos_tab, death_tab);
  if (alive_cnt < 0) return -1;

  if (nwar == 1) return alive_cnt;

  if (alive_cnt == 2) return 2;
  return death_tab[0] == 0 ? 1 : 0;
}

int sim_mw(unsigned int nwar, const field_t *const war_pos_tab,
           unsigned int *death_tab) {
  int alive_count;
  if (!globalstate) return -1;

  alive_count = simulate(globalstate, war_pos_tab, death_tab);

  /* Update p-space locations 0. */
  if (alive_count >= 0) {
    unsigned int nalive = alive_count;
    unsigned int i;

    for (i = 0; i < nwar; i++) {
      pspace_set(globalstate->pspaces[i], 0, nalive);
    }
    for (i = 0; i < nwar - nalive; i++) {
      pspace_set(globalstate->pspaces[death_tab[i]], 0, 0);
    }
  }
  return alive_count;
}

#endif
/******************************************************************************
 * Internal Implementations
 *****************************************************************************/

static SimState_t *alloc_sim(unsigned int coreSize, unsigned int pspaceSize,
                             unsigned int cycles, unsigned int maxProcesses,
                             unsigned int numWarriors) {
  SimState_t *sim = calloc(1, sizeof(SimState_t));
  if (!sim) {
    free(sim);
    return NULL;
  }
#ifdef HARDCODED_CONSTANTS
  /* Less initialization needed if we are hardcoding constants */
  return sim;
#endif

#ifndef HARDCODED_CONSTANTS
  pspace_t **pspaces = alloc_pspaces(numWarriors, pspaceSize);
  w_t *warTab = calloc(numWarriors, sizeof(w_t));
  insn_t *coreMem = calloc(coreSize, sizeof(insn_t));
  insn_t **queueMem = calloc(numWarriors * maxProcesses + 1, sizeof(insn_t *));
  if (!warTab || !coreMem || !queueMem || !pspaces) goto bad_alloc;

  *sim = (SimState_t){coreSize, pspaceSize, cycles,   maxProcesses, numWarriors,
                      warTab,   coreMem,    queueMem, pspaces};
  return sim;
bad_alloc:
  free(sim);
  free(coreMem);
  free(warTab);
  free(queueMem);
  free_pspaces(numWarriors, pspaces);
  return NULL;
#endif
}

static void free_sim(SimState_t *sim) {
  if (!sim) return;

#ifndef HARDCODED_CONSTANTS
  free_pspaces(sim->numWarriors, sim->pspaces);
  free(sim->warTab);
  free(sim->coreMem);
  free(sim->queueMem);
#endif  // HARDCODED_CONSTANTS

  free(sim);
}

static void clear_sim(SimState_t *sim) {
  if (!sim) return;

    /* if we have hardcoded constants, then we clear sim
     * and if we don't have hardcoded constants, then we clear
     * everything but the parameters stored in sim
     */
#ifndef HARDCODED_CONSTANTS
  free_pspaces(sim->numWarriors, sim->pspaces);
  sim->pspaces = alloc_pspaces(sim->numWarriors, sim->pspaceSize);
  memset(sim->coreMem, 0, sizeof(insn_t) * sim->coreSize);
  memset(sim->warTab, 0, sizeof(w_t) * sim->numWarriors);
  memset(sim->queueMem, 0,
         sizeof(insn_t *) * (sim->numWarriors * sim->maxProcesses + 1));
#endif

#ifdef HARDCODED_CONSTANTS
  memset(sim, 0, sizeof(SimState_t));
#endif
}

static pspace_t **alloc_pspaces(unsigned int numWarriors,
                                unsigned int pspacesize) {
  if (numWarriors == 0) return NULL;
  pspace_t **pspaces = calloc(numWarriors, sizeof(pspace_t *));
  if (!pspaces) return pspaces;
  for (int i = 0; i < numWarriors; i++) {
    pspaces[i] = pspace_alloc(pspacesize);
    if (!pspaces[i]) {
      free_pspaces(i - 1, pspaces);
      return NULL;
    }
  }
  return pspaces;
}

static void free_pspaces(unsigned int numWarriors, pspace_t **pspaces) {
  if (!pspaces) return;
  for (int i = 0; i < numWarriors; i++) {
    pspace_free(pspaces[i]);
  }
  free(pspaces);
}

/* TODO: Rewrite this entire documentation
 * NAME
 *     sim_proper -- the real simulator code
 *
 * SYNOPSIS
 *     int sim_proper( unsigned int nwar,
 *                     const field_t *war_pos_tab,
 *                     unsigned int *death_tab );
 *
 * INPUTS
 *     nwar        -- number of warriors
 *     war_pos_tab -- core addresses where warriors are loaded in
 *		      the order they are to be executed.
 *     death_tab   -- the table where dead warrior indices are stored
 *
 * RESULTS
 *     The warriors fight their fight in core which gets messed up in
 *     the process.  The indices of warriors that die are stored into
 *     the death_tab[] array in the order of death.  Warrior indices
 *     start from 0.
 *
 * RETURN VALUE
 *     The number of warriors still alive at the end of the
 *     battle or -1 on an anomalous condition.
 *
 * GLOBALS
 *     All file scoped globals
 */

/* Various macros:
 *
 *  queue(x): Inserts a core address 'x' to the head of the current
 *            warrior's process queue.  Assumes the warrior's
 * 	      tail pointer is inside the queue buffer.
 *
 * x, y must be in 0..sim->coreSize-1 for the following macros:
 *
 * INCMOD(x): x = x+1 mod sim->coreSize
 * DECMOD(x): x = x-1 mod sim->coreSize
 * ADDMOD(z,x,y): z = x+y mod sim->coreSize
 * SUBMOD(z,x,y): z = x-y mod sim->coreSize
 */

/*#define queue(x)  do { *w->tail++ = (x); if ( w->tail == queue_end )\
                                          w->tail = queue_start; } while (0)
*/
#define queue(x)                                         \
  do {                                                   \
    *(w->tail) = (x);                                    \
    if (++(w->tail) == queue_end) w->tail = queue_start; \
  } while (0)

#define INCMOD(x)                  \
  do {                             \
    if (++(x) == core_sz) (x) = 0; \
  } while (0)
#define IPINCMOD(x)                    \
  do {                                 \
    if (++(x) == core_end) (x) = core; \
  } while (0)
#define DECMOD(x)                        \
  do {                                   \
    if ((x)-- == 0) (x) = (core_sz - 1); \
  } while (0)
#define IPDECMOD(x)  \
  do {               \
    if ((x) == 0)    \
      x = core_last; \
    else             \
      --(x);         \
  } while (0)
#define ADDMOD(z, x, y)                 \
  do {                                  \
    (z) = (x) + (y);                    \
    if ((z) >= core_sz) (z) -= core_sz; \
  } while (0)
/*#define SUBMOD(z,x,y) do { (z) = (x)-(y); if ((int)(z)<0) (z) +=
 * core_sz; } while (0)*/
/* z is unsigned! overflow occurs. */
#define SUBMOD(z, x, y)                 \
  do {                                  \
    (z) = (x) - (y);                    \
    if ((z) >= core_sz) (z) += core_sz; \
  } while (0)

/* private macros to access p-space. */
#define UNSAFE_PSPACE_SET(warid, paddr, val)       \
  do {                                             \
    if (paddr) {                                   \
      sim->pspaces[(warid)]->mem[(paddr)] = (val); \
    } else {                                       \
      sim->pspaces[(warid)]->lastresult = (val);   \
    }                                              \
  } while (0)

#define UNSAFE_PSPACE_GET(warid, paddr)          \
  ((paddr) ? sim->pspaces[(warid)]->mem[(paddr)] \
           : sim->pspaces[(warid)]->lastresult)

static int simulate(SimState_t *sim, const field_t *const war_pos_tab,
                    unsigned int *death_tab) {
  // insn_t *const core = Core_Mem;
  // w_t *w; /* current warrior */
  // const unsigned int core_sz = Coresize;
  // const unsigned int core_sz1 =
  //    core_sz - 1;                        /* size of core, size of core
  //    - 1
  //    */
  // insn_t *const core_end = core + core_sz; // point after last
  // instruction insn_t *const core_end1 = core_end - 1;    // point to last
  // instruction int cycles = nwar * Cycles; /* set instruction executions until
  // tie counter
  // */ int alive_cnt = nwar; insn_t
  // **pofs = queue_end - 1;

  /*
   * Core and Process queue memories.
   *
   * The warriors share a common cyclic buffer for use as a process
   * queue which the contains core addresses where active processes
   * are.  The buffer has size N*P+1, where N = number of warriors,
   * P = maximum number of processes / warrior.
   *
   * Each warrior has a fixed slice of the buffer for its own process
   * queue which are initially allocated to the warriors in reverse
   * order. i.e. if the are N warriors w1, w2, ..., wN, the slice for
   * wN is 0..P-1, w{N-1} has P..2P-1, until w1 has (N-1)P..NP-1.
   *
   * The core address of the instruction is fetched from the head of
   * the process queue and processes are pushed to the tail, so the
   * individual slices slide along at one location per executed
   * instruction.  The extra '+1' in the buffer size is to have free
   * space to slide the slices along.
   *
   * For two warriors w1, w2:
   *
   * |\......../|\......../| |
   * | w2 queue | w1 queue | |
   * 0          P         2P 2P+1
   */

  /*
   * Cache Registers.
   *
   * The '94 draft specifies that the redcode processor model be
   * 'in-register'.  That is, the current instruction and the
   * instructions at the effective addresses (ea's) be cached in
   * registers during instruction execution, rather than have
   * core memory accessed directly when the operands are needed.  This
   * causes differences from the 'in-memory' model.  e.g. MOV 0,>0
   * doesn't change the instruction's b-field since the instruction at
   * the a-field's effective address (i.e. the instruction itself) was
   * cached before the post-increment happened.
   *
   * There are conceptually three registers: IN, A, and B.  IN is the
   * current instruction, and A, B are the ones at the a- and
   * b-fields' effective addresses respectively.
   *
   * We don't actually cache the complete instructions, but rather
   * only the *values* of their a- and b-field.  This is because
   * currently there is no way effective address computations can
   * modify the opcode, modifier, or addressing modes of an
   * instruction.
   */

  /*
   * A few declarations for convenience
   */
#ifndef HARDCODED_CONSTANTS
  unsigned int core_sz = sim->coreSize;
  unsigned int pspace_sz = sim->pspaceSize;
  unsigned int cycles = sim->cycles * sim->numWarriors;
  unsigned int max_proc = sim->maxProcesses;
  unsigned int nwar = sim->numWarriors;
#endif

#ifdef HARDCODED_CONSTANTS
  unsigned int core_sz = HC_CORESIZE;
  unsigned int pspace_sz = HC_PSPACESIZE;
  unsigned int cycles = HC_MAXCYCLES * HC_WARRIORS;
  unsigned int max_proc = HC_MAXPROCESSES;
  unsigned int nwar = HC_WARRIORS;
#endif

  insn_t *const core = sim->coreMem;
  insn_t **const queue_end = sim->queueMem + nwar * max_proc + 1;
  insn_t **const queue_start = sim->queueMem;
  insn_t *const core_end = core + core_sz;  // point after last instruction
  int alive_cnt = nwar;
  int max_alive_proc = nwar * max_proc;

  /*
   * misc.
   */
#if DEBUG >= 1
  insn_t insn;          /* used for disassembly */
  char debug_line[256]; /* ditto */
#endif

  // TODO: this bit is a bit hard to grok, and should be cleaned
  // it initializes the warTab
  sim->warTab[0].succ = &sim->warTab[nwar - 1];
  sim->warTab[nwar - 1].pred = &sim->warTab[0];
  {
    uint32_t ftmp = 0; /* temps */
    insn_t **pofs = queue_end - 1;
    do {
      int t = nwar - 1 - ftmp;
      if (t > 0) sim->warTab[t].succ = &(sim->warTab[t - 1]);
      if (t < nwar - 1) sim->warTab[t].pred = &(sim->warTab[t + 1]);
      pofs -= max_proc;
      *pofs = &(core[war_pos_tab[ftmp]]);
      sim->warTab[t].head = pofs;
      sim->warTab[t].tail = pofs + 1;
      sim->warTab[t].nProcs = 1;
      sim->warTab[t].id = ftmp;
      ftmp++;
    } while (ftmp < nwar);
  }

  /*******************************************************************
   * Main loop - optimize here
   */
  w_t *w = &sim->warTab[nwar - 1];
  do {
    /* 'in' field of current insn for decoding */
    uint32_t in;

    /* A register values */
    uint32_t ra_a, ra_b;

    /* B register values */
    uint32_t rb_a, rb_b;

    insn_t *pta;
    insn_t *ptb;
    unsigned int mode;

    insn_t *ip = *(w->head);
    if (++(w->head) == queue_end) w->head = queue_start;
    in = ip->in; /* note: flags must be unset! */
#if !SIM_STRIP_FLAGS
    in = in & iMASK; /* strip flags. */
#endif
    rb_a = ra_a = ip->a;
    rb_b = ip->b;

#if DEBUG >= 1
    insn = *ip;
    dis1(debug_line, insn, core_sz);
#endif

    mode = in & mMASK;

    /* a-mode calculation */
    if (mode == IMMEDIATE) {
      /*printf("IMMEDIATE\n");*/
      ra_b = rb_b;
      pta = ip;
    } else if (mode == DIRECT) {
      /*printf("DIRECT\n");*/
      pta = ip + ra_a;
      if (pta >= core_end) pta -= core_sz;
      ra_a = pta->a;
      ra_b = pta->b;
    } else if (mode == BINDIRECT) {
      /*printf("BINDIRECT\n");*/
      pta = ip + ra_a;
      if (pta >= core_end) pta -= core_sz;
      pta = pta + pta->b;
      if (pta >= core_end) pta -= core_sz;
      ra_a = pta->a; /* read in registers */
      ra_b = pta->b;
    } else if (mode == APOSTINC) {
      /*printf("APOSTINC\n");*/
      pta = ip + ra_a;
      if (pta >= core_end) pta -= core_sz;
      {
        field_t *f = &(pta->a);
        pta = pta + pta->a;
        if (pta >= core_end) pta -= core_sz;
        ra_a = pta->a; /* read in registers */
        ra_b = pta->b;
        INCMOD(*f);
      }
    } else if (mode == BPOSTINC) {
      /*printf("BPOSTINC\n");*/
      pta = ip + ra_a;
      if (pta >= core_end) pta -= core_sz;
      {
        field_t *f = &(pta->b);
        pta = pta + pta->b;
        if (pta >= core_end) pta -= core_sz;
        ra_a = pta->a; /* read in registers */
        ra_b = pta->b;
        INCMOD(*f);
      }
    } else if (mode == APREDEC) {
      /*printf("APREDEC\n");*/
      pta = ip + ra_a;
      if (pta >= core_end) pta -= core_sz;
      DECMOD(pta->a);
      pta = pta + pta->a;
      if (pta >= core_end) pta -= core_sz;
      ra_a = pta->a; /* read in registers */
      ra_b = pta->b;
    } else if (mode == BPREDEC) {
      /*printf("BPREDEC\n");*/
      pta = ip + ra_a;
      if (pta >= core_end) pta -= core_sz;
      DECMOD(pta->b);
      pta = pta + pta->b;
      if (pta >= core_end) pta -= core_sz;
      ra_a = pta->a; /* read in registers */
      ra_b = pta->b;
    } else { /* AINDIRECT */
      /*printf("AINDIRECT\n");*/
      pta = ip + ra_a;
      if (pta >= core_end) pta -= core_sz;
      pta = pta + pta->a;
      if (pta >= core_end) pta -= core_sz;
      ra_a = pta->a; /* read in registers */
      ra_b = pta->b;
    }

    mode = in & (mMASK << mBITS);

    /* special mov.i code to improve performance */
    if ((in & 16320) == (_OP(MOV, mI) << (mBITS * 2))) {
      if (mode == APREDEC << mBITS) {
        ptb = ip + rb_b;
        if (ptb >= core_end) ptb -= core_sz;
        DECMOD(ptb->a);
        ptb = ptb + ptb->a;
        if (ptb >= core_end) ptb -= core_sz;
      } else if (mode == DIRECT << mBITS) {
        ptb = ip + rb_b;
        if (ptb >= core_end) ptb -= core_sz;
      } else if (mode == APOSTINC << mBITS) {
        ptb = ip + rb_b;
        if (ptb >= core_end) ptb -= core_sz;
        {
          field_t *f = &(ptb->a);
          ptb = ptb + *f;
          if (ptb >= core_end) ptb -= core_sz;
          INCMOD(*f);
        }
      } else if (mode == BPREDEC << mBITS) {
        ptb = ip + rb_b;
        if (ptb >= core_end) ptb -= core_sz;
        DECMOD(ptb->b);
        ptb = ptb + ptb->b;
        if (ptb >= core_end) ptb -= core_sz;
      } else if (mode == IMMEDIATE << mBITS) {
        ptb = ip;
      } else if (mode == BPOSTINC << mBITS) {
        ptb = ip + rb_b;
        if (ptb >= core_end) ptb -= core_sz;
        {
          field_t *f = &(ptb->b);
          ptb = ptb + *f;
          if (ptb >= core_end) ptb -= core_sz;
          INCMOD(*f);
        }
      } else if (mode == BINDIRECT << mBITS) {
        ptb = ip + rb_b;
        if (ptb >= core_end) ptb -= core_sz;
        ptb = ptb + ptb->b;
        if (ptb >= core_end) ptb -= core_sz;
      } else { /* AINDIRECT */
        ptb = ip + rb_b;
        if (ptb >= core_end) ptb -= core_sz;
        ptb = ptb + ptb->a;
        if (ptb >= core_end) ptb -= core_sz;
      }
      ptb->a = ra_a;
      ptb->b = ra_b;
      ptb->in = pta->in;
      IPINCMOD(ip);
      queue(ip);
      goto noqueue;
    }

    /*15360:
     *              0  0  1  1  1  1  0  0  0  0  0  0  0  0  0  0
     * bit         15 14 13 12 11 10  9  8  7  6  5  4  3  2  1  0
     * field   | flags | |- op-code  -| |-.mod-| |b-mode| |a-mode|
     */
    if (!(in & 15360)) {
      if (mode == IMMEDIATE << mBITS) {
      } else if (mode == DIRECT << mBITS) {
      } else if (mode == BPOSTINC << mBITS) {
        ptb = ip + rb_b;
        if (ptb >= core_end) ptb -= core_sz;
        INCMOD(ptb->b);
      } else if (mode == BPREDEC << mBITS) {
        ptb = ip + rb_b;
        if (ptb >= core_end) ptb -= core_sz;
        DECMOD(ptb->b);
      } else if (mode == APREDEC << mBITS) {
        ptb = ip + rb_b;
        if (ptb >= core_end) ptb -= core_sz;
        DECMOD(ptb->a);
      } else if (mode == APOSTINC << mBITS) {
        ptb = ip + rb_b;
        if (ptb >= core_end) ptb -= core_sz;
        INCMOD(ptb->a);
      } /* BINDIRECT, AINDIRECT */

      /* spl instruction */
      if (in & 512) {
        IPINCMOD(ip);
        queue(ip);
        if (w->nProcs < max_proc) {
          ++w->nProcs;
          queue(pta);
        }
        /* in the endgame, check if a tie is inevitable */
        if (cycles < max_alive_proc) {
          w_t *w_iterator = w->succ;

          /* break if all warriors have more processes than cycles */
          while ((w_iterator->nProcs * alive_cnt > cycles) && (w_iterator != w))
            w_iterator = w_iterator->succ;
          if (w_iterator->nProcs * alive_cnt > cycles) {
            /*printf("stopping at %d\n", cycles);*/
            goto out;
          }
        }
      } else {
      die:
        if (--w->nProcs) goto noqueue;
        w->pred->succ = w->succ;
        w->succ->pred = w->pred;
        *death_tab++ = w->id;
        cycles = cycles - cycles / alive_cnt; /* nC+k -> (n-1)C+k */
        max_alive_proc = alive_cnt * max_proc;
        if (--alive_cnt <= 1) goto out;
      }
      goto noqueue;
    }

    /* b-mode calculation */
    if (mode == APREDEC << mBITS) {
      /*printf("APREDEC\n");*/
      ptb = ip + rb_b;
      if (ptb >= core_end) ptb -= core_sz;
      DECMOD(ptb->a);
      ptb = ptb + ptb->a;
      if (ptb >= core_end) ptb -= core_sz;
      rb_a = ptb->a; /* read in registers */
      rb_b = ptb->b;
    } else if (mode == DIRECT << mBITS) {
      /*printf("DIRECT\n");*/
      ptb = ip + rb_b;
      if (ptb >= core_end) ptb -= core_sz;
      rb_a = ptb->a;
      rb_b = ptb->b;
    } else if (mode == APOSTINC << mBITS) {
      /*printf("APOSTINC\n");*/
      ptb = ip + rb_b;
      if (ptb >= core_end) ptb -= core_sz;
      {
        field_t *f = &(ptb->a);
        ptb = ptb + ptb->a;
        if (ptb >= core_end) ptb -= core_sz;
        rb_a = ptb->a; /* read in registers */
        rb_b = ptb->b;
        INCMOD(*f);
      }
    } else if (mode == BPREDEC << mBITS) {
      /*printf("BPREDEC\n");*/
      ptb = ip + rb_b;
      if (ptb >= core_end) ptb -= core_sz;
      DECMOD(ptb->b);
      ptb = ptb + ptb->b;
      if (ptb >= core_end) ptb -= core_sz;
      rb_a = ptb->a; /* read in registers */
      rb_b = ptb->b;
    } else if (mode == IMMEDIATE << mBITS) {
      /*printf("IMMEDIATE\n");*/
      ptb = ip;
    } else if (mode == BPOSTINC << mBITS) {
      /*printf("BPOSTINC\n");*/
      ptb = ip + rb_b;
      if (ptb >= core_end) ptb -= core_sz;
      {
        field_t *f = &(ptb->b);
        ptb = ptb + ptb->b;
        if (ptb >= core_end) ptb -= core_sz;
        rb_a = ptb->a; /* read in registers */
        rb_b = ptb->b;
        INCMOD(*f);
      }
    } else if (mode == BINDIRECT << mBITS) {
      /*printf("BINDIRECT\n");*/
      ptb = ip + rb_b;
      if (ptb >= core_end) ptb -= core_sz;
      ptb = ptb + ptb->b;
      if (ptb >= core_end) ptb -= core_sz;
      rb_a = ptb->a; /* read in registers */
      rb_b = ptb->b;
    } else { /* AINDIRECT */
      /*printf("AINDIRECT\n");*/
      ptb = ip + rb_b;
      if (ptb >= core_end) ptb -= core_sz;
      ptb = ptb + ptb->a;
      if (ptb >= core_end) ptb -= core_sz;
      rb_a = ptb->a; /* read in registers */
      rb_b = ptb->b;
    }

#if DEBUG == 2
    /* Debug output */
    printf("%6d %4ld  %s  |%4d, d %4ld,%4ld a %4d,%4d b %4d,%4d\n", cycles,
           ip - core, debug_line, w->nProcs, pta - core, ptb - core, ra_a, ra_b,
           rb_a, rb_b);
#endif

    /*
     * Execute the instruction on opcode.modifier
     */

    switch (in >> (mBITS * 2)) {
      case _OP(MOV, mA):
        ptb->a = ra_a;
        break;
      case _OP(MOV, mF):
        ptb->a = ra_a;
      case _OP(MOV, mB):
        ptb->b = ra_b;
        break;
      case _OP(MOV, mAB):
        ptb->b = ra_a;
        break;
      case _OP(MOV, mX):
        ptb->b = ra_a;
      case _OP(MOV, mBA):
        ptb->a = ra_b;
        break;

      case _OP(MOV, mI):
        printf("unreachable code reached. You have a problem!\n");
        break;

      case _OP(DJN, mBA):
      case _OP(DJN, mA):
        DECMOD(ptb->a);
        if (rb_a == 1) break;
        queue(pta);
        goto noqueue;

      case _OP(DJN, mAB):
      case _OP(DJN, mB):
        DECMOD(ptb->b);
        if (rb_b == 1) break;
        queue(pta);
        goto noqueue;

      case _OP(DJN, mX):
      case _OP(DJN, mI):
      case _OP(DJN, mF):
        DECMOD(ptb->a);
        DECMOD(ptb->b);
        if (rb_a == 1 && rb_b == 1) break;
        queue(pta);
        goto noqueue;

      case _OP(ADD, mI):
      case _OP(ADD, mF):
        ADDMOD(ptb->b, ra_b, rb_b);
      case _OP(ADD, mA):
        ADDMOD(ptb->a, ra_a, rb_a);
        break;
      case _OP(ADD, mB):
        ADDMOD(ptb->b, ra_b, rb_b);
        break;
      case _OP(ADD, mX):
        ADDMOD(ptb->a, ra_b, rb_a);
      case _OP(ADD, mAB):
        ADDMOD(ptb->b, ra_a, rb_b);
        break;
      case _OP(ADD, mBA):
        ADDMOD(ptb->a, ra_b, rb_a);
        break;

      case _OP(JMZ, mBA):
      case _OP(JMZ, mA):
        if (rb_a) break;
        queue(pta);
        goto noqueue;

      case _OP(JMZ, mAB):
      case _OP(JMZ, mB):
        if (rb_b) break;
        queue(pta);
        goto noqueue;

      case _OP(JMZ, mX):
      case _OP(JMZ, mF):
      case _OP(JMZ, mI):
        if (rb_a || rb_b) break;
        queue(pta);
        goto noqueue;

      case _OP(SUB, mI):
      case _OP(SUB, mF):
        SUBMOD(ptb->b, rb_b, ra_b);
      case _OP(SUB, mA):
        SUBMOD(ptb->a, rb_a, ra_a);
        break;
      case _OP(SUB, mB):
        SUBMOD(ptb->b, rb_b, ra_b);
        break;
      case _OP(SUB, mX):
        SUBMOD(ptb->a, rb_a, ra_b);
      case _OP(SUB, mAB):
        SUBMOD(ptb->b, rb_b, ra_a);
        break;
      case _OP(SUB, mBA):
        SUBMOD(ptb->a, rb_a, ra_b);
        break;

      case _OP(SEQ, mA):
        if (ra_a == rb_a) IPINCMOD(ip);
        break;
      case _OP(SEQ, mB):
        if (ra_b == rb_b) IPINCMOD(ip);
        break;
      case _OP(SEQ, mAB):
        if (ra_a == rb_b) IPINCMOD(ip);
        break;
      case _OP(SEQ, mBA):
        if (ra_b == rb_a) IPINCMOD(ip);
        break;

      case _OP(SEQ, mI):
        if (pta->in != ptb->in) break;
      case _OP(SEQ, mF):
        if (ra_a == rb_a && ra_b == rb_b) IPINCMOD(ip);
        break;
      case _OP(SEQ, mX):
        if (ra_a == rb_b && ra_b == rb_a) IPINCMOD(ip);
        break;

      case _OP(SNE, mA):
        if (ra_a != rb_a) IPINCMOD(ip);
        break;
      case _OP(SNE, mB):
        if (ra_b != rb_b) IPINCMOD(ip);
        break;
      case _OP(SNE, mAB):
        if (ra_a != rb_b) IPINCMOD(ip);
        break;
      case _OP(SNE, mBA):
        if (ra_b != rb_a) IPINCMOD(ip);
        break;

      case _OP(SNE, mI):
        if (pta->in != ptb->in) {
          IPINCMOD(ip);
          break;
        }
        /* fall through */
      case _OP(SNE, mF):
        if (ra_a != rb_a || ra_b != rb_b) IPINCMOD(ip);
        break;
      case _OP(SNE, mX):
        if (ra_a != rb_b || ra_b != rb_a) IPINCMOD(ip);
        break;

      case _OP(JMN, mBA):
      case _OP(JMN, mA):
        if (!rb_a) break;
        queue(pta);
        goto noqueue;

      case _OP(JMN, mAB):
      case _OP(JMN, mB):
        if (!rb_b) break;
        queue(pta);
        goto noqueue;

      case _OP(JMN, mX):
      case _OP(JMN, mF):
      case _OP(JMN, mI):
        if (rb_a || rb_b) {
          queue(pta);
          goto noqueue;
        }
        break;

      case _OP(JMP, mA):
      case _OP(JMP, mB):
      case _OP(JMP, mAB):
      case _OP(JMP, mBA):
      case _OP(JMP, mX):
      case _OP(JMP, mF):
      case _OP(JMP, mI):
        queue(pta);
        goto noqueue;

      case _OP(SLT, mA):
        if (ra_a < rb_a) IPINCMOD(ip);
        break;
      case _OP(SLT, mAB):
        if (ra_a < rb_b) IPINCMOD(ip);
        break;
      case _OP(SLT, mB):
        if (ra_b < rb_b) IPINCMOD(ip);
        break;
      case _OP(SLT, mBA):
        if (ra_b < rb_a) IPINCMOD(ip);
        break;
      case _OP(SLT, mI):
      case _OP(SLT, mF):
        if (ra_a < rb_a && ra_b < rb_b) IPINCMOD(ip);
        break;
      case _OP(SLT, mX):
        if (ra_a < rb_b && ra_b < rb_a) IPINCMOD(ip);
        break;

      case _OP(MODM, mI):
      case _OP(MODM, mF):
        if (ra_a) ptb->a = rb_a % ra_a;
        if (ra_b) ptb->b = rb_b % ra_b;
        if (!ra_a || !ra_b) goto die;
        break;
      case _OP(MODM, mX):
        if (ra_b) ptb->a = rb_a % ra_b;
        if (ra_a) ptb->b = rb_b % ra_a;
        if (!ra_b || !ra_a) goto die;
        break;
      case _OP(MODM, mA):
        if (!ra_a) goto die;
        ptb->a = rb_a % ra_a;
        break;
      case _OP(MODM, mB):
        if (!ra_b) goto die;
        ptb->b = rb_b % ra_b;
        break;
      case _OP(MODM, mAB):
        if (!ra_a) goto die;
        ptb->b = rb_b % ra_a;
        break;
      case _OP(MODM, mBA):
        if (!ra_b) goto die;
        ptb->a = rb_a % ra_b;
        break;

      case _OP(MUL, mI):
      case _OP(MUL, mF):
        ptb->b = (rb_b * ra_b) % core_sz;
      case _OP(MUL, mA):
        ptb->a = (rb_a * ra_a) % core_sz;
        break;
      case _OP(MUL, mB):
        ptb->b = (rb_b * ra_b) % core_sz;
        break;
      case _OP(MUL, mX):
        ptb->a = (rb_a * ra_b) % core_sz;
      case _OP(MUL, mAB):
        ptb->b = (rb_b * ra_a) % core_sz;
        break;
      case _OP(MUL, mBA):
        ptb->a = (rb_a * ra_b) % core_sz;
        break;

      case _OP(DIV, mI):
      case _OP(DIV, mF):
        if (ra_a) ptb->a = rb_a / ra_a;
        if (ra_b) ptb->b = rb_b / ra_b;
        if (!ra_a || !ra_b) goto die;
        break;
      case _OP(DIV, mX):
        if (ra_b) ptb->a = rb_a / ra_b;
        if (ra_a) ptb->b = rb_b / ra_a;
        if (!ra_b || !ra_a) goto die;
        break;
      case _OP(DIV, mA):
        if (!ra_a) goto die;
        ptb->a = rb_a / ra_a;
        break;
      case _OP(DIV, mB):
        if (!ra_b) goto die;
        ptb->b = rb_b / ra_b;
        break;
      case _OP(DIV, mAB):
        if (!ra_a) goto die;
        ptb->b = rb_b / ra_a;
        break;
      case _OP(DIV, mBA):
        if (!ra_b) goto die;
        ptb->a = rb_a / ra_b;
        break;

      case _OP(NOP, mI):
      case _OP(NOP, mX):
      case _OP(NOP, mF):
      case _OP(NOP, mA):
      case _OP(NOP, mAB):
      case _OP(NOP, mB):
      case _OP(NOP, mBA):
        break;

      case _OP(LDP, mA):
        ptb->a = UNSAFE_PSPACE_GET(w->id, ra_a % pspace_sz);
        break;
      case _OP(LDP, mAB):
        ptb->b = UNSAFE_PSPACE_GET(w->id, ra_a % pspace_sz);
        break;
      case _OP(LDP, mBA):
        ptb->a = UNSAFE_PSPACE_GET(w->id, ra_b % pspace_sz);
        break;
      case _OP(LDP, mF):
      case _OP(LDP, mX):
      case _OP(LDP, mI):
      case _OP(LDP, mB):
        ptb->b = UNSAFE_PSPACE_GET(w->id, ra_b % pspace_sz);
        break;

      case _OP(STP, mA):
        UNSAFE_PSPACE_SET(w->id, rb_a % pspace_sz, ra_a);
        break;
      case _OP(STP, mAB):
        UNSAFE_PSPACE_SET(w->id, rb_b % pspace_sz, ra_a);
        break;
      case _OP(STP, mBA):
        UNSAFE_PSPACE_SET(w->id, rb_a % pspace_sz, ra_b);
        break;
      case _OP(STP, mF):
      case _OP(STP, mX):
      case _OP(STP, mI):
      case _OP(STP, mB):
        UNSAFE_PSPACE_SET(w->id, rb_b % pspace_sz, ra_b);
        break;

#if DEBUG > 0
      default:
        alive_cnt = -1;
        goto out;
#endif
    }

    IPINCMOD(ip);
    queue(ip);
  noqueue:
    w = w->succ;
  } while (--(cycles) > 0);

out:
#if DEBUG == 1
  printf("cycles: %d\n", cycles);
#endif

  return alive_cnt;
}
