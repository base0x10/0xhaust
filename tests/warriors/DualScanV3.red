;redcode
;name DualScanV3
;author Skybuck Flying
;strategy Dual Scan
;strategy Bomber
;assert 1
;version 3
;date 20 february 2008
;Inspired by talk about q scans on corewar newsgroup
;Faster version uses multiple scan instructions
;Faster version uses multiple bomb instructions

Initialization
mov Location1, Bomb
jmp Compare

WarriorLength equ WarriorEnd - WarriorBegin

WarriorBegin

Location1
Location2
	dat $WarriorEnd, $(WarriorEnd + CORESIZE /2) - WarriorLength
Spacing
	dat $0, $0
	dat $0, $0
	dat $0, $0
	dat $0, $0
	dat $0, $0

	dat $0, $0
	dat $0, $0
	dat $0, $0
	dat $0, $0
	dat $0, $0



Compare
seq }Location1, >Location2
jmp Bomber
seq }Location1, >Location2
jmp Bomber
seq }Location1, >Location2
jmp Bomber
seq }Location1, >Location2
jmp Bomber
seq }Location1, >Location2
jmp Bomber
seq }Location1, >Location2
jmp Bomber
seq }Location1, >Location2
jmp Bomber
seq }Location1, >Location2
jmp Bomber
seq }Location1, >Location2
jmp Bomber
sne }Location1, >Location2
jmp Compare

Bomber
nop {Location1, <Location2

mov Bomb, }Location1
mov Bomb, >Location2

mov Bomb, }Location1
mov Bomb, >Location2

mov Bomb, }Location1
mov Bomb, >Location2

mov Bomb, }Location1
mov Bomb, >Location2

mov Bomb, }Location1
mov Bomb, >Location2

mov Bomb, }Location1
mov Bomb, >Location2

mov Bomb, }Location1
mov Bomb, >Location2

mov Bomb, }Location1
mov Bomb, >Location2

mov Bomb, }Location1
mov Bomb, >Location2

mov Bomb, }Location1
mov Bomb, >Location2

jmp Compare
Bomb dat $0, $0

WarriorEnd
	dat $0, $0
