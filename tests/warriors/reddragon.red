;redcode-94nop
;name Red Dragon
;author John Metcalf
;strategy stone/imp
;assert CORESIZE==8000

        zero   equ qbomb
        qtab3  equ qbomb

qbomb   dat    >qoff,        >qc2

        dat    0,            0

; stone/imp is Uninvited with a new step

wgo     spl    2,            }qb1
qtab2   spl    1,            }qb2
        spl    1,            }qb3

        mov    {iPtr,        {iPos
        mov    {sPtr,        {sPos
sPos:   djn    sBoot+6,      #6
iPos:   jmp    iBoot+6,      >1000

        for    8
        dat    0,            0
        rof

        dat    zero-1,       qa1
qtab1   dat    zero-1,       qa2

        for    17
        dat    0,            0
        rof

        sBoot equ (uPtr+6000)
        iBoot equ (sBoot+uStp*3)

        uStp   equ 5799
        uTim   equ 1099

sPtr:   spl    #6,         #0
uLp:    mov    uBmb,       @uPtr
uHit:   sub.x  #uStp*2,    @uLp
uPtr:   mov    {3694,      }uHit+2*uStp*uTim
        djn.f  @uHit,      }uPtr
uBmb:   dat    <uStp,      >1

        iStep equ 2667

iPtr:   djn    #6,         #5
iPmp:   spl    #iImp,      >-20
        sub.f  #-iStep-1,  iJmp
        mov    iImp,       }iPmp
iJmp:   jmp    iImp-2*(iStep+1),>iImp+2*iStep-1
iImp:   mov.i  #iStep/2,   iStep

        for    17
        dat    0,            0
        rof

; Q^5 (extended Q^4) by David Houston optimized by Roy van Rijn

qc2     equ ((1+(qtab3-qptr)*qy)%CORESIZE)
qb1     equ ((1+(qtab2-1-qptr)*qy)%CORESIZE)
qb2     equ ((1+(qtab2-qptr)*qy)%CORESIZE)
qb3     equ ((1+(qtab2+1-qptr)*qy)%CORESIZE)
qa1     equ ((1+(qtab1-1-qptr)*qy)%CORESIZE)
qa2     equ ((1+(qtab1-qptr)*qy)%CORESIZE)

qy      equ 5931
qz      equ 3972

;q0 mutation
qgo     sne     qptr+qz*qa1     , qptr+qz*qa1+qb2
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
;no mutation
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
;no mutation
        jmz.f   wgo             , qptr+(qz+1)*(qb2-1)+(qb2-1)

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
        jmp     wgo             , <855

        end     qgo

