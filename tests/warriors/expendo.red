;redcode-94nop
;name Expendo
;author Roy van Rijn
;assert 1

;bomb-loop
;set the bomb to the right parameters and bomb
bLoop	mov.i   bBomb		, 100
	add.ab	#100		, bLoop
	sub.a	#100		, bBomb
	djn.b	bLoop		, bCnt

;reset the iExp line once in a while
	mov.ab	#-1		, iExp ;reset bomb
bCnt	mov.ab	#5		, #5
	djn.b	bLoop		, #18 ;tweak!

bStep	equ	124 ;random

;Simple d-clear
cGo	spl	#0		, 0
	mov.i	2		, >bLoop
	djn.f	-1		, >bLoop
	dat	0		, 15

for 20
	dat 0,0
rof

bBomb	mov.i	>iExp-bLoop-100	, 1
	jmn.a	-1		, >-1
iExp	spl	#10		, -1
	mov.i	-1		, {-1

end bLoop

