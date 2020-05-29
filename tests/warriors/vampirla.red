;redcode-94nop
;author C. De Rosa
;name Vampirla
;strategy vamp
;assert 1

bomb2	dat	0,	#-14
bomb	spl	0,	#-20
	spl	bomb
	jmp	bomb
	dat	0

loop	mov	vamp,	@vamp
	add	step,	vamp
	djn	loop,	#1500
	jmp	fase2
	dat	0

fase2	spl	loop
loop2	mov	*guns,<target
	djn	loop2,#0
	djn.f	loop2,@guns
	dat	0

guns	dat	bomb,	0
step	dat	#-3315,	#3315
vamp	jmp	-3318,	3302
target	dat	0,	-19

	end loop

