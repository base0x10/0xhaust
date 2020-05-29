;redcode-94nop
;name Rusty
;author John Metcalf
;strategy scanner / bomber -> scan directed clear
;assert CORESIZE==8000

      step   equ (-536)
      gate   equ (scan-4)

scan mov    sbmb,   >ptr
      add    inc,    ptr
      jmz.f  scan,   *ptr

ptr  mov.ab #step+1,#1-step
inc  sub.b  #step,  #-step-1
      djn    scan,   ptr

sbmb spl    #1,     1
clr  mov    dbmb,   >gate
      djn.f  clr,    {gate
dbmb dat    1,      3-gate

      end    scan+2

