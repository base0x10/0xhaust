;redcode-94nop
;name The Utterer TNG
;author Christian Schmidt
;strategy not sure how to call the strategy
;strategy Q^4.5b -> spreader
;assert CORESIZE==8000
;optimax sai

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

sBoo    equ     851
iBoo    equ     7152
sDst    equ     1518
iDst    equ     5206
iBmb    equ     4697
iBmb2   equ     3318
sStep1  equ     3997
sStep2  equ     5962
sStep3  equ     3274
sStep4  equ     6777

iStep   equ     2667

;-------------------------------------------

        dat     0,              0
qbomb   dat     >qoff,          >qc2

;------ 45 instructions --------------------

dDst    dat     #sBoo,          #iBoo

pGo     spl     1,              }6196
        spl     1,              }7391

sCpy    mov.i   <sSrc,          {dAwa
sAwa    spl     *dAwa,          >sSrc
iCpy    mov.i   <iSrc,          <dAwa
iAwa    spl     @dAwa,          >iSrc
        add.f   dDst,           dAwa
        djn.f   sCpy,           <1591

dAwa    dat     #sDst,          #iDst

        for     5
        dat     0,              0
        rof

        spl     #sStep1,         >sStep2
        mov     {sStep3,         {sStep4
        add     -2,             -1
pEnd    djn.f   @0,             {-2
sSrc    dat     0,              0

        for     18
        dat     0,              0
        rof


iStart  spl     #iStep,         <iBmb
        add.f   iStart,         launch
launch  djn.f   imp-iStep-1,    <iBmb2
imp     mov.i   #iStep,         *0
iSrc    dat     0,              0

        for     2
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

