;redcode-94
;name EP 802
;author Jacob Rohal
;assert 1
; evolved with -=< Maezumo >=-
; evolved:17:20:33 01-15-2012
; benchscore 141.08 (94nopWilfiz 200 rounds)
;
; ok so its not Evolved rather optimized.
; after Optimizing this i had am idea to change the constants
; to the 10-20 sequence of the fibronnacci sequence
; i thought (rather randomly) if it was used for stock markets and the shells of sea life 
; (or something like that im not sure)
; it would totally own at core war.......
; to make a really long sad story short....it didn't....
; it self terminated after the qscan executed.......=(
; yeah idea awesome in concept fail in the real world

org qgo

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

sOff    equ     4728
sStep   equ     10
sDelet  equ     205

;-------------------------------------------

        dat     0,              0
qbomb   dat     >qoff,          >qc2

;------ 45 instructions --------------------
ConA EQU  3308
ConB EQU  28
ConC EQU  1544
ConD EQU  240
ConE EQU  1094
ConF EQU  1387
ConG EQU  7022
ConH EQU  7236
ConI EQU  5138
ConK EQU  2585
     spl   1,      0
     spl   1,      0
     spl   1,      0
     spl   @0,     <ConA
     mov.i }-1,    >-1
     spl   @0,     <ConC
     mov.i }-1,    >-1
     mov.i #1,     {1
     mov   ConD,   <ConE
     mov.i {-4,    <1
     jmz.a @0,     ConF
     dat   0,      0
     dat   0,      0
     dat   0,      0
     dat   0,      0
     dat   0,      0
     dat   0,      0
     dat   0,      0
     dat   0,      0
     dat   0,      0
    for 25
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
    jmz.f qbomb+1,       qptr+(qz+1)*(qb2-1)+(qb2-1)

q0    mul.b  *2,     qptr
q2    sne    {qtab1, @qptr
q1    add.b  qtab2,  qptr
      mov    qtab3,  @qptr
qptr  mov    qbomb,  }qz
      sub    #qstep, qptr
      djn    -3,     #qtime
      jmp    qbomb+1,    }3256   ;extra attack

