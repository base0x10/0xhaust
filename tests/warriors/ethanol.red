;redcode-94
;name Ethanol
;author G.Labarga
;assert 1
;strategy	CH3-CH2-OH
;strategy	MiniQ^3->stone/imp
;strategy	ver 1.1 boots 7pt imp-pump and stone, (Rosebudish stone)
;strategy	ver 1.2 Modified Thunderstrike-like stone -> d-clear
;strategy	ver 1.3 better offset constants
;strategy	ver 1.4 modified stone, new boot code

	IP_LOC EQU SCL+(2*ISTEP)+1		;where the imp-pump is
	ST_LOC EQU IP_LOC-3464-11  		;where the stone is
	SG_LOC EQU ST_LOC-50
	ILOC EQU IPMP+DSTEP			;imp's first point
	ISTEP EQU 2667	;1143		;7-pt imps
	DSTEP EQU 571
	STEP EQU 268
	DIST EQU CHK+2*STEP
	GATE EQU SCL-3

SCL:	SPL #0,>GATE-140
CLR:	MOV CBM+10,>GATE
	DJN.F CLR,>GATE
;FOR 10
;	DAT 0,0
;ROF
CBM:	DAT <2667,9
;FOR 34
;	DAT 0,0
;ROF
STONE:	SPL #-2*STEP,<-2*STEP
REF:	MOV {DIST+11*STEP+1,*DIST
	MOV BMB+6,@REF
CHK:	SUB.F STONE,REF
	DJN.F @CHK,{2543	;<- This location is bombed after ~308*2 cycles
;FOR 6
;	DAT 0,0
;ROF
BMB:	DAT STEP,SCL-CHK-44	;A-field could be greater

IPMP:	SPL #ILOC,>-DSTEP-20
	MOV IMP,}IPMP
	ADD.A #ISTEP+1,IGO
IGO:	JMP IPMP+ILOC-ISTEP+2,<IPMP
IMP:	MOV.I #ISTEP,*0	;ISTEP
FOR 10
	DAT 0,0
ROF
BOOT:	MOV CBM,*SPTR
	MOV BMB,@SPTR
	SUB.F #10,>6			;(>GOST -> SPTR)
	SPL 0,}0			;3 procs. (1|2 non parallel)
	MOV.I <MOREP,{SPTR		;copy stone's gate
MOREP:	MOV.I SP2,#SCL+3		;3->5 procs, source ptr gate
	MOV.I {SSRC,<SPTR		;move out stone
	MOV.I <GOIP,{GOIP		;move out imp-pump
GOST:	DJN.B @SPTR,SPTR		;go to stone, (4 procs)
GOIP:	SPL IP_LOC,IPMP+5		;go to imp-pump, (1 proc) and pointers
SPTR:	SUB.F #SG_LOC+10,#ST_LOC+6	;launch vector/pointers; self-erases
SSRC:	DAT STONE+5,{5			;source ptr stone, process counter
FOR 20
	DAT 0,0
ROF
;---------- cut'n pasted Q^3 Quickscanner ------------

qf 		equ 	qKil
qs 		equ 	200
qd 		equ 	4000
qi 		equ 	7
qr 		equ 	8
;----

qBmb 		dat  	{qi*qr-10	, {1
qGo  		seq  	qd+qf+qs	, qf+qs
    		jmp  	qSki		, {qd+qf+qs+qi+2
    		sne  	qd+qf+5*qs	, qf+5*qs
    		seq  	qf+4*qs		, {qTab
		jmp  	qFas		, }qTab
		sne  	qd+qf+8*qs	, qf+8*qs
    		seq  	qf+7*qs		, {qTab-1
    		jmp  	qFas		, {qFas
		sne  	qd+qf+10*qs	, qf+10*qs
    		seq  	qf+9*qs		, {qTab+1
		jmp  	qFas		, }qFas
		seq  	qd+qf+2*qs	, qf+2*qs
		jmp	qFas		, {qTab
		seq	qd+qf+6*qs	, qf+6*qs
		djn.a	qFas		, {qFas
		seq  	qd+qf+3*qs	, qf+3*qs
      		jmp  	qFas		, {qd+qf+3*qs+qi+2
		sne  	qd+qf+14*qs	, qf+14*qs
		seq 	qf+13*qs  	, <qTab
		jmp  	qSlo		, >qTab
		sne  	qd+qf+17*qs	, qf+17*qs
		seq  	qf+16*qs	, <qTab-1
		jmp  	qSlo		, {qSlo
		seq  	qd+qf+11*qs	, qf+11*qs
		jmp  	qSlo		, <qTab
		seq  	qd+qf+15*qs	, qf+15*qs
		djn.b	 qSlo		, {qSlo
		sne  	qd+qf+12*qs	, qf+12*qs
		jmz  	BOOT		, qd+qf+12*qs-qi
qSlo 		mov.ba 	qTab		, qTab
qFas	 	mul.ab 	qTab		, qKil
qSki  		sne  	qBmb-1		, @qKil
    	 	add  	#qd		, qKil
qLoo  		mov.i  	qBmb		, @qKil
qKil	  	mov.i  	qBmb		, *qs
      		sub.ab 	#qi		, qKil
      		djn    	qLoo		, #qr
      		jmp    	BOOT		, <-4000
    		dat  	5408		, 7217
qTab  		dat  	4804		, 6613
dSrc  		dat  	5810		, qBmb-5

SP2:	SPL 1,SCL+2-MOREP
FOR (MAXLENGTH-CURLINE)		;Trash code as decoy
	DAT 1,>1
ROF
	END qGo

