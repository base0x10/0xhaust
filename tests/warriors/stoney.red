;redcode-94b
;assert 1
;name Stoney the second
;author Miz
;strategy Q^3 -> Stone w/ Imps, no boot.

step equ 1459
stone:  spl #0
	mov.i 3, step
	add.ab #step, -1
	djn.f -2, <7000
	dat >-1, }1

for 20
dat $0, $0
rof

istep equ 2667
ilaunch: spl #0, >1
	 mov.i imp, imp
	 add.a #istep+1, 1
	 djn.f imp-istep-1, <3000
	 imp: mov.i #0, istep
for 15
dat $0, $0
rof

start: spl 1, <2000
       spl 1, <4000
       spl 1, <6000
       djn.b stone, #7
       jmp ilaunch, <-3333
for 5
dat $0, $0
rof

qf     equ     qKil
qs     equ     200
qd     equ     4000
qi     equ     7
qr     equ     6
qBmb     dat       {qi*qr-10, {1
qgo      seq       qd+qf+qs, qf+qs
         jmp       qSki, {qd+qf+qs+qi+2
         sne       qd+qf+5*qs, qf+5*qs
         seq       qf+4*qs, {qTab
         jmp       qFas, }qTab
         sne       qd+qf+8*qs, qf+8*qs
         seq       qf+7*qs, {qTab-1
         jmp       qFas, {qFas
         sne       qd+qf+10*qs, qf+10*qs
         seq       qf+9*qs, {qTab+1
         jmp       qFas, }qFas
         seq       qd+qf+2*qs, qf+2*qs
         jmp       qFas, {qTab
         seq       qd+qf+6*qs, qf+6*qs
         djn.a     qFas, {qFas
         seq       qd+qf+3*qs, qf+3*qs
         jmp       qFas, {qd+qf+3*qs+qi+2
         sne       qd+qf+14*qs, qf+14*qs
         seq       qf+13*qs, <qTab
         jmp       qSlo, >qTab
         sne       qd+qf+17*qs, qf+17*qs
         seq       qf+16*qs, <qTab-1
         jmp       qSlo, {qSlo
         seq       qd+qf+11*qs, qf+11*qs
         jmp       qSlo, <qTab
         seq       qd+qf+15*qs, qf+15*qs
         djn.b     qSlo, {qSlo
         sne       qd+qf+12*qs, qf+12*qs
         jmz         start, qd+qf+12*qs-qi   
qSlo     mov.ba    qTab, qTab
qFas     mul.ab    qTab, qKil
qSki     sne     qBmb-1, @qKil
         add        #qd, qKil
qLoo     mov.i     qBmb, @qKil
qKil     mov.i     qBmb, *qs
         sub.ab     #qi, qKil
         djn       qLoo, #qr
         jmp         start, <-4000
         dat       5408, 7217
qTab     dat       4804, 6613
dSrc     dat       5810, qBmb-5
end qgo

