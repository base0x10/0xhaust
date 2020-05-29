;redcode-94nop
;name Crystal Clear
;author Anton Marsden
;strategy Anti-spiral core clear
;assert CORESIZE==8000

OFFSET EQU (btm-gate+3)
STARTOFF EQU 205
DJNTWEAK EQU (35)

gate  dat OFFSET+2667+STARTOFF, 0
sw   dat 0,cc
dgate dat 0,OFFSET+1+STARTOFF+DJNTWEAK
     dat 0,0
s    spl #0,0
     mov.i  @sw, }gate
btm  djn.f  -1, >dgate
     dat OFFSET, 0
cc   spl #OFFSET, <2667

END s

