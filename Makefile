# $Id: Makefile,v 1.7 2003/07/13 10:23:18 martinus Exp $

CC = clang
CFLAGS = ${OPT} ${DBG}
OPT = -O3 -fomit-frame-pointer -Werror -Wall -Wno-unused-variable -Wno-unused-label
LEGACY_BUILD = -DSINGLE_THREADED_API
# DBG = -g -DDEBUG=2

LD = 
EXECUTABLES = exhaust 0xhaust

all: ${EXECUTABLES}

0xhaust: sim.o asm.o pspace.o 0xhaust.c
	${CC} ${CFLAGS} -o 0xhaust sim.o asm.o pspace.o 0xhaust.c ${LD}

exhaust: legacy_sim.o asm.o pspace.o exhaust.c
	${CC} ${CFLAGS} ${LEGACY_BUILD} -o exhaust legacy_sim.o asm.o pspace.o exhaust.c ${LD}

asm.o:	asm.c
	${CC} ${CFLAGS} -c asm.c

pspace.o: pspace.c
	${CC} ${CFLAGS} -c pspace.c

sim.o: sim.c
	${CC} ${CFLAGS} -c sim.c

legacy_sim.o:	sim.c
	${CC} ${CFLAGS} ${LEGACY_BUILD} -c sim.c -o legacy_sim.o

format:
	clang-format -i -style=Google *.h *.c

clean:
	rm -f *~ *.o core ${EXECUTABLES}
