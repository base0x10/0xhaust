;redcode-94
;name Lady Imperactive
;author Miz
;assert 1

STEP1         equ         939        ; TODO
STEP2         equ         1576        ; TODO
STEP3         equ        1444        ; TODO

BOMB        equ       3714

        org        qGo

; ==== PAPER

start         spl        wimp,        <-1021
        spl         1,        {3043
        spl         1,        <3402
        spl         1,        {202
        spl        second,        <1321

first        mov.i         <1,         {1
        spl         imp+1+2667, #imp+1
        dat         {1923,        <2043

second  mov.i         <1,         {1
        spl         imp+1+5334, #imp+1

third   spl          @0,         <STEP1
        mov.i        }-1,        >-1
        spl          @0,         <STEP2
        mov.i        }-1,        >-1
        spl          @0,         <STEP3
        mov.i        }-1,        >-1
        mov.i         #1,     {1
imp     mov.i         #BOMB,        2667

for 20
        dat        $0,        $0
rof

wimp        jmp        #0,        #0

for 19
        dat        $0,        $0
rof

; ============= QSCAN ==============

qf         equ         qKil
qs         equ         222
qd         equ         322
qi         equ         7
qr         equ         11


qGo         seq           qd+qf+qs,    qf+qs      ; 1
        djn.f         qSki,        {qd+qf+qs+qi
        seq           qd+qf+6*qs,  qf+6*qs    ; B
        djn.f         qFas,        {qd+qf+6*qs+qi
        seq           qd+qf+5*qs,  qf+5*qs    ; B-1
        jmp           qFas,        <qBmb
        seq           qd+qf+7*qs,  qf+7*qs    ; B+1
        jmp           qFas,        >qBmb
        seq           qd+qf+9*qs,  qf+9*qs    ; A-1
        djn           qFas,        {qFas
        seq           qd+qf+10*qs, qf+10*qs   ; A
        jmp           qFas,        {qFas


        seq           qd+qf+3*qs,  qf+3*qs    ; C
        djn.f         >qFas,       {qd+qf+3*qs+qi
        seq           qd+qf+2*qs,  qf+2*qs    ; C-1
        jmp           >qFas,       {qSlo
        seq           qd+qf+4*qs,  qf+4*qs    ; C+1
        jmp           >qFas,       }qSlo
        seq           qd+qf+12*qs, qf+12*qs   ; B*C-B
        jmp           qSlo,        {qSlo
        seq           qd+qf+15*qs, qf+15*qs   ; B*C-C
        jmp           qSlo,        <qBmb
        seq           qd+qf+21*qs, qf+21*qs   ; B*C+C
        jmp           qSlo,        >qBmb
        seq           qd+qf+24*qs, qf+24*qs   ; B*C+B
        jmp           qSlo,        }qSlo
        seq           qd+qf+27*qs, qf+27*qs   ; A*C-C
        djn           qSlo,        {qFas
        seq           qd+qf+30*qs, qf+30*qs   ; A*C
        jmp           qSlo,        {qFas
        sne           qd+qf+18*qs, qf+18*qs   ; B*C
        jmz.f         start,       qd+qf+18*qs-10

qSlo        mul           #3,          qKil       ; C=3
qFas        mul.b         qBmb,        @qSlo
qSki        sne           >qf+23*qs,   >qKil
            add           #qd,         qKil
qLoo        mov           *qKil,       <qKil
qKil        mov          qBmb,        }qs
        sub           #qi-1,       @qLoo
        djn           qLoo,        #qr
        djn.f         start  ,     #10        ; A=10
qBmb        dat           {qi*qr-10,   {6         ; B=6

        end

