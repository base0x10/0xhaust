;redcode-94nop quiet
;author Roy van Rijn
;name Agg!
;strategy Scanner with SLT.F self-check
;assert 1

zero    equ     qbomb

qtab3   equ     qbomb
qbomb   dat     >qoff           , >qc2

        dat     0               , 0
        dat     1               , }qb1
qtab2   dat     1               , }qb2
        dat     1               , }qb3

for     12
        dat     0               , 0
rof
        dat     zero-1          , qa1
qtab1   dat     zero-1          , qa2

for     15
        dat     0               , 0
rof

sStep   equ     3179
sOff1   equ     4361
sOff2   equ     sOff1+7985
cLen    equ     6

cPtr    dat     0               , 0

        dat     0               , 0

sPtr    dat     sOff1           , sOff2

for     4
        dat     0               , 0
rof

sAdd    spl     #sStep          , {sStep
        mov.i   sBomb           , >cPtr
        mov.i   *-1             , }cPtr
cLength djn.a   -2              , cCnt

sLoop   add.f   sAdd            , @iPtr
wGo     sne.i   *sPtr           , @sPtr
iPtr    add.f   *-2             , sPtr
        seq.i   *sPtr           , @sPtr

        slt.f   sSelf           , @iPtr

sCnt    djn.b   sLoop           , #1219

        mov.i   @iPtr           , @cLength-1
cCnt    add.ba  #2              , #cLen
        jmn.b   cLength-2       , sCnt
        djn.a   {-1             , <-3

for     2
        dat     0               , 0
rof

sSelf   dat     {26             , <26
sBomb   spl     #1              , }1

for     6
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
        jmz.f   wGo             , qptr+(qz+1)*(qb2-1)+(qb2-1)

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
        jmp     wGo             , {4370
end qgo

