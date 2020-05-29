;redcode-94nop test
;name Crystal Clear Beta
;author Anton Marsden
;strategy Anti-spiral core clear
;assert CORESIZE==8000

OFFSET EQU (btm-gate+3)
STARTOFF EQU 205

gate  dat OFFSET+2*2667+STARTOFF,OFFSET+2667+STARTOFF
      dat 0,0
sw    dat cc, 0
dgate spl #0,OFFSET+1+STARTOFF
      mov.i  *sw, >gate
      mov.i  *sw, }gate
btm   djn.f  -2, >dgate
      dat OFFSET+4000, OFFSET
cc    spl #OFFSET, #OFFSET+2*2667-1
     
END dgate


