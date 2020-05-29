;redcode-94nop
;name All Things Fluffy
;version 1.0.8
;author Fluffy
;strategy A quick look around and two fluffy bunnies are let loose.
;assert CORESIZE == 8000

	ORG	qGo	

;;
;; boot
;;

	pAway1	EQU	2575
	pAway2	EQU	5633

	decoy	EQU	4000

	; create 8 processes

boot	spl	} 1,		{ qb1
qTab2	spl	0,		{ qb2
	spl	1,		{ qb3

	; boot two copies of the paper

 	mov.i	{ silk1,	{ pBoot1
pBoot1	spl	pAway1,		{ pAway2 + pBoot2

	mov.i	} pBoot1,	> pBoot1
pBoot2	djn.f	pAway2,		{ decoy

for 10
	dat.f	0,		0
rof

;;
;; paper
;;

	pStep1	EQU	5679
	pStep2	EQU	 387
	pStep3	EQU	 535

	bSrc1	EQU	5338
	bSrc2	EQU	2346

	bHit1	EQU	7553
	bHit2	EQU	1665

silk1	spl	@ silk1 + 8,	{ pStep1
        mov.i	} silk1,	> silk1

silk2	spl	@ silk2,	> pStep2
	mov.i	} silk2,	> silk2

        mov.i	> bSrc1,	{ bHit1
	mov.i	> bSrc2,	{ bHit2

        mov.i	{ silk2,	< silk3
silk3	djn.f	@ silk3,	> pStep3

for 8
	dat.f	0,		0
rof

empty	dat.f	0,		0
	dat.f	empty,		qa1
qTab1	dat.f	empty,		qa2

for 28
	dat.f	0,		0
rof

;;
;; quickscanner
;;

	qTab3	EQU		qBomb

	qm	EQU		160
	qM	EQU		6239	;; qM * (qm-1) = 1 mod 8000

	qa1	EQU		((qTab1-1-found)*qM+1)
	qa2	EQU		((qTab1  -found)*qM+1)

	qb1	EQU		((qTab2-1-found)*qM+1)
	qb2	EQU		((qTab2  -found)*qM+1)
	qb3	EQU		((qTab2+1-found)*qM+1)
	
	qc2	EQU		((qTab3  -found)*qM+1)

qBomb	dat.f	> qOffset,		> qc2

qGo	; q0 mutations

	sne.i	found+qm*qc2,		found+qm*qc2+qb2
	seq.i	< qTab3,		found+qm*(qc2-1)+qb2
	jmp	q0,			} q0

	sne.i	found+qm*qa1,		found+qm*qa1+qb2
	seq.i	< (qTab1-1),		found+qm*(qa1-1)+qb2
	djn.a	q0,			{ q0

	sne.i	found+qm*qa2,		found+qm*qa2+qb2
	seq.i	< qTab1,		found+qm*(qa2-1)+qb2
	jmp	q0,			{ q0

	; q1 mutations

	sne.i	found+qm*qb1,		found+qm*qb1+qb1
	seq.i	< (qTab2-1),		found+qm*(qb1-1)+(qb1-1)
	jmp	q0,			{ q1

	sne.i	found+qm*qb3,		found+qm*qb3+qb3
	seq.i	< (qTab2+1),		found+qm*(qb3-1)+(qb3-1)
	jmp	q0,			} q1

	; no mutation

	sne.i	found+qm*qb2,		found+qm*qb2+qb2
	seq	< qTab2,		found+qm*(qb2-1)+(qb2-1)
	jmp	q0,			< found+qm*qb2 + 5

	; qm mutation

	seq.i	> found,		found+qm+(qb2-1)
	jmp	qSelect,		< found

	; q0 mutation

	seq.i	found+(qm+1)*(qc2-1),	found+(qm+1)*(qc2-1)+(qb2-1)
	jmp	q0,			} q0

	seq.i	found+(qm+1)*(qa2-1),	found+(qm+1)*(qa2-1)+(qb2-1)
	jmp	q0,			{ q0

	seq.i	found+(qm+1)*(qa1-1),	found+(qm+1)*(qa1-1)+(qb2-1)
	djn.a	q0,			{ q0

	; no mutation (free scan)

	jmz.f	boot,			found+(qm+1)*(qb2-1)+(qb2-1)

	; decoder

q0	mul.b	* q1,		found
qSelect	sne	{ qTab1,	@ found
q1	add.b	qTab2,		found

	; bombing engine VI

	qOffset	EQU	-86
	qTimes	EQU	19	   ; number of bombs to throw
	qStep	EQU	-7	   ; distance between bombs

throw	mov.i	qTab3,		@ found
found	mov.i	qBomb,		} qm
	sub	# qStep,	found
	djn	throw,		# qTimes

	; boot paper

	jmp	boot,		{ decoy

	END
