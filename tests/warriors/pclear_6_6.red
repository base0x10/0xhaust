;redcode-94
;name pclear 6 6
;author Steve Gunnell
;assert 1

STEP1  equ  6494
STEP2  equ  4792
GAP1   equ  7228
STEP3  equ  3227
STEP4  equ  5296
GAP2   equ  149
STEP5  equ  5305
STEP6  equ  2032
GAP3   equ  7278

     org    go2

go2  spl    1  ,0
     mov    -1 ,0
     mov    -1 ,0

     spl    STEP3      ,0
     mov    >-1        ,}-1
     mov    >-2        ,}-2
     mov    >-3        ,}-3

h3   spl    GAP3       ,0
     mov    >p3        ,}h3
     mov    <p3        ,{j3
     mov    <p3        ,{j3
j3   jmp.b  STEP5      ,0
p3   spl    #25        ,#0
     add.a  #2667      ,p3
     mov.i  b3         ,*p3
     jmp    -2         ,<p3-20
b3   dat    #5         ,#1

     end 

