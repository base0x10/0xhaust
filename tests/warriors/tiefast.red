;redcode-94nop
;name Tie Fast!!!
;author Christian Schmidt
;strategy qscanner, silk with dwarf satellite
;strategy and a separate imp-launcher
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

;-------------------------------------------

istep   equ     2667

iAwa    equ     1740
iAwa1   equ     2986
iAwa2   equ     3321
pBoo1   equ     6416

pStep1  equ     1866
sStep1  equ     1584
sStep2  equ     967
sStep3  equ     476
dStep1  equ     4923

;-------------------------------------------

        dat     0,              0
qbomb   dat     >qoff,          >qc2

;------ 45 instructions --------------------
;137.50

pGo     mov.i   imp1,           zero+iAwa1
        mov.i   imp2,           zero+iAwa2
        mov.i   <iEnd+1,        {iBoo
        spl     1,              <6590
        spl     1,              <2019
        mov     <pSt,           {pSt
pSt     spl     pEnd+pBoo1+2,   cs+1
        mov.i   <iEnd+1,        {iBoo
iBoo    djn.f   zero+iAwa,      <1453

        for     5
        dat     0,              0
        rof

inc     spl     #istep,         istep
loop    add     inc,            ptr
        spl     2,              <7746
ptr     jmp     iAwa1-iAwa-1,   iAwa2-iAwa-1
iEnd    djn.f   @ptr,           <dStep1


        for     6
        dat     0,              0
        rof

stn     spl     #0,             <sStep3 
        mov     {sStep1,        {sStep2 
        add.f   {0,             }0 
pEnd    djn.f   @0,             {-2 

        for     5
        dat     0,              0
        rof

imp2    mov.i   #1,     istep

        for     3
        dat     0,              0
        rof

imp1    mov.i   #istep, *0 


c0      spl     @0,             pStep1 
        mov     }-1,            >-1 
        mov     <1,             {1 
cs      jmz.a   pStep1-pBoo1,   -pBoo1 

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
    jmp q0,          }5342   ;extra attack

    seq >qptr,       qptr+qz+(qb2-1)
    jmp q2,          <qptr

seq qptr+(qz+1)*(qc2-1),qptr+(qz+1)*(qc2-1)+(qb2-1)
    jmp q0,          }q0

seq qptr+(qz+1)*(qa2-1),qptr+(qz+1)*(qa2-1)+(qb2-1)
    jmp q0,          {q0

seq qptr+(qz+1)*(qa1-1),qptr+(qz+1)*(qa1-1)+(qb2-1)
    djn.a q0,        {q0

    jmz.f pGo,       qptr+(qz+1)*(qb2-1)+(qb2-1)

q0    mul.b  *2,     qptr
q2    sne    {qtab1, @qptr
q1    add.b  qtab2,  qptr
      mov    qtab3,  @qptr
qptr  mov    qbomb,  }qz
      sub    #qstep, qptr
      djn    -3,     #qtime
      jmp    pGo,    }3256   ;extra attack

end qgo

