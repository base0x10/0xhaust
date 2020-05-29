;redcode-94nop
;name Daisy
;author Christian Schmidt
;strategy bomber/imp test
;assert CORESIZE == 8000

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

;-------------------------------------------

        dat     0,              0
qbomb   dat     >qoff,          >qc2

;------ 45 instructions --------------------

step    equ     54
count   equ     2000
gate    equ     (sp-7)
iStep   equ     2667

sBoo    equ     3851;1640
iBoo    equ     3964;1090
time    equ     67

;--11+10+6
pboot   spl     1,              sm+1
        mov.i   <pboot,         {sGo
        mov.i   <pboot,         {sGo
        mov.i   <pboot,         {sGo
        mov.i   <pboot,         {sGo
        mov.i   <pboot,         {sGo
        mov.i   <iGo,           {iGo
        mov.i   <iGo,           {iGo
        mov.i   <iGo,           {iGo
sGo     djn     zero+sBoo,      #1
iGo     jmp     zero+iBoo,      iImp+1


sp      spl     #-1-step,       #-step 
in      sub     #step+step,     1
msm     mov     sm,*tgt+(step*count)-17228
msp     mov     sp,             @msm          
tgt     jmz.b   in,             #0 
clr     mov     wipe,           >gate
cp      djn.f   clr,            >gate
wipe    dat     <2667,          wipe-gate+2
        dat     0,              0 
sm      mov     step+1,         >step+1


sPtr:   djn   #0,          #time
iPmp:   spl   #iImp,       >-20
        sub.f #-iStep-1,   iJmp
        mov   iImp,        }iPmp
iJmp:   jmp   iImp-2*(iStep+1),>iImp+2*iStep-1
iImp:   mov.i #iStep/2,    iStep

        for     18
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
    jmp q0,          }4443   ;extra attack
    seq >qptr,       qptr+qz+(qb2-1)
    jmp q2,          <qptr
seq qptr+(qz+1)*(qc2-1),qptr+(qz+1)*(qc2-1)+(qb2-1)
    jmp q0,          }q0
seq qptr+(qz+1)*(qa2-1),qptr+(qz+1)*(qa2-1)+(qb2-1)
    jmp q0,          {q0
seq qptr+(qz+1)*(qa1-1),qptr+(qz+1)*(qa1-1)+(qb2-1)
    djn.a q0,        {q0
    jmz.f pboot,     qptr+(qz+1)*(qb2-1)+(qb2-1)

q0    mul.b  *2,     qptr
q2    sne    {qtab1, @qptr
q1    add.b  qtab2,  qptr
      mov    qtab3,  @qptr
qptr  mov    qbomb,  }qz
      sub    #qstep, qptr
      djn    -3,     #qtime
      jmp    pboot,  }3256   ;extra attack

end qgo

