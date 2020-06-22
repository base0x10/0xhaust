/* sim.h: prototype
 * $Id: sim.h,v 1.3 2003/06/06 21:31:15 martinus Exp $
 */
#ifndef SIM_H
#define SIM_H

/* Should we hardcode koth contstants?  By default no */
#ifdef HARDCODED_CONSTANTS
#define HC_CORESIZE 8000
#define HC_PSPACESIZE 500
#define HC_MAXCYCLES 80000
#define HC_MAXPROCESSES 8000
#define HC_WARRIORS 2
#define HC_MAXLENGTH 100
#endif

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
  unsigned int cycles;
  unsigned int maxProcesses;
  unsigned int numWarriors;
  w_t *warTab;
  insn_t *coreMem;
  insn_t **queueMem;
#endif

  /* If we do hardcode parameters, our struct does not dynamically allocate
   * anything */
#ifdef HARDCODED_CONSTANTS
  /* numeric constants like coreSize etc are taken from #defines */
  w_t warTab[HC_WARRIORS];
  insn_t coreMem[HC_CORESIZE];
  insn_t *queueMem[HC_WARRIORS * HC_MAXPROCESSES + 1];
#endif

} SimState_t;

/*  THREAD SAFE API DECLARATION */

/*
 * Allocates a simulator object
 * with sim_clear_core, multiple rounds with the same parameters can be executed
 * within the same simulator.
 *
 * You can ignore pspaces if your warriors do not make use of pspace
 */
SimState_t *sim_alloc(unsigned int nwar, unsigned int coresize,
                      unsigned int processes, unsigned int cycles);

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
int sim_simulate(SimState_t *sim, const field_t *const war_pos_tab,
                 unsigned int *death_tab);
#endif /* SIM_H */
