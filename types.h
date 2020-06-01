#ifndef TYPES_H
#define TYPES_H

#include "stdint.h"

/*
 * types.h
 *
 * This file defines the types used by exhaust-0x10.
 * To use the exhaust simulator within your own system, you should
 * be able to redefine these types (e.g. to add fields) so long as you
 * retain the fields which are used in sim.c and asm.c, and those fields
 * are still able to contain all valid values
 *
 * This file is part of exhaust, a memory array redcode simulator
 * Copyright (C) 2002 M Joonas Pilaja
 * Public Domain
 *
 * Copyright (C) 2020 Joseph Espy
 * Public Domain
 *
 */

/* max length for a compilied warrior */
#define MAXLENGTH 100

/* field_t holds values 0..CORESIZE-1 */
/* 8000 coresize requires at least 13 bits */
typedef uint16_t field_t;

/*
 * Instructions in core:
 */
typedef struct insn_st {
  field_t a, b; /* a-value, b-value */
  uint16_t in;  /* flags, opcode, modifier, a- and b-modes */
} insn_t;

/*
 * Warrior struct
 */
typedef struct warrior_st {
  insn_t code[MAXLENGTH]; /* code of warrior */
  unsigned int len;       /* length of -"- */
  unsigned int start;     /* start relative to first insn */

  int have_pin; /* does warrior have pin? */
  uint32_t pin; /* pin of warrior or garbage. */

  /* info fields -- these aren't automatically set or used */
  char *name;
  int no; /* warrior no. */
} warrior_t;

#endif  // TYPES_H
