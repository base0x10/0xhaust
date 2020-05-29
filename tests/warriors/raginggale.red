;redcode-94nop
;name Raging Gale
;author inversed
;strategy Stone/Paper/Imp
;assert CORESIZE == 8000 

;.....P a p e r....;
ofs	equ	6673
bofs	equ	5251
aofs	equ	4125
istep	equ	1143

;.....S t o n e....;
sstep	equ	3121
stime	equ	3282
sdjn	equ	2813

;......B o o t.....;
len	equ	8
bds	equ	7777
bdp	equ	2792

;.....q S c a n....;
qf	equ	3553
qy	equ	5217

dq	equ	(qy+1)%CORESIZE
qa1	equ	(1+qf*(qt1-1-found))%CORESIZE
qa2	equ	(1+qf*(qt1  -found))%CORESIZE
qb1	equ	(1+qf*(qt2-1-found))%CORESIZE
qb2	equ	(1+qf*(qt2  -found))%CORESIZE
qb3	equ	(1+qf*(qt2+1-found))%CORESIZE
qc2	equ	(1+qf*(qt3  -found))%CORESIZE

qt1	equ	bps
qt3	equ	qbomb

;......M i s c.....;
gap1	equ	14
gap2	equ	14
free	equ	40
x0	equ	wgo
org	qgo

;..................;

wgo	spl	1,	qb1
qt2	spl	1,	qb2
	spl	1,	qb3

	mov	{silk,	{bpp
	mov	<bpp,	{bps

	spl	*1,		qa1
bps	spl	x0+bds+len,	qa2
bpp	jmp	x0+bdp+len,	s0+len

	for	gap1
	dat	0,	0
	rof

silk	spl	@len,		>ofs
	mov	}silk,		>silk
clear	spl	#0,		0	;vortex launched a-imps
	add.f	#istep,		iptr	;and anti b-imping
iptr	spl	imp-istep-1,	{aofs	;in one paper
	mov.i	#1,		<1
	djn	-1,		#bofs
imp	mov.i	#istep,		*0

	for	gap2
	dat	0,	0
	rof

s0	spl	#0		,	0
sloop	mov	sbomb		,	@sptr
shit	add	#sstep*2	,	sptr
sptr	mov	sbomb		,	}shit-sstep*stime
	djn.f	sloop		,	<sdjn
	dat	0		,	0
	dat	0		,	0
sbomb	dat	sstep		,	>1

	for	(free-gap1-gap2)
	dat	0,	0
	rof

	;q0 mutations 
qgo	sne	found+dq*qc2,	found+dq*qc2+qb2
	seq	<qt3,		found+dq*(qc2-1)+qb2
	jmp	q0,		}q0

	sne	found+dq*qa1,	found+dq*qa1+qb2
	seq	<qt1-1,		found+dq*(qa1-1)+qb2
        djn.a	q0,		{q0

	sne	found+dq*qa2,	found+dq*qa2+qb2
	seq	<qt1,		found+dq*(qa2-1)+qb2
	jmp	q0,		{q0

	;q1 mutations 
	sne	found+dq*qb1,	found+dq*qb1+qb1
	seq	<qt2-1,		found+dq*(qb1-1)+(qb1-1)
	jmp	q0,		{q1

	sne	found+dq*qb3,	found+dq*qb3+qb3
	seq	<qt2+1,		found+dq*(qb3-1)+(qb3-1)
	jmp	q0,		}q1

	;no mutation 
	sne	found+dq*qb2,	found+dq*qb2+qb2
        seq	<qt2,		found+dq*(qb2-1)+(qb2-1)
	jmp	q0,		0


	;dq mutation 
	seq	>found,		found+dq+(qb2-1)
	jmp	qsel,		<found

	;q0 mutation
	seq	found+(dq+1)*(qc2-1),	found+(dq+1)*(qc2-1)+(qb2-1)
	jmp	q0,			}q0

	seq	found+(dq+1)*(qa2-1),	found+(dq+1)*(qa2-1)+(qb2-1)
	jmp	q0,			{q0

	seq	found+(dq+1)*(qa1-1),	found+(dq+1)*(qa1-1)+(qb2-1)
	djn.a	q0,			{q0 

        ;free scan
	jmz.f	wgo,			found+(dq+1)*(qb2-1)+(qb2-1)
	
q0	mul.b	*q1,	 found
qsel	sne	<qt1,	@found
q1	add.b	qt2,	 found

qoff	equ	-86
qtime	equ	20
qstep	equ	7

qloop	mov	qbomb,	@found
found	mov	qbomb,	}dq
	add	#qstep,	found
	djn	qloop,	#qtime
	jmp	wgo,	0
qbomb	dat	{qoff,	{qc2
