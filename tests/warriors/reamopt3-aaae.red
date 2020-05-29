;redcode-94
;name REAMer C 219
;author Steve Gunnell
;strategy imp ring generating paper (Maybe).
;strategy Easter 2016
;assert 1

        ORG        start

MARK   equ 6558
STEP1  equ 3639
STEP2  equ 1187
STEP3  equ 7412
HOP    equ 2449
R1     equ (2+1)
IMPNUM equ (2353) ; 5


start  spl  start2,}MARK
       spl  1, <MARK ;
mov -1,0 ;
spl  1,}MARK ; 6 ; 7
       spl    STEP1 ,0
mov.i  >-1   ,}-1
mov.i  >-2 , }-2
mov.i  >-3 , }-3 ; 17
loop1:
       spl    @0    ,>STEP2
mov.i  }-1   ,>-1
mov.i  }-2  ,>-2 ; 8
       mov.i bomb1,}MARK ; 5
       mov.i {loop1,<2
mov.i {loop1,<1
jmz.a   @0,IMPNUM+1 ; 28
bomb1:
       dat  #1, #1 ; 0

        dat.f   $0 , $0

start2:
       spl  2, <MARK ;
spl  2,>1 ;
spl  1,}MARK; 5 ; 6
loop2:
       spl    @0    ,STEP2
mov.i  }-1   ,>-1 ; 0
       mov.i bomb2,<1
jmp  -1, <STEP3 ; 22
bomb2:
       mov.i  #1, <1 ; 4

        END
