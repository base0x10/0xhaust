;redcode-94
;name Octavo B16
;author Steve Gunnell
;strategy Paper
;assert 1

STEP1  equ  (3924)
STEP2  equ  (6203)
STEP3  equ  (1110)
IMP    equ  (1110+1)
AVAL   equ  (IMP*(0+2))

START  SPL.B  $     1, $     0     
       SPL.B  $     1, $     0     
       SPL.B  $     1, $     0     
       SPL.B  @     0, # STEP1     
       MOV.I  }    -1, >    -1     
       SPL.B  @     0, # STEP2     
       MOV.I  }    -1, >    -1     
       SPL.B  @     0, # STEP3     
       MOV.I  }    -1, >    -1     
BOMB   MOV.I  #-AVAL  , }IMP

       end    START
