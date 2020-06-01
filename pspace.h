#ifndef PSPACE_H
#define PSPACE_H

#include "stdint.h"
#include "types.h"

typedef struct pspace_st {
  field_t lastresult; /* p-space location 0. */
  field_t *mem;       /* current p-space locations 1..PSPACESIZE-1.
                         unit offset array. */
  field_t *ownmem;    /* private locations 1..PSPACESIZE-1. */
  uint32_t len;
} pspace_t;

pspace_t *pspace_alloc(uint32_t pspacesize);
/* Allocate a p-space. */

void pspace_free(pspace_t *p);
/* Free a p-space. */

/*-- Accessing a p-space. */

field_t pspace_get(const pspace_t *p, uint32_t paddr);
/* Get value at p-space address paddr. */

void pspace_set(pspace_t *p, uint32_t paddr, field_t val);
/* Set p-space cell at paddr to val. */

void pspace_clear(pspace_t *p);
/* Set all p-space locations to 0. */

void pspace_share(const pspace_t *shared, pspace_t *sharer);
/* Field accesses to sharer go to shared. */

void pspace_privatise(pspace_t *p);
/* Reset contents of p to its private ones. */

#endif /* PSPACE_H */
