;redcode-94nop
;name Song of the blue sea
;author Miz
;assert 1
push equ 3677
sboot equ first+5590
iboot equ first+5220
back equ (sboot)-(iboot)-3
position equ iboot+push+4
step equ 3364
first    equ     qbomb

qtab3   equ     qbomb
qbomb   dat     >qoff           , >qc2
stone: spl #-step, <step
        mov >-step, step+1
        add -2, -1
        jmp -2, <step-3
       dat $0, $0
        bomb: dat #0, #-7

for 5
dat $0, $0
rof
        dat     0, <qb1
qtab2   dat     0, <qb2
        dat     0, <qb3
for 5
dat $0, $0
rof

ipump:  spl #0, #0
        add.f #1334, 1
        spl imp1-2668+push, >2641
        jmp back, >-1
for 5
dat $0, $0
rof

imp1:   mov.i #2667, *0
imp2:   mov.i #5, 2667

for 10
dat $0, $0
rof

boot: mov.i bomb, a+sboot-2
spl 1, <position+9
spl 1, <position+1334+9
mov.i <b, {a
mov.i <c, {b
mov.i imp1, <-4
mov.i imp2, <-4
a djn.b sboot+4, #1
b spl iboot+4, stone+4
c  jmp *-1, ipump+4

for 5
dat $0, $0
rof
        dat    first-1           , qa1
qtab1   dat    first-1           , qa2

for 7
dat $0, $0
rof

qc2     equ ((1+(qtab3-qptr)*qy)%CORESIZE)
qb1     equ ((1+(qtab2-1-qptr)*qy)%CORESIZE)
qb2     equ ((1+(qtab2-qptr)*qy)%CORESIZE)
qb3     equ ((1+(qtab2+1-qptr)*qy)%CORESIZE)
qa1     equ ((1+(qtab1-1-qptr)*qy)%CORESIZE)
qa2     equ ((1+(qtab1-qptr)*qy)%CORESIZE)
qz      equ 2108
qy      equ 243         ;qy*(qz-1)=1


;q0 mutation
qgo     sne     qptr+qz*qc2     , qptr+qz*qc2+qb2
        seq     <qtab3          , qptr+qz*(qc2-1)+qb2
        jmp     q0              , }q0
        sne     qptr+qz*qa2     , qptr+qz*qa2+qb2
        seq     <qtab1          , qptr+qz*(qa2-1)+qb2
        jmp     q0              , {q0
        sne     qptr+qz*qa1     , qptr+qz*qa1+qb2
        seq     <(qtab1-1)      , qptr+qz*(qa1-1)+qb2
        djn.a   q0              , {q0
                                        ;q1 mutation
        sne     qptr+qz*qb3     , qptr+qz*qb3+qb3
        seq     <(qtab2+1)      , qptr+qz*(qb3-1)+(qb3-1)
        jmp     q0              , }q1
        sne     qptr+qz*qb1     , qptr+qz*qb1+qb1
        seq     <(qtab2-1)      , qptr+qz*(qb1-1)+(qb1-1)
        jmp     q0              , {q1

        sne     qptr+qz*qb2     , qptr+qz*qb2+qb2
        seq     <qtab2          , qptr+qz*(qb2-1)+(qb2-1)
        jmp     q0
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
        jmz.f   boot             , qptr+(qz+1)*(qb2-1)+(qb2-1)

qoff    equ     -86
qstep   equ     -7
qtime   equ     19

q0      mul.b   *2              , qptr
q2      sne     {qtab1          , @qptr
q1      add.b   qtab2           , qptr
        mov     qtab3           , @qptr
qptr    mov     qbomb           , }qz
        sub     #qstep          , qptr
        djn     -3              , #qtime
        djn.f   boot             , #0
end qgo

