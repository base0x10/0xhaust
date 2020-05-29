;redcode-94
;name Heimdal A 125
;author Steve Gunnell
;strategy Yet another scanner.
;assert 1

STEP   equ    709


bptr   dat    0        ,4000
for 2
       dat.f  $0       ,$0
rof
sptr   dat    bomb     ,0
for 1
       dat.f  $0       ,$0
rof
clear  mov.i  *sptr    ,>bptr
for 2
       mov.i  *sptr    ,>bptr
rof
       jmn.f  clear    ,@bptr
for 4
       dat.f  $0       ,$0
rof
scan   add.ab #STEP    ,sptr
       jmz.f  scan     ,@sptr
       slt.b  sptr     ,#tail-sptr
       mov.b  sptr     ,bptr
       spl    clear
       jmn.b  scan     ,sptr
       jmp    scan     ,}sptr
bomb   spl    #0       ,}0
for 1
       dat 0, 0
rof
for 1
       dat.f  $0       ,$0
rof
tail   dat.f  $0       ,$0

end    scan

