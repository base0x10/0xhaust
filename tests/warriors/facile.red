;redcode-94nop
;name facile
;author C. De Rosa
;strategy Stupid!
;assert 1

loop	mov	bomb1,<PUNT
	djn	loop,#0
	djn	loop,#3
	djn.a	loop,loop
bomb2	dat	#0,	-7
bomb1	spl	#0,	-7
PUNT	dat	0,	4000

