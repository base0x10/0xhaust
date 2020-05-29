;redcode-94nop
;name SDC
;author Anton Marsden
;strategy SPL/DAT core clear (multi-pass d-clear)
;assert CORESIZE==8000

gate dat 4000, 205

        dat 0,0

s      spl #0, >gate-2667
       mov.i  *cc, >gate
       mov.i  *cc, >gate
       djn.f    -2, >gate

       dat 0,0

db   dat  0, cc-gate+3
cc    spl  #1, cc-gate+1
       spl  #0, cc-gate


END s


