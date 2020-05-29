;redcode-94
;name Quadrophenia
;author Steve Gunnell
;assert 1

STEP   equ 451

bptr   dat.f  0        ,4000
sptr   dat.f  0        ,0
       dat.f  0        ,0
start  spl    scan
bloop  mov.i  cbomb    ,>bptr
       mov.i  cbomb    ,>bptr
       jmn    -2       , bptr
dclr   mov    #30      , bptr
       spl    0        ,>bptr
       mov.i  dbomb    ,>bptr
       djn.f  -1       ,>bptr
dbomb  dat     0       ,#20
cbomb  spl    #0       ,#0
scan   add.ab #STEP    ,sptr
       jmz.f  scan     ,@sptr
       slt.b  sptr     ,#30
       mov.b  sptr     ,bptr
       jmn    scan     ,sptr
       jmp    dclr
end start
