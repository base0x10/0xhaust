;redcode-94nop
;author Christian Schmidt
;name Fire Proof Paper
;strategy qscan, binary coreclear silk
;strategy idea is based on P. Kline's posting on rgc ;-)
;url http://www.corewar.info
;assert 1

;------------ Qscan Constant ---------------

zero    equ     qbomb
qtab3   equ     qbomb
qz      equ     2108
qy      equ     243

qc2 equ ((1 + (qtab3-qptr)*qy) % CORESIZE)
qb1 equ ((1 + (qtab2-1-qptr)*qy) % CORESIZE)
qb2 equ ((1 + (qtab2-qptr)*qy) % CORESIZE)
qb3 equ ((1 + (qtab2+1-qptr)*qy) % CORESIZE)
qa1 equ ((1 + (qtab1-1-qptr)*qy) % CORESIZE)
qa2 equ ((1 + (qtab1-qptr)*qy) % CORESIZE)

qoff    equ    -88
qstep   equ    -7
qtime   equ    20

;-------Constants for optimization----------

pStep1 equ 2712
pStep2 equ 538
pStep3 equ 2287
pAw1   equ 5701
pAw2   equ 5942

;-------------------------------------------

        dat     0,              0
qbomb   dat     >qoff,          >qc2

;------ 45 instructions --------------------
;128.11

pGo     spl     2,               <7029
        spl     1,               <6422
        spl     1,               <5437

        mov     {silk1,          {pBo1
pBo1    spl     pEnd+pAw1,       pEnd+pAw2

        mov     }pBo1,           >pBo1
pBo2    djn.f   pEnd+pAw2,       <2245

for     8
        dat     0,              0 
rof 

silk1   spl     @6,             <pStep1
        mov     }silk1,         >silk1
        mov     {silk1,         <silk2
silk2   spl     @0,             >pStep2
bomb    mov.i   #1,             <1
cc      djn.b   -1,             #pStep3
pEnd    dat     0,              0
 
for     31-8
        dat     0,              0 
rof 

;-------------------------------------------

        dat     0,              <qb1
qtab2   dat     0,              <qb2
        dat     0,              <qb3
        dat     0,              0
        dat     0,              0
        dat     0,              0
        dat     0,              0
        dat     zero-1,         qa1
qtab1   dat     zero-1,         qa2
        dat     0,              0
        dat     0,              0
        dat     0,              0
        dat     0,              0
        dat     0,              0

qgo sne qptr+qz*qc2, qptr+qz*qc2+qb2
    seq <qtab3,      qptr+qz*(qc2-1)+qb2
    jmp q0,          }q0
    sne qptr+qz*qa2, qptr + qz*qa2 + qb2
    seq <qtab1,      qptr+qz*(qa2-1)+qb2
    jmp q0,          {q0
    sne qptr+qz*qa1, qptr+qz*qa1+qb2
    seq <(qtab1-1),  qptr+qz*(qa1-1)+qb2
    djn.a q0,        {q0
    sne qptr+qz*qb3, qptr+qz*qb3+qb3
    seq <(qtab2+1),  qptr+qz*(qb3-1)+(qb3-1)
    jmp q0,          }q1
    sne qptr+qz*qb1, qptr+qz*qb1+qb1
    seq <(qtab2-1),  qptr+qz*(qb1-1)+(qb1-1)
    jmp q0,          {q1
    sne qptr+qz*qb2, qptr+qz*qb2+qb2
    seq <qtab2,      qptr+qz*(qb2-1)+(qb2-1)
    jmp q0,          }4443              ;extra attack
    seq >qptr,       qptr+qz+(qb2-1)
    jmp q2,          <qptr
seq qptr+(qz+1)*(qc2-1),qptr+(qz+1)*(qc2-1)+(qb2-1)
    jmp q0,          }q0
seq qptr+(qz+1)*(qa2-1),qptr+(qz+1)*(qa2-1)+(qb2-1)
    jmp q0,          {q0
seq qptr+(qz+1)*(qa1-1),qptr+(qz+1)*(qa1-1)+(qb2-1)
    djn.a q0,        {q0
    jmz.f pGo,       qptr+(qz+1)*(qb2-1)+(qb2-1)

q0      mul.b   *2,             qptr
q2      sne     {qtab1,         @qptr
q1      add.b   qtab2,          qptr
        mov     qtab3,          @qptr
qptr    mov     qbomb,          }qz
        sub     #qstep,         qptr
        djn     -3,             #qtime
        jmp     pGo,            }3256   ;extra attack
        dat     0,              0
        dat     0,              0
        dat     0,              0
        dat     0,              0

end qgo

