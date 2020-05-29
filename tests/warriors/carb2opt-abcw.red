;redcode-94
;name Bicarb Test 60
;author Steve Gunnell
;strategy Dual Carbonite stones
;assert 1

GATE equ (ctop1 - 6110)
BMB  equ (cmov1 + 1018)
CNT  equ 7742
GAP  equ 8
IGAP equ 1

ctop1  spl    #0    ,<GATE
cmov1  mov.i  BMB   ,cadd1-(BMB*CNT)
cadd1  add.ab {0    ,}0
       djn.f  cmov1 ,<GATE

for GAP
       dat.f  $0    ,$0
rof

itop   spl    #0    ,#0
       add.a  #2668 ,1
       jmp    iimp-2668 ,<GATE
iimp   mov.i  #2667 ,*0
       mov.i  #2667 ,*0
       mov.i  #2667 ,*0

for IGAP
       dat.f  $0    ,$0
rof

start  mov.i  bomb  ,*cmov1
       spl    1
       jmp.a  @1   ,}0
       dat    0     ,ctop1
       dat    0     ,itop
bomb   dat    >-1   ,>1

end start

