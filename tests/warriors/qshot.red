;redcode
;name Q-Shot
;author Lukasz Adamowski
;assert CORESIZE==8000

ptr3	dat	$0,	$0

	FOR	5
	dat	$0,	$0
	ROF

clear	spl	#0,	#0
	mov	bomb,	>ptr3
	mov	bomb,	>ptr3
	djn.f	$-1,	>ptr3

	FOR	60
	dat	$0,	$0
	ROF

bomb	dat	<2667,	<15
boot
	sne	$3800,	$3500
	seq	>1,	$4200
	mov.i	<ptr1,	$4600-2 ; 13 * 30
	sne	$5300,	$5000
	seq	>1,	$5700
	mov.i	>ptr1,	$6100-2 ; 13 * 32
	sne	$6800,	$6500
	seq	>1,	$7200
	mov.i	{ptr1,	$7600-2 ; 12 * 31
	sne	$800,	$400
	seq	>1,	$1200
	mov.i	@ptr1,	$1600-2 ; 13 * 31
	sne	$2300,	$2000
	seq	>1,	$2700
	mov.i	}ptr1,	$3100-2 ; 14 * 31
ptr1	mul.ab	#13,	#31
	mod.ab	#5,	$ptr1
	mul.ab	#3,	$ptr1
	add.b	$ptr1,	$ptr2
	mod.ab	#100,	@ptr2
	add.b	@ptr2,	$ptr2
	add.ab	#-100,	$ptr2
	mov.b	@ptr2,	ptr3
ptr2	jmp	clear,	$boot+2 ; where the q-scan table starts

	end	boot

