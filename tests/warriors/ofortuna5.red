;redcode-94nop verbose
;name O_Fortuna5
;author Nenad Tomasev
;assert CORESIZE==8000
;strategy scanner
;strategy
;strategy O Fortuna, velut luna, statu variabilis
;strategy Semper crescis aut decrescis; vita detestabilis
;strategy nunc, obdurat et tunc curat ludo mentis aciem
;strategy egestatem, potestatem dissolvit ut glaciem.
;strategy Sors immanis et inanis, rota tu volubilis,
;strategy Status malus, vana salus semper dissolubilis
;strategy Obumbrata, et velata michi quoque niteris;
;strategy Nunc per ludum dorsum nudum fero tui sceleris.
;strategy Sors salutis et virtutis michi nunc contraria,
;strategy est affectus et defectus semper in angaria.
;strategy Hac in hora sine mora corde pulsum tangite;
;strategy quod per sortem sternit fortem, mecum omnes plangite!

k equ 35
step equ (16*((2*k)+1))
count equ 498
ini equ ((scan-1)-count*step)

c1 equ 287
cdiv equ 45
c equ c1+(8*cdiv)
scbd equ 5738
coffdiv equ 76
coff equ !(8*coffdiv)
gate equ (clear-3)
clinioff equ 2307
clini equ !(coff+clinioff)

zero equ qbomb
qtab3 equ qbomb

 org qgo
qbomb   dat >qoff, >qc2
 dat 0, 0
 spl #gate+1, {qb1
qtab2 spl #cb+1, {qb2
 spl #cb+1+scbd+coff, {qb3

boot mov {(qtab2-1), {sgo
 mov {qtab2, {qtab2+1
 mov {(qtab2-1), {sgo
 mov {qtab2, {qtab2+1
 djn.b boot, #3
 mov {(qtab2-1), {sgo
 mov {qtab2, {qtab2+1
sgo djn.f *(gate+1+scbd), {c

 for 4
 dat 0, 0
 rof

        dat zero-1, qa1
qtab1   dat zero-1, qa2

 for 10
 dat 0, 0
 rof

aim dat 1, clini
scan seq.f ini, }ini+8
 mov.ab scan, @shoot
inc sub.x clear+coff, scan
shoot mov cb+coff, >aim
loop jmn.b scan, @shoot
 jmp clear+coff, }200
 dat 0, 0
 dat 0, 0
clear spl #-step, >-step
 mov.i b, >gate
 djn.f -1, >gate
b dat <2667, (b-gate+2)
 dat 0, 0
 dat 0, 0
cb spl #1, 1

 for 20
 dat 0, 0
 rof


qc2 equ ((1+(qtab3-qptr)*qy)%CORESIZE)
qb1 equ ((1+(qtab2-1-qptr)*qy)%CORESIZE)
qb2 equ ((1+(qtab2-qptr)*qy)%CORESIZE)
qb3 equ ((1+(qtab2+1-qptr)*qy)%CORESIZE)
qa1 equ ((1+(qtab1-1-qptr)*qy)%CORESIZE)
qa2 equ ((1+(qtab1-qptr)*qy)%CORESIZE)
qz equ 2108
qy equ 243         ;qy*(qz-1)=1


;q0 mutation
qgo     sne qptr+qz*qc2, qptr+qz*qc2+qb2
        seq <qtab3, qptr+qz*(qc2-1)+qb2
        jmp q0, }q0
        sne qptr+qz*qa2, qptr+qz*qa2+qb2
        seq <qtab1, qptr+qz*(qa2-1)+qb2
        jmp q0, {q0
        sne qptr+qz*qa1, qptr+qz*qa1+qb2
        seq <(qtab1-1), qptr+qz*(qa1-1)+qb2
        djn.a q0, {q0
                                        ;q1 mutation
        sne qptr+qz*qb3, qptr+qz*qb3+qb3
        seq <(qtab2+1), qptr+qz*(qb3-1)+(qb3-1)
        jmp q0, }q1
        sne qptr+qz*qb1, qptr+qz*qb1+qb1
        seq <(qtab2-1), qptr+qz*(qb1-1)+(qb1-1)
        jmp q0, {q1

        sne qptr+qz*qb2, qptr+qz*qb2+qb2
        seq <qtab2, qptr+qz*(qb2-1)+(qb2-1)
        jmp q0
                                        ;qz mutation
        seq >qptr, qptr+qz+(qb2-1)
        jmp q2, <qptr
                                        ;q0 mutation
        seq qptr+(qz+1)*(qc2-1), qptr+(qz+1)*(qc2-1)+(qb2-1)
        jmp q0, }q0
        seq qptr+(qz+1)*(qa2-1), qptr+(qz+1)*(qa2-1)+(qb2-1)
        jmp q0, {q0
        seq qptr+(qz+1)*(qa1-1), qptr+(qz+1)*(qa1-1)+(qb2-1)
        djn.a q0, {q0
        jmz.f boot, qptr+(qz+1)*(qb2-1)+(qb2-1)

qoff equ -86
qstep equ -7
qtime equ 19

q0      mul.b *2, qptr
q2      sne {qtab1, @qptr
q1      add.b qtab2, qptr
        mov qtab3, @qptr
qptr    mov qbomb, }qz
        sub #qstep, qptr
        djn -3, #qtime
        djn.f boot, #0
 end

