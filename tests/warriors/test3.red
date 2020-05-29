;redcode
;name Test3
;author Miz
;assert 1
step1 equ 3456
step2 equ 1234
step3 equ 5678


spl 2
spl 1
mov.i <2, {2
mov.i <1, {1
spl paper+4000+6, paper+6

paper:  spl @0, >step1
	mov.i }-1, >-1
	mov.i }-2, >-2
	spl @0, >step2
	mov.i }-1, >-1
	mov.i #step3, }4001

