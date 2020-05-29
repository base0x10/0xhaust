;redcode-94nop
;author inversed
;name Outcast
;strategy q^i -> Scanner with fixed-length wipe
;assert (CORESIZE==8000) && (MAXPROCESSES==8000)

;-------<< q^i quickscanner >>---------------------------------------;

qbstep	equ	7
qbhop	equ	-87
qbcnt	equ	20

qxa	equ	6980
qxb	equ	6810
qa1	equ	5354
qa2	equ	5514
qb1	equ	5824
qb2	equ	4163
qstep	equ	2379

qa2qb2	equ	((qa2*qb2)%CORESIZE)
qa2p1qb	equ	(((qa2+1)*qb2)%CORESIZE)
nil	equ	(-CURLINE-1)
X	equ	found
gap	equ	36
org	qgo

        ;        --------~~~~~~~~([ instant ])~~~~~~~~--------       ;
qgo	sne	X + qxa				, X + qxb
	seq	X + qxa + qstep			, X + qxb + qstep
	jmp	decide,	0

        ;        --------~~~~~~~~([+0 cycles])~~~~~~~~--------       ;

	sne	X + qxa * qa2			, X + qxb * qb2
	seq	X + qxa * qa2 + qstep		, X + qxb * qb2 + qstep
	jmp	dec0de, 0

	sne	X + qxa * qa1			, X + qxb * qb1
	seq	X + qxa * qa1 + qstep		, X + qxb * qb1 + qstep
	jmp	dec0de, < dec1

	sne	X + qxa * (qa2 - 1)		, X + qxb * (qb2 - 1)
	seq	X + qxa * (qa2 - 1) + qstep	, X + qxb * (qb2 - 1) + qstep
	djn.f	dec0de, qtab

	sne	X + (qxa - 1) * qa2		, X + (qxb - 1) * qb2
	seq	X + (qxa - 1) * qa2 + qstep	, X + (qxb - 1) * qb2 + qstep
	djn.f	dec0de, found

        ;        --------~~~~~~~~([+1 cycle ])~~~~~~~~--------       ;
	sne	X + qxa * qa2qb2		, X + qxb * qa2qb2
	seq	X + qxa * qa2qb2 + qstep	, X + qxb * qa2qb2 + qstep
	jmp	dec1, 0

	sne	X + qxa * qa2p1qb		, X + qxb * qa2p1qb
	seq	X + qxa * qa2p1qb + qstep	, X + qxb * qa2p1qb + qstep
	jmp	dec1, } qtab

	jmp	boot, 0

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

	for	gap
	dat	0,	0
	rof

;-------<< Scanner >>------------------------------------------------;

hop	equ	7			; scan gap
step	equ	2 * (2 * 173 + 1)	; scan step, must be mod 2
sofs	equ	-1			; initial scan offset
len	equ	21			; length for self-hit check
wlen	equ	hop			; half of the wipe length
time	equ	3950			; number of scans
cptr	equ	ptr + 1			; clear pointer
gate2	equ	count - 2		; extra gate
safe	equ	17			; clear spacing
ikill	equ	2667			; imp killing
clen	equ	15			; copy length
bdist	equ	4846			; boot distance
x0	equ	qgo			; boot relative to what

bptr	spl	# loop	,	  0
loop	sub	  inc	,	  ptr
ptr	seq.b	  sofs	,	  sofs + hop
	slt.ab	# len	,	  ptr
timer	djn	  loop	,	# time
	mov	# wlen	,	  count
	mov.a	  ptr	,	  bptr
wipe	mov	@ wipe	,	} bptr
	mov	@ wipe	,	} bptr
count	djn	  wipe	,	# 0
	jmn	  loop	,	  timer
inc	spl	#-step	,	<-step
clear	mov	  kill	,	> cptr
	djn	  clear	,	{ gate2
kill	dat	< ikill	,	  safe
	dat	  0	,	  0

;-------<< Boot >>---------------------------------------------------;

copy	mov	< bp			,	{ bp
boot	mov	< bp			,	{ bp
	mov	< bp			,	{ bp
	mov	< bp			,	{ bp
	djn	  copy			,	# 4
bp	spl	* x0 + bdist + clen	,	  bptr + clen
	mov.i	# 0			,	{ 0

;--------------------------------------------------------------------;

