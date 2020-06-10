# $Id: Makefile,v 1.7 2003/07/13 10:23:18 martinus Exp $

CC = clang
CFLAGS = ${OPT} ${DBG}
OPT = -O3 -fomit-frame-pointer -Werror -Wall -Wno-unused-variable -Wno-unused-label
CFGS = -DSINGLE_THREADED_API
# DBG = -g -DDEBUG=2

LD = 
EXECUTABLES = exhaust

all: ${EXECUTABLES}

exhaust: sim.o asm.o pspace.o exhaust.c
	${CC} ${CFLAGS} ${CFGS} -o exhaust sim.o asm.o pspace.o exhaust.c ${LD}

asm.o:	asm.c
	${CC} ${CFLAGS} ${CFGS} -c asm.c

pspace.o: pspace.c
	${CC} ${CFLAGS} ${CFGS} -c pspace.c

sim.o:	sim.c
	${CC} ${CFLAGS} ${CFGS} -c sim.c

format:
	clang-format -i -style=Google *.h *.c

clean:
	rm -f *~ *.o core ${EXECUTABLES}
