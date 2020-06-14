/* sim.h: prototype
 * $Id: sim.h,v 1.3 2003/06/06 21:31:15 martinus Exp $
 */
#ifndef SIM_H
#define SIM_H

// #define SINGLE_THREADED_API 1
// #define HARDCODED_CONSTANTS

// TODO: you also cannot have both HARDCODED and SINGLETHREADED at the same time
// fix this #define HARDCODED_CONSTANTS 1
// #define SINGLE_THREADED_API 1

/* Should we hardcode koth contstants?  By default no */
#ifdef HARDCODED_CONSTANTS
#define HC_CORESIZE 8000
#define HC_PSPACESIZE 500
#define HC_MAXCYCLES 80000
#define HC_MAXPROCESSES 8000
#define HC_WARRIORS 2
#define HC_MAXLENGTH 100
#endif

#include "pspace.h"
#include "types.h"

/*  INTERNAL SIMULATOR STRUCTURES */

/* warrior internal representation */
typedef struct _warrior_st {
  insn_t **tail;            /* next free location to queue a process */
  insn_t **head;            /* next process to run from queue */
  struct _warrior_st *succ; /* next warrior alive */
  uint32_t nProcs;          /* number of live processes in this warrior */
  struct _warrior_st *pred; /* previous warrior alive */
  int id;                   /* index (or identity) of warrior */
} w_t;

/* Internal simulator state */
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

/*  THREAD SAFE API DECLARATION */

#ifndef SINGLE_THREADED_API

/*
 * Allocates a simulator object
 * with sim_clear_core, multiple rounds with the same parameters can be executed
 * within the same simulator.
 *
 * You can ignore pspaces if your warriors do not make use of pspace
 */
SimState_t *sim_alloc(unsigned int nwar, unsigned int coresize,
                      unsigned int processes, unsigned int cycles,
                      unsigned int pspace);

/*
 * Free memory associated with a simulator object
 */
void sim_free(SimState_t *sim);

/*
 * Reset a core to be reused for another round or another battle
 */
void sim_reset_round(SimState_t *sim);

void sim_reset_battle(SimState_t *sim);
/*
 * memcpys in a warrior.  Keep track of pos to be used in war_pos_tab
 */
int sim_load_warrior(SimState_t *sim, unsigned int pos,
                     const insn_t *const code, unsigned int len);

/*
 * runs a single round.
 * war_pos_tab is an array nwars long for the first instr to be executed for
 * each warrior.
 *
 * death tab similarly records at index 0 the first warrior to die, index 1 the
 * second etc
 *
 * returns number of living warriors
 */
int sim_simulate(SimState_t *sim, field_t *war_pos_tab,
                 unsigned int *death_tab);

/*
 * Refer to README for how to use pspace functions
 */
pspace_t **sim_get_pspaces(SimState_t *sim);

pspace_t *sim_get_pspace(SimState_t *sim, unsigned int nwar);

void sim_clear_pspaces(SimState_t *sim);

void sim_reset_pspaces(SimState_t *sim);
#endif /* not SINGLE_THREADED_API */

#ifdef SINGLE_THREADED_API
insn_t *sim_alloc_bufs(unsigned int nwar, unsigned int coresize,
                       unsigned int processes, unsigned int cycles);

insn_t *sim_alloc_bufs2(unsigned int nwar, unsigned int coresize,
                        unsigned int processes, unsigned int cycles,
                        unsigned int pspace);

void sim_free_bufs();

void sim_clear_core(void);

pspace_t **sim_get_pspaces(void);

pspace_t *sim_get_pspace(unsigned int war_id);

void sim_clear_pspaces(void);

void sim_reset_pspaces(void);

int sim_load_warrior(unsigned int pos, insn_t const *code, unsigned int len);

int sim(int nwar_arg, field_t w1_start, field_t w2_start, unsigned int cycles,
        void **ptr_result);

int sim_mw(unsigned int nwar, const field_t *war_pos_tab,
           unsigned int *death_tab);
#endif

#endif /* SIM_H */
