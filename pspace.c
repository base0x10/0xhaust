#include "pspace.h"
#include <stdint.h>
#include <jemalloc/jemalloc.h>
#include <string.h>

field_t pspace_get(const pspace_t *p, uint32_t paddr) {
  paddr = paddr % p->len;
  return paddr == 0 ? p->lastresult : p->mem[paddr];
}

void pspace_set(pspace_t *p, uint32_t paddr, field_t val) {
  paddr = paddr % p->len;
  if (paddr == 0) {
    p->lastresult = val;
  } else {
    p->mem[paddr] = val;
  }
}

void pspace_clear(pspace_t *p) {
  p->lastresult = 0;
  memset(p->mem, 0, sizeof(field_t) * p->len);
}

void pspace_free(pspace_t *p) {
  if (p) {
    if (p->ownmem) {
      free(p->ownmem);
    }
    free(p);
  }
}

pspace_t *pspace_alloc(uint32_t pspacesize) {
  pspace_t *p;
  if ((p = (pspace_t *)calloc(1, sizeof(pspace_t)))) {
    p->len = pspacesize;
    if (!(p->ownmem = (field_t *)calloc(p->len, sizeof(field_t)))) {
      pspace_free(p);
      p = NULL;
    }
    p->mem = p->ownmem;
  }
  return p;
}

void pspace_share(const pspace_t *shared, pspace_t *sharer) {
  sharer->mem = shared->mem;
}

void pspace_privatise(pspace_t *p) { p->mem = p->ownmem; }
