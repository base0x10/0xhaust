;redcode-94nop
;name Silklanders Faith
;author Christian Schmidt
;strategy qscanner, 8-line silk-dwarf and a/b-imp paper
;url www.corewar.info
;assert 1

zero    equ      qbomb
qtab3   equ      qbomb

pSt1    equ      1178
uStp    equ      703
uTim    equ      1183
pStep   equ      7119
dStep   equ      4985

pAw1    equ      1333
pAw2    equ      6466
i3      equ      2667
i7      equ      1143

qbomb   dat      >qoff,           >qc2
        dat      0,               0

paper   spl      1,               <qb1
qtab2   spl      1,               <qb2
        spl      1,               <qb3

        mov.i    <pBo2,           {pBo2
pBo2    spl      zero+pAw1,       uBmb+1
        mov.i    <p2Bo,           {p2Bo
p2Bo    jmp      zero+pAw2,       imp1+1

pap2    spl      @0,              <pSt1
        mov      }-1,             >-1
        spl      #0,              #0
uLp     mov      uBmb,            @uPtr
uHit    sub.x    #uStp*2,         @uLp
uPtr    mov      {3582,           }uHit+2*uStp*uTim
        djn.f    @uHit,           }uPtr
uBmb    dat      <uStp,           >1+6

for     4
        dat      0,               0 
rof

        dat      zero-1,          qa1
qtab1   dat      zero-1,          qa2

for     16
        dat      0,               0 
rof


        spl      @0,              <pStep
        mov.i    }-1,             >-1
impy    spl      #i3,             <i7
        add.f    -1,              1
        spl      imp1-8*i3,       imp2-16*i7
iSrc    djn.f    @-1,             <dStep
imp2    mov.i    #5,              i7
imp1    mov.i    #i3,             *0

     for 18
        dat      0,               0 
     rof

qc2 equ ((1 + (qtab3-qptr)*qy) % CORESIZE)
qb1 equ ((1 + (qtab2-1-qptr)*qy) % CORESIZE)
qb2 equ ((1 + (qtab2-qptr)*qy) % CORESIZE)
qb3 equ ((1 + (qtab2+1-qptr)*qy) % CORESIZE)
qa1 equ ((1 + (qtab1-1-qptr)*qy) % CORESIZE)
qa2 equ ((1 + (qtab1-qptr)*qy) % CORESIZE)
qz  equ 2108
qy  equ 243

qgo sne qptr+qz*qc2, qptr+qz*qc2+qb2
    seq <qtab3, qptr+qz*(qc2-1)+qb2
    jmp q0, }q0

    sne qptr+qz*qa2, qptr+qz*qa2+qb2
    seq <qtab1, qptr+qz*(qa2-1)+qb2
    jmp q0, {q0

    sne qptr+qz*qa1, qptr+qz*qa1+qb2
    seq <(qtab1-1), qptr+qz*(qa1-1)+qb2
    djn.a q0, {q0

    sne qptr+qz*qb3, qptr+qz*qb3+qb3
    seq <(qtab2+1), qptr+qz*(qb3-1)+(qb3-1)
    jmp q0, }q1

    sne qptr+qz*qb1, qptr+qz*qb1+qb1
    seq <(qtab2-1), qptr+qz*(qb1-1)+(qb1-1)
    jmp q0, {q1

    sne qptr+qz*qb2, qptr+qz*qb2+qb2
    seq <qtab2, qptr+qz*(qb2-1)+(qb2-1)
    jmp q0

    seq >qptr, qptr+qz+(qb2-1)
    jmp q2, <qptr

seq qptr+(qz+1)*(qc2-1),qptr+(qz+1)*(qc2-1)+(qb2-1)
    jmp q0, }q0

seq qptr+(qz+1)*(qa2-1),qptr+(qz+1)*(qa2-1)+(qb2-1)
    jmp q0, {q0

seq qptr+(qz+1)*(qa1-1),qptr+(qz+1)*(qa1-1)+(qb2-1)
    djn.a q0, {q0
    jmz.f paper, qptr+(qz+1)*(qb2-1)+(qb2-1)

qoff  equ -87
qstep equ -7
qtime equ 14

q0    mul.b  *2,     qptr
q2    sne    {qtab1, @qptr
q1    add.b  qtab2,  qptr
      mov    qtab3,  @qptr
qptr  mov    qbomb,  }qz
      sub    #qstep, qptr
      djn    -3,     #qtime
      jmp    paper

end qgo