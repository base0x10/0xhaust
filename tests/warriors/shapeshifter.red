;redcode-94
;name Shapeshifter
;author Anton Marsden
;assert CORESIZE==8000
;kill Shapeshifter

;Not sure where this paper is from

pStep    equ     (7*3754)
pStep2   equ     (1303+7*1021)

pGo      mov     <pCopy       ,{pCopy
        spl     2            ,<qb1
qtab2    spl     1            ,<qb2
        spl     1            ,<qb3
        mov     <pCopy       ,{pCopy
pCopy    spl     1+7+4000     ,1+7
        mov     <1           ,{1
        spl     2000+7       ,7
pPap     spl     @0           ,>pStep
        mov     }pPap        ,>pPap
        mov     {pPap        ,<1
        spl     @0           ,>pStep2
        mov.i   #6000-1-2667 ,}2667
        mov.i   >0           ,}0


null     dat     0            ,0


       for     6
       dat     0,              0
       rof

       for     22
       dat     0,              0
       rof

;-------qscan constants----------------------
zero    equ     qbomb
qtab3   equ     qbomb

qbomb   dat     >qoff,          >qc2

       dat     zero-1,         qa1
qtab1   dat     zero-1,         qa2

space    equ (4-40*127)
boot     equ (30*127+50)
dv       equ (c0+58)

dvins    mov   101,{1               ; pretty good bomb

qc2 equ ((1 + (qtab3-qptr)*qy) % CORESIZE)
qb1 equ ((1 + (qtab2-1-qptr)*qy) % CORESIZE)
qb2 equ ((1 + (qtab2-qptr)*qy) % CORESIZE)
qb3 equ ((1 + (qtab2+1-qptr)*qy) % CORESIZE)
qa1 equ ((1 + (qtab1-1-qptr)*qy) % CORESIZE)
qa2 equ ((1 + (qtab1-qptr)*qy) % CORESIZE)

qz equ 2108
qy equ 243

qgo sne qptr + qz*qc2, qptr + qz*qc2 + qb2
seq <qtab3, qptr + qz*(qc2-1) + qb2
jmp q0, }q0
sne qptr + qz*qa2, qptr + qz*qa2 + qb2
seq <qtab1, qptr + qz*(qa2-1) + qb2
jmp q0, {q0
sne qptr + qz*qa1, qptr + qz*qa1 + qb2
seq <(qtab1-1), qptr + qz*(qa1-1) + qb2
djn.a q0, {q0
sne qptr + qz*qb3, qptr + qz*qb3 + qb3
seq <(qtab2+1), qptr + qz*(qb3-1) + (qb3-1)
jmp q0, }q1
sne qptr + qz*qb1, qptr + qz*qb1 + qb1
seq <(qtab2-1), qptr + qz*(qb1-1) + (qb1-1)
jmp q0, {q1
sne qptr + qz*qb2, qptr + qz*qb2 + qb2
seq <qtab2, qptr + qz*(qb2-1) + (qb2-1)
jmp q0
seq >qptr, qptr + qz + (qb2-1)
jmp q2, <qptr
seq qptr+(qz+1)*(qc2-1),qptr+(qz+1)*(qc2-1)+(qb2-1)
jmp q0, }q0
seq qptr+(qz+1)*(qa2-1),qptr+(qz+1)*(qa2-1)+(qb2-1)
jmp q0, {q0
seq qptr+(qz+1)*(qa1-1),qptr+(qz+1)*(qa1-1)+(qb2-1)
djn.a q0, {q0
jmn.f q0, qptr + (qz+1)*(qb2-1) + (qb2-1)

boot2: spl      1, sm+1
     mov.i    <boot2, {dest
     mov.i    <boot2, {dest
     mov.i    <boot2, {dest
     mov.i    <boot2, {dest
     mov.i    <boot2, {dest
dest: djn.b    away, #2
     dat 0,0

; DAMAGE INCORPORATED

away equ -1000

step     equ   54
count    equ   2000
gate EQU (sp-7)

sp       spl   #-1-step,#-step   ; spl half of the incendiary
in       sub   #step+step,1
msm      mov   sm,*tgt+(step*count)-17228
msp      mov   sp,@msm           ; bomb alternately with spl & mov
tgt      jmz.b in,#0             ; bombed with spl to start clear
clr      mov   wipe,>gate
cp       djn.f clr,>gate
wipe     dat   <2667,wipe-gate+2 ; not sure if <2667 is used in the Hill
     dat   0,0                  ; version
sm       mov   step+1,>step+1    ; mov half of the incendiary

qoff  equ -87
qstep equ -7
qtime equ 14

q0   mul.b  *2,     qptr
q2   sne    {qtab1, @qptr
q1   add.b  qtab2,  qptr
    mov    qtab3,  @qptr
qptr mov    qbomb,  }qz
    sub    #qstep, qptr
    djn    -3,     #qtime
    jmp pGo, <400

END qgo

