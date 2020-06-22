# $Id: Makefile,v 1.7 2003/07/13 10:23:18 martinus Exp $

CC = clang
CFLAGS = ${OPT} ${DBG} ${TRACINGDBG}
OPT = -O3 -fomit-frame-pointer -Werror -Wall -Wno-unused-variable -Wno-unused-label
# DBG = -g -fsanitize=address
# TRACINGDBG = -DDEBUG=2

LD = 
EXECUTABLES = 0xhaust

all: ${EXECUTABLES}

0xhaust: sim.o asm.o 0xhaust.c
	${CC} ${CFLAGS} -o 0xhaust sim.o asm.o 0xhaust.c ${LD}

asm.o:	asm.c
	${CC} ${CFLAGS} -c asm.c

sim.o: sim.c
	${CC} ${CFLAGS} -c sim.c

format:
	clang-format -i -style=Google *.h *.c

clean:
	rm -f *~ *.o core ${EXECUTABLES}
