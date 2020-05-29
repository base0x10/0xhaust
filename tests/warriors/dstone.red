;redcode-94
;name D-Stone
;author Roy van Rijn
;strategy Its a small stone that turns into a d-clear eventualy
;strategy With a Q^3 and imp launcher now!
;assert 1

gate    dat     {-10,   <4001
        dat     0,      0
        dat     0,      0
        dat     0,      0
        dat     }4,     {0
stone   spl     0,      0
        add.ab  #2410,  gate
        mov     bmb,    >gate
        djn.f   -2,     >gate
bmb2    dat     <2667,  2-gate
bmb     mov     1,      0

for 20
        dat     0,      0
rof

ihop    equ     (2667)
iinc	equ	(-ihop-1)
idjn	equ	(ijmp+5800)
iorg	equ	(ijmp+1102)
ioff	equ	(iorg+iinc*2)

pGo     spl     stone
spin:	spl	#   0,	$   0
	sub.f	#iinc,	 ijmp
imov:	mov	 iimp,	}iimp
ijmp:	djn.f	 ioff,	{idjn
	dat	$   0,	$   0
iimp:	mov.i	#iorg,	 ihop

for 20
        dat     0,      0
rof

;constants for the quickscanner
qf 	equ 	qKil
qs      equ     200
qd 	equ 	4000
qi      equ     14
qr      equ     8
qBmb	dat    {qi*qr-10, {1
qGo  	seq    qd+qf+qs, qf+qs
     	jmp    qSki, {qd+qf+qs+qi+2
     	sne    qd+qf+5*qs, qf+5*qs
     	seq    qf+4*qs, {qTab
	jmp    qFas, }qTab
     	sne    qd+qf+8*qs, qf+8*qs
     	seq    qf+7*qs, {qTab-1
     	jmp    qFas, {qFas
	sne    qd+qf+10*qs, qf+10*qs
     	seq    qf+9*qs, {qTab+1
	jmp    qFas, }qFas
	seq    qd+qf+2*qs, qf+2*qs
	jmp    qFas, {qTab
	seq    qd+qf+6*qs, qf+6*qs
	djn.a  qFas, {qFas
	seq    qd+qf+3*qs, qf+3*qs
      jmp    qFas, {qd+qf+3*qs+qi+2
	sne    qd+qf+14*qs, qf+14*qs
	seq    qf+13*qs, <qTab
	jmp    qSlo, >qTab
	sne    qd+qf+17*qs, qf+17*qs
	seq    qf+16*qs, <qTab-1
	jmp    qSlo, {qSlo
	seq    qd+qf+11*qs, qf+11*qs
	jmp    qSlo, <qTab
	seq    qd+qf+15*qs, qf+15*qs
	djn.b  qSlo, {qSlo
	sne    qd+qf+12*qs, qf+12*qs
	jmz    pGo, qd+qf+12*qs-qi

qSlo  mov.ba qTab,   qTab
qFas  mul.ab qTab,   qKil
qSki  sne    qBmb-1, @qKil
      add    #qd,    qKil
qLoo  mov.i  qBmb,   @qKil
qKil  mov.i  qBmb,   *qs
      sub.ab #qi,    qKil
      djn    qLoo,   #qr
      jmp    pGo,    <-4000
      dat    5408,   7217
qTab  dat    4804,   6613
dSrc  dat    5810,   qBmb-5

end qGo

