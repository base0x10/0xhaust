;redcode-94
;name Blowtorch B 151
;author Steve Gunnell
;strategy Simple incendary bomber.
;assert 1

STEP   equ 3035
GAP    equ 1071
START  equ (hit-GAP-STEP*3492)
GAP1   equ 3
SKIP   equ (ctop-cptr+17)

cptr   dat    #0    ,#100
       dat    SKIP  ,SKIP
clbmb  dat    SKIP  ,SKIP

for GAP1
       dat.f  $0   ,$0
rof
mbmb   mov.i  GAP   ,}GAP
sbmb   spl    #1-GAP,1-GAP
throw  mov.i  sbmb  ,*START
       mov.i  mbmb  ,@throw
       add.ab #STEP ,throw
hit    djn.f   -3   ,>cptr
       mov    clbmb ,>cptr
ctop   djn.f   -1   ,>cptr

end sbmb

