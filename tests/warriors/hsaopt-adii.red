;redcode-94
;name Tiptoe A 109
;author Steve Gunnell
;strategy HSA testbed
;assert 1

STEP  equ   5
COUNT equ   39
PSTEP equ   5926
ptr   equ   (bomb-17)

bomb dat {1, <1
kill mov   bomb     ,<ptr
mptr mov   >ptr     ,>ptr
     jmn.f kill     ,>ptr
a    add   #STEP+1  ,@mptr
scan jmz.f a        ,<ptr
     slt   @mptr    ,#btm-ptr+3
     djn   kill     ,@mptr
     djn   a        ,#COUNT
     spl    #btm    ,PSTEP
     add.ab #379    ,-1
     mov.i  *-2     ,>-2
     djn.f  -2      ,>-3
     dat    #4      ,#5
btm  spl    #4      ,#6
     end    a
