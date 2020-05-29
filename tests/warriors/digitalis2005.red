;redcode-94nop
;name Digitalis 2005
;author Christian Schmidt
;strategy Mini Q^4 -> d-clear + 7pt imps
;strategy multi-process bootstrapping
;strategy boot away the clear AND the imps
;url http://www.corewar.info
;assert 1

impsize equ     1143
cBoot   equ     3188
iBoot   equ     1841
cStart  equ     2488

zero    equ qbomb 
qtab3   equ qbomb 

qbomb   dat >qoff, >qc2 
        dat  0, 0

        spl  1, <qb1 
qtab2   spl  1, <qb2 
        spl  2, <qb3 

        djn.f   imp,            <4906 
        add.f   iDec,           -1
        djn.f   cBoot-iBoot,    <5418
iDec    nop     #impsize,       <7917
imp     mov.i   #1,             impsize ;----
        dat     0,              0
        dat     0,              0
iEnd    dat     0,              0

ptr     dat     0,              cStart
clrb    dat     >2667,          25

clear   spl     #0,             >ptr-15
loop    mov     clrb-15,        >ptr-15
cc      djn.f   loop,           >ptr-15
        dat     0,              0
        dat     0,              0
cEnd    dat     0,              0


dat zero - 1, qa1 
qtab1 dat zero - 1, qa2 

xxx equ 13

for xxx
 dat 0, 0 
 rof 


pGo     mov.i   clrb,           cEnd+cBoot-18-3
        mov.i   ptr,            cEnd+cBoot-19-3
        spl     2,              <536-xxx ;-----
        spl     1,              <5059-xxx  ;-----
        mov     -1,             0
        mov.i   {cEnd,          {cBoo
        mov.i   {iEnd,          {iBoo
        mov.i   {iEnd,          {iBoo
cBoo    spl     cEnd+cBoot,     <4469-xxx  ;-----
        spl     1,              <7831-xxx  ;-----
iBoo    djn.f   cEnd+iBoot,     <1729-xxx  ;-----

for 31-xxx
 dat 0, 0 
 rof 

qc2 equ ((1 + (qtab3-qptr)*qy) % CORESIZE) 
qb1 equ ((1 + (qtab2-1-qptr)*qy) % CORESIZE) 
qb2 equ ((1 + (qtab2-qptr)*qy) % CORESIZE) 
qb3 equ ((1 + (qtab2+1-qptr)*qy) % CORESIZE) 
qa1 equ ((1 + (qtab1-1-qptr)*qy) % CORESIZE) 
qa2 equ ((1 + (qtab1-qptr)*qy) % CORESIZE) 
qz equ 2108 
qy equ 243 
qgo sne qptr + qz*qc2, qptr + qz*qc2 + qb2 
 seq <qtab3, qptr + qz*(qc2-1) + qb2 
 jmp q0, }q0 
 sne qptr + qz*qa2, qptr + qz*qa2 + qb2 
 seq <qtab1, qptr + qz*(qa2-1) + qb2 
 jmp q0, {q0 
sne qptr + qz*qa1, qptr + qz*qa1 + qb2 
 seq <(qtab1-1), qptr + qz*(qa1-1) + qb2 
 djn.a q0, {q0 
 sne qptr + qz*qb3, qptr + qz*qb3 + qb3 
 seq <(qtab2+1), qptr + qz*(qb3-1) + (qb3-1) 
 jmp q0, }q1 
sne qptr + qz*qb1, qptr + qz*qb1 + qb1 
 seq <(qtab2-1), qptr + qz*(qb1-1) + (qb1-1) 
 jmp q0, {q1 
 sne qptr + qz*qb2, qptr + qz*qb2 + qb2 
 seq <qtab2, qptr + qz*(qb2-1) + (qb2-1) 
 jmp q0 
 seq >qptr, qptr + qz + (qb2-1) 
 jmp q2, <qptr 
seq qptr+(qz+1)*(qc2-1),qptr+(qz+1)*(qc2-1)+(qb2-1) 
 jmp q0, }q0 
seq qptr+(qz+1)*(qa2-1),qptr+(qz+1)*(qa2-1)+(qb2-1) 
 jmp q0, {q0 
seq qptr+(qz+1)*(qa1-1),qptr+(qz+1)*(qa1-1)+(qb2-1) 
 djn.a q0, {q0 
 jmz.f pGo, qptr + (qz+1)*(qb2-1) + (qb2-1) 
qoff equ -87 
qstep equ -7 
qtime equ 14 
q0 mul.b *2, qptr 
q2 sne {qtab1, @qptr 
q1 add.b qtab2, qptr 
 mov qtab3, @qptr 
qptr mov qbomb, }qz 
 sub #qstep, qptr 
 djn -3, #qtime 
 jmp pGo 
end qgo 

