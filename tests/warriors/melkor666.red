;redcode
;name Magna Carta
;assert CORESIZE%16==0
;strategy Vampire
;strategy Killed by your own processes.
;author MelkorDCLXVI

	step	equ 56
		org start

before:	dat $0, $0
start:	add.a #-step, bomb
	add.ab #step, bomb
	mov bomb, @bomb
	jmp start
bomb:	jmp trap, bomb
trpbomb:dat before, $0

block:
x	for 8
	dat $0, $0
	rof

trap:	spl decr
decr:	djn trap, #-1
	mov nospl, trap
move:	mov trpbomb, {trpbomb
jump:	jmp move
	
	dat $0, $0
	dat $0, $0

nospl:	jmp $3

