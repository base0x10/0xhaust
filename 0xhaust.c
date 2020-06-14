#include "asm.h"
#include "sim.h"
#include "types.h"
#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int rand_lim(int lower, int upper) {
  /* return a random number between lower and limit inclusive.
   */

  int divisor = RAND_MAX / (upper + 1);
  int retval;

  do {
    retval = rand() / divisor;
  } while (retval + lower > upper);

  return retval + lower;
}

int main(int argc, char **argv) {
  srand(time(NULL));
  unsigned int rounds = 1;
  unsigned int cycles = 80000;
  int w2_position = -1;
  unsigned int coresize = 8000;
  unsigned int maxprocs = 8000;
  unsigned int minsep = 100;

  int opt;
  while ((opt = getopt(argc, argv, "r:c:F:s:p:d:")) != -1) {
    switch (opt) {
    case 'r':
      rounds = strtol(optarg, NULL, 10);
      break;
    case 'c':
      cycles = strtol(optarg, NULL, 10);
      break;
    case 'F':
      w2_position = strtol(optarg, NULL, 10);
      break;
    case 's':
      coresize = strtol(optarg, NULL, 10);
      break;
    case 'p':
      maxprocs = strtol(optarg, NULL, 10);
      break;
    case 'd':
      minsep = strtol(optarg, NULL, 10);
      break;
    }
  }

  if (optind == argc) {
    printf("0xhaust v0.1\n"
           "usage: 0xhaust [opts] warriors...\n"
           "0xhaust runs one-on-one round robin tournaments\n"
           "use exhaust or pmers for multiwarrior tournaments\n"
           "opts: -r <rounds>, -c <cycles>, -F <pos>, -s <coresize>, -p"
           "<maxprocs>, -d <minsep>\n");
    return 0;
  }

  int nwarriors = argc - optind;

  // precompile all warriors
  warrior_t *warriors = calloc(nwarriors, sizeof(warrior_t));
  for (int i = 0; i < nwarriors; i++) {
    asm_fname(argv[optind + i], &warriors[i], coresize);
  }
  int *tally = calloc(2 * nwarriors, sizeof(int));
  SimState_t *s = sim_alloc(2, coresize, maxprocs, cycles, coresize / 16);

  // TODO this may not work for warriors smaller than 100.  May be issues with
  // small cores or small minsep
  // TODO the apis around this should be reworked to expose minimal work between
  // rounds and between battles
  for (int i = 0; i < nwarriors; i++) {
    for (int j = i + 1; j < nwarriors; j++) {
      for (int round = 0; round < rounds; round++) {
        sim_reset_round(s);
        sim_load_warrior(s, 0, warriors[i].code, warriors[i].len);
        int w2_pos = w2_position == -1
                         ? rand_lim((warriors[j].len + minsep) % coresize,
                                    coresize - minsep)
                         : w2_position;
        sim_load_warrior(s, w2_pos, warriors[j].code, warriors[j].len);

        field_t positions[2] = {0 + warriors[i].start,
                                w2_pos + warriors[j].start};
        unsigned int results[2] = {};
        int alive_count = sim_simulate(s, positions, results);
        if (alive_count == 2) {
          tally[2 * i + 1]++;
          tally[2 * j + 1]++;
        } else if (results[0] == 0) {
          /* the first warrior died first */
          tally[2 * j]++;
        } else if (results[0] == 1) {
          /* the second warrior died first */
          tally[2 * i]++;
        } else {
          printf("Simulator error\n");
          return 1;
        }
      }
    }
    sim_reset_round(s);
  }
  for (int i = 0; i < nwarriors; i++) {
    printf("%d %d\n", tally[2 * i], tally[2 * i + 1]);
  }
}
