;redcode-94nop
;name BlitZ
;kill BlitZ
;author P.Kline
;assert CORESIZE == 8000
;strategy cds f-scanner with speed trick
;strategy switch to dat-bomb a'la HSA
;strategy kills most wimps

vStep  equ    (4747)
scnw   dat    scnl          ,0
       dat    0             ,0
scnc   mov.x  #scna+vStep*2 ,scnw
       mov    *scns         ,>scnw
scan   add.a  #vStep+1      ,scnc
scnl   jmz.f  -1            ,{scnc
scna   slt.a  #scns-scnc-1  ,scnc
       djn.a  scan          ,>scns
       djn.a  scnc          ,*scnw
       dat    0             ,0
       dat    0             ,0
scns   spl    #0            ,{0
       end    scnl

