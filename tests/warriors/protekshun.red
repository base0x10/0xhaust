;redcode-94
;name Protekshun
;author inversed
;strategy q^i -> Stone/Imp
;strategy SpookyWench-style stone
;strategy Modified vortex launcher with a- and b- imps
;assert 1

;------Stone-------------------------------
step	equ	4901
hop	equ	6341
time	equ	1440
zofs	equ	hit-step*time
bofs	equ	434	;bomb offset

;------Imps--------------------------------
istep	equ	2667
stream	equ	1000

;------Boot--------------------------------
iofs1	equ	1452	;b-imp offset
iofs2	equ	3474	;a-imp offset
bds	equ	5282	;stone boot distance
bdi	equ	2289	;implauncher boot distance
slen	equ	5	;stone length
ilen	equ	5	;implauncher length

;------qScan-------------------------------
qbstep	equ	7
qbhop	equ	-87
qbcnt	equ	20
qxa	equ	2086
qxb	equ	2512
qa1	equ	5354
qa2	equ	5514
qb1	equ	6352
qb2	equ	4163
qstep	equ	2379
nil	equ	(-CURLINE-1)

;------Misc--------------------------------
x0	equ	boot
org	qgo

;------------------------------------------

boot	mov	imp1,	x0+bdi+iofs1
	mov	imp2,	x0+bdi+iofs2
	mov	bomb,	x0+bds+(bomb-s0)+bofs

	spl	2,	0
	spl	2,	0
	spl	1,	0

	mov	<s0,	{bps
	mov	<bps,	{bpi

bps	spl	x0+bds+slen,	inc+ilen
bpi	djn	x0+bdi+ilen,	#4
	mov.f	#0,		bpi
	dat	0,		0

inc	spl	#istep,			istep
	add	inc,			iptr
	spl	2,			<inc+stream	
iptr	jmp	inc+iofs1-istep-3,	inc+iofs2-istep-3
e1	djn.f	@iptr,			<inc+stream

imp1	mov.i	#12,		istep
imp2	mov.i	#istep,		*0

s0	spl	#0,		slen
	spl	#0,		0
loop	mov	bomb+bofs,	@ptr
hit	add	#step,		ptr
ptr	djn.f	loop,		}zofs

bomb	dat	hop,		>1

	;				--------~~~~~~~~([ instant ])~~~~~~~~--------				;
qgo	sne	found+qxa					,	found+qxb
	seq	found+qxa+qstep					,	found+qxb+qstep
	jmp	decide,	0

	;				--------~~~~~~~~([+0 cycles])~~~~~~~~--------				;
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
	sne	found+qxa*((qa2*qb2)%CORESIZE)			,	found+qxb*((qa2*qb2)%CORESIZE)
	seq	found+qxa*((qa2*qb2)%CORESIZE)+qstep		,	found+qxb*((qa2*qb2)%CORESIZE)+qstep
	jmp	dec1,	0

	sne	found+qxa*(((qa2+1)*qb2)%CORESIZE)		,	found+qxb*(((qa2+1)*qb2)%CORESIZE)
	seq	found+qxa*(((qa2+1)*qb2)%CORESIZE)+qstep	,	found+qxb*(((qa2+1)*qb2)%CORESIZE)+qstep
	jmp	dec1,	}qtab

	sne	found+qxa*((qa2*(qb2-1))%CORESIZE)		,	found+qxb*((qa2*(qb2-1))%CORESIZE)
	seq	found+qxa*((qa2*(qb2-1))%CORESIZE)+qstep	,	found+qxb*((qa2*(qb2-1))%CORESIZE)+qstep
	jmp	dec1,	<qtab

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

