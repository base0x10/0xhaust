;redcode-94nop
;name Espionage
;author Roy van Rijn
;strategy qscan to spybomber
;assert 1

zero    equ     qbomb

qtab3   equ     qbomb

qbomb   dat     >qoff           , >qc2

        dat     0               , 0
        dat     0               , }qb1
qtab2   dat     0               , }qb2
        dat     0               , }qb3

        dat     0               , 0
        dat     0               , 0
        dat     0               , 0
        dat     0               , 0
        dat     0               , 0

        vStep1  equ   7662
        vOff1   equ   7889
        cOff    equ   3614
        dTect   equ   qbomb+4525

scan    add     clr             , fang
        mov     @0              , }fang
        mov     abomb           , <fang
        jmz.f   scan            , dTect
        mov.b   dTect           , fang ;adjust clear pointer
        jmp     clr             , <fang

        dat     0               , 0

        dat     zero-1          , qa1
qtab1   dat     zero-1          , qa2

for 19
        dat     0               , 0
rof

fang    mov.ab  #vOff1          , >dTect-vOff1

        dat     0               , 0
        dat     0               , 0

sw      dat     1               , 16
g2      spl     #cOff           , 16

        dat     0               , 0
        dat     0               , 0
        dat     0               , 0

clr     spl     #vStep1         , -vStep1
        mov     *sw             , >fang
        mov     *sw             , >fang
        djn.f   -2              , }g2

for 10
        dat     0               , 0
rof

abomb   dat     <2667           , {5334

for 4
        dat     0               , 0
rof

qc2     equ ((1+(qtab3-qptr)*qy)%CORESIZE)
qb1     equ ((1+(qtab2-1-qptr)*qy)%CORESIZE)
qb2     equ ((1+(qtab2-qptr)*qy)%CORESIZE)
qb3     equ ((1+(qtab2+1-qptr)*qy)%CORESIZE)
qa1     equ ((1+(qtab1-1-qptr)*qy)%CORESIZE)
qa2     equ ((1+(qtab1-qptr)*qy)%CORESIZE)

qy      equ 5931
qz      equ 3972

;q0 mutation
qgo

        sne     qptr+qz*qa1     , qptr+qz*qa1+qb2
        seq     <(qtab1-1)      , qptr+qz*(qa1-1)+qb2
        djn.a   q0              , {q0
        sne     qptr+qz*qc2     , qptr+qz*qc2+qb2
        seq     <qtab3          , qptr+qz*(qc2-1)+qb2
        jmp     q0              , }q0
        sne     qptr+qz*qa2     , qptr+qz*qa2+qb2
        seq     <qtab1          , qptr+qz*(qa2-1)+qb2
        jmp     q0              , {q0
                                        ;q1 mutation
        sne     qptr+qz*qb3     , qptr+qz*qb3+qb3
        seq     <(qtab2+1)      , qptr+qz*(qb3-1)+(qb3-1)
        jmp     q0              , }q1
        sne     qptr+qz*qb1     , qptr+qz*qb1+qb1
        seq     <(qtab2-1)      , qptr+qz*(qb1-1)+(qb1-1)
        jmp     q0              , {q1
        sne     qptr+qz*qb2     , qptr+qz*qb2+qb2
        seq     <qtab2          , qptr+qz*(qb2-1)+(qb2-1)
        djn.f   q0              , <6907

                                        ;qz mutation
        seq     >qptr           , qptr+qz+(qb2-1)
        jmp     q2              , <qptr
                                        ;q0 mutation
        seq     qptr+(qz+1)*(qc2-1),qptr+(qz+1)*(qc2-1)+(qb2-1)
        jmp     q0              , }q0
        seq     qptr+(qz+1)*(qa2-1),qptr+(qz+1)*(qa2-1)+(qb2-1)
        jmp     q0              , {q0
        seq     qptr+(qz+1)*(qa1-1),qptr+(qz+1)*(qa1-1)+(qb2-1)
        djn.a   q0              , {q0
        jmz.f   scan+1          , qptr+(qz+1)*(qb2-1)+(qb2-1)

qoff    equ     -87
qstep   equ     -7
qtime   equ     19

q0      mul.b   *2              , qptr
q2      sne     {qtab1          , @qptr
q1      add.b   qtab2           , qptr
        mov     qtab3           , @qptr
qptr    mov     qbomb           , }qz
        sub     #qstep          , qptr
        djn     -3              , #qtime
        jmp     scan+1          , <855
end qgo

