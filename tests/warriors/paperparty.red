;redcode-94
;name pApEr PaRtY
;author G.Labarga
;assert 1

;strategy	MiniQ^3->paper
;strategy	Kills reepicheep nicely

;--------- Paper constants ---
	DEST1 EQU 7133
	DEST2 EQU 2920
	DEST3 EQU 3010
	AT1 EQU 3808
	AT2 EQU 5544
	AT3 EQU 7424

LCH:	SPL 1,{900
	SPL 1,{1801
	SPL 1,{3702
	MOV <1,{1
	SPL *1592,PAP3+1	;1592 ;2696
PAP1:	SPL @0,<DEST1
	MOV }PAP1,>PAP1
PAP2:	SPL DEST2,0
	MOV >PAP2,}PAP2
	MOV.I <-AT1,<AT1
	MOV.I <-AT2,<AT2
	MOV <PAP2,{PAP3
PAP3:	DJN.F @DEST3,<AT3
FOR 40
	DAT 0,0
ROF

     qf equ qKil
     qs equ (qd*2)
     qd equ 107
     qi equ 7
     qr equ 11

;    -+)>] 0/1 cycles [(<+-

qGo: seq   qd+qf+qs,    qf+qs      ; 1
     jmp   qSki,        {qd+qf+qs+qi
     seq   qd+qf+6*qs,  qf+6*qs    ; B
     jmp   qFas,        {qd+qf+6*qs+qi
     seq   qd+qf+5*qs,  qf+5*qs    ; B-1
     jmp   qFas,        <qBmb
     seq   qd+qf+7*qs,  qf+7*qs    ; B+1
     jmp   qFas,        >qBmb
     seq   qd+qf+9*qs,  qf+9*qs    ; A-1
     djn   qFas,        {qFas
     seq   qd+qf+10*qs, qf+10*qs   ; A
     jmp   qFas,        {qFas

;    -+>)] 2 cycles [(<+-

     seq   qd+qf+3*qs,  qf+3*qs    ; C
     jmp   >qFas,       {qd+qf+3*qs+qi
     seq   qd+qf+2*qs,  qf+2*qs    ; C-1
     jmp   >qFas,       {qSlo
     seq   qd+qf+4*qs,  qf+4*qs    ; C+1
     jmp   >qFas,       }qSlo
     seq   qd+qf+12*qs, qf+12*qs   ; B*C-B
     jmp   qSlo,        {qSlo
     seq   qd+qf+15*qs, qf+15*qs   ; B*C-C
     jmp   qSlo,        <qBmb
     seq   qd+qf+21*qs, qf+21*qs   ; B*C+C
     jmp   qSlo,        >qBmb
     seq   qd+qf+24*qs, qf+24*qs   ; B*C+B
     jmp   qSlo,        }qSlo
     seq   qd+qf+27*qs, qf+27*qs   ; A*C-C
     djn   qSlo,        {qFas
     seq   qd+qf+30*qs, qf+30*qs   ; A*C
     jmp   qSlo,        {qFas
     sne   qd+qf+18*qs, qf+18*qs   ; B*C
     jmz.f LCH,         qd+qf+18*qs-10

qSlo:mul.ab #3,         qKil       ; C=3
qFas:mul.b qBmb,        @qSlo
qSki:sne   >3456,       @qKil
     add   #qd,         qKil
qLoo:mov   qBmb,        @qKil
qKil:mov   qBmb,        *qs
     sub   #qi,         qKil
     djn   qLoo,        #qr
     jmp   LCH,         >10        ; A=10
qBmb:dat   {qi*qr-10,   {6         ; B=6
FOR (MAXLENGTH-CURLINE)
	DAT 1,1
ROF
	end qGo

