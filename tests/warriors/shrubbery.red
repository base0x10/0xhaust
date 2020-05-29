;redcode-94nop
;name Shrubbery
;author inversed/Mizcu
;strategy q^i -> paper
;strategy Biomech and Netpaper techniques combined
;assert (CORESIZE==8000) && (MAXPROCESSES==8000)

;; paper

pofs1	equ	7181
pofs2	equ	1940
pofs3	equ	2461

bofs1	equ	6330
bofs2	equ	 731
bofs3	equ	4541
bofs4	equ	4044

len	equ	8

;; qscan

qbstep	equ	7
qbhop	equ	-86
qbcnt	equ	20

qxa	equ	6980
qxb	equ	6810
qa1	equ	5354
qa2	equ	5514
qb1	equ	5507
qb2	equ	4163
qstep	equ	2379

nil	equ	(-CURLINE-1)

;; misc

bdist	equ	2003
scratch	equ	5573
x0	equ	boot
org	qgo

;;

boot	spl	1,	{x0+scratch+len+1
	spl	1,	{x0+scratch+len+2
	spl	1,	{x0+scratch+len+3

	mov	{silk1,		{bptr
bptr	djn.f	x0+bdist+len,	{x0+scratch+len

silk1	spl	@len,		<pofs1
	mov	}silk1,		>silk1

silk2	spl	@0,		<pofs2
	mov	}silk2,		>silk2

	add.f	#bofs1,		<bofs2
	mov	<pofs2-1,	<bofs3

	mov	{silk2,		{silk3
silk3	djn.f	pofs3,		{bofs4

	;				--------~~~~~~~~([ instant ])~~~~~~~~--------				;
	;						 [ 2 pairs ]						;
qgo	sne	found+qxa					,	found+qxb
	seq	found+qxa+qstep					,	found+qxb+qstep
	jmp	decide,	0

	;				--------~~~~~~~~([+0 cycles])~~~~~~~~--------				;
	;						 [ 8 pairs ]						;
	sne	found+qxa*qa2					,	found+qxb*qb2
	seq	found+qxa*qa2+qstep				,	found+qxb*qb2+qstep
	jmp	dec0de,	0

	sne	found+qxa*qa1					,	found+qxb*qb1
	seq	found+qxa*qa1+qstep				,	found+qxb*qb1+qstep
	jmp	dec0de,	<dec1

	sne	found+qxa*(qa2-1)				,	found+qxb*(qb2-1)
	seq	found+qxa*(qa2-1)+qstep				,	found+qxb*(qb2-1)+qstep
	djn.f	dec0de,	qtab

	sne	found+(qxa-1)*qa2				,	found+(qxb-1)*qb2
	seq	found+(qxa-1)*qa2+qstep				,	found+(qxb-1)*qb2+qstep
	djn.f	dec0de,	found

	;				--------~~~~~~~~([+1 cycle ])~~~~~~~~--------				;
	;						 [16 pairs ]						;
	sne	found+qxa*((qa2*qb2)%CORESIZE)			,	found+qxb*((qa2*qb2)%CORESIZE)
	seq	found+qxa*((qa2*qb2)%CORESIZE)+qstep		,	found+qxb*((qa2*qb2)%CORESIZE)+qstep
	jmp	dec1,	0

	sne	found+qxa*(((qa2-1)*qb2)%CORESIZE)		,	found+qxb*(((qa2-1)*qb2)%CORESIZE)
	seq	found+qxa*(((qa2-1)*qb2)%CORESIZE)+qstep	,	found+qxb*(((qa2-1)*qb2)%CORESIZE)+qstep
	jmp	dec1,	{qtab

	sne	found+qxa*(((qa2+1)*qb2)%CORESIZE)		,	found+qxb*(((qa2+1)*qb2)%CORESIZE)
	seq	found+qxa*(((qa2+1)*qb2)%CORESIZE)+qstep	,	found+qxb*(((qa2+1)*qb2)%CORESIZE)+qstep
	jmp	dec1,	}qtab

	jmp	boot,	0

dec1	mul.x	qtab,	qtab
dec0de	mul	@dec1,	found

	;decide - 1 + 0.5 + 1 + 0.5 = 3 cycles (average)
decide	sne	*found,	@found
	add	qinc,	found
	seq	nil,	*found
	mov.x	found,	found

qbloop	mov	qbomb,		@found
found	mov	qxa,		}qxb
	add	#qbstep,	found
	djn	qbloop,		#qbcnt
	jmp	boot,		0
qbomb	dat	>qbhop,		>1

	dat	qa1,	qb1
qtab	dat	qa2,	qb2

qinc	dat	qstep,	qstep

	for	47
	dat	0,	0
	rof
