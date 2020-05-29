;redcode-94nop
;name pro.Verka
;author inversed
;strategy Scanner based on Provascan by Beppe Bezzi
;strategy Resurrecting ancient warrior
;strategy resulted in FSH0.3 score of 142.5
;assert CORESIZE==8000

;-------Scan--------------------------------
step    equ     (2*104+1)*8     ;mod-8
hop     equ     12
wlen    equ     20
zo      equ     -1
dest    equ     ptr-4
;-------qScan-------------------------------
f       equ     (-367)
y       equ     (-2703)

dq      equ     (y+1)%CORESIZE
qa1     equ     (1+f*(qt1-1-found))%CORESIZE
qa2     equ     (1+f*(qt1  -found))%CORESIZE
qb1     equ     (1+f*(qt2-1-found))%CORESIZE
qb2     equ     (1+f*(qt2  -found))%CORESIZE
qb3     equ     (1+f*(qt2+1-found))%CORESIZE
qc2     equ     (1+f*(qt3  -found))%CORESIZE
qt3     equ     qbomb
;-------Misc--------------------------------
bd      equ     1673
org     qgo
;-------------------------------------------

x0      dat     qb1,    0
qt2     dat     qb2,    0
       dat     qb3,    0

inc     spl     #step,  step
loop    add     inc,    ptr     ;scanned last
ptr     sne.b   zo+hop, zo
       jmp     loop,   dest
x1      mov.b   ptr,    dest
cnt     mov     #wlen,  #0      ;0
clear   mov     bomb,   >dest
       djn     clear,  cnt
       jmn     loop,   @x1     ;also some self-checking
bomb    spl     0,      0       ;0
       mov     kill,   >ptr
       djn.f   -1,     >ptr
kill    dat     <2667,  12

wgo     mov     <bp,    {bp
copy    mov     <bp,    {bp
       mov     <bp,    {bp
       mov     <bp,    {bp
       djn     copy,   #4
       nop     }bp,    0
bp      spl     x0+bd+13,       kill+1
       mov.i   #0,     {0
       dat     0,      0

       for     17
       dat     0,      0
       rof

       dat     qa1,    0
qt1     dat     qa2,    0

       for     20
       dat     0,      0
       rof

       ;q0 mutations
qgo     sne     found+dq*qc2,   found+dq*qc2+qb2
       seq     {qt3,           found+dq*(qc2-1)+qb2
       jmp     q0,             }q0

       sne     found+dq*qa1,   found+dq*qa1+qb2
       seq     {qt1-1,         found+dq*(qa1-1)+qb2
       djn.a   q0,             {q0

       sne     found+dq*qa2,   found+dq*qa2+qb2
       seq     {qt1,           found+dq*(qa2-1)+qb2
       jmp     q0,             {q0

       ;q1 mutations
       sne     found+dq*qb1,   found+dq*qb1+qb1
       seq     {qt2-1,         found+dq*(qb1-1)+(qb1-1)
       jmp     q0,             {q1

       sne     found+dq*qb3,   found+dq*qb3+qb3
       seq     {qt2+1,         found+dq*(qb3-1)+(qb3-1)
       jmp     q0,             }q1

       ;no mutation
       sne     found+dq*qb2,   found+dq*qb2+qb2
       seq     {qt2,           found+dq*(qb2-1)+(qb2-1)
       jmp     q0,             0

       ;dq mutation
       seq     >found,         found+dq+(qb2-1)
       jmp     qsel,           <found

       ;q0 mutation
       seq     found+(dq+1)*(qc2-1),   found+(dq+1)*(qc2-1)+(qb2-1)
       jmp     q0,                     }q0

       seq     found+(dq+1)*(qa2-1),   found+(dq+1)*(qa2-1)+(qb2-1)
       jmp     q0,                     {q0

       seq     found+(dq+1)*(qa1-1),   found+(dq+1)*(qa1-1)+(qb2-1)
       djn.a   q0,                     {q0

       ;free scan
       jmz.f   wgo,                    found+(dq+1)*(qb2-1)+(qb2-1)

q0      mul.ab  *q1,     found
qsel    sne     {qt1,   @found
q1      add.ab  qt2,     found

qoff    equ     -86
qtime   equ     20
qstep   equ     7

qloop   mov     qbomb,  @found
found   mov     qbomb,  >dq
       add     #qstep, found
       djn     qloop,  #qtime
       jmp     wgo,    0
qbomb   dat     {qc2,   {qoff

