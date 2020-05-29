;redcode
;name DivideAndConquerV2Quicker
;author Skybuck Flying
;strategy Divide and Concuer, Turns into tieing imps
;version 2
;date 25-1-2008
;assert 1

WarriorLength equ WarriorEnd-WarriorBegin

WarriorBegin

Initialization

Copy
	mov }Source, >Dest
Loop	djn Copy, #WarriorLength
	sub #(WarriorLength-(SpawnHere-WarriorBegin)), $Dest
	spl @Dest
SpawnHere
	mov.ab #WarriorLength, $Loop
	mov.a #(WarriorBegin-Source), $Source
	div #2, $Dest
	djn Copy, #8
	mov $0, $1
Source
Dest
	dat #WarriorBegin, #(CORESIZE / 2) - (WarriorLength / 2)
WarriorEnd
	dat $0, $0
