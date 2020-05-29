;redcode
;name MultiplyAndConquerV3
;author Skybuck Flying
;strategy Multiply and Conquer
;strategy Conquer the whole core
;version 3
;date 26-1-2008
;notes Music for the warrior:
;notes I will survive - Gloria Gaynor 
;notes http://www.youtube.com/watch?v=Xv6lHwWwO3w
;tested and working in CoreWin 2.3
;assert 1

WarriorLength equ WarriorEnd - WarriorBegin

WarriorBegin

Initialization

Copy
	mov }Source, >Dest
Loop	
	djn Copy, #WarriorLength
Spawn
	nop $0, $0	; filling for nicer pattern
	sub #(WarriorLength-(SpawnHere-WarriorBegin)), $Dest
	spl @Dest
	add #(WarriorLength-(SpawnHere-WarriorBegin)), $Dest
	nop $0, $0	; filling for nicer pattern

SpawnHere

ResetLoopCounter
	mov.ab #WarriorLength, $Loop

ResetSource
	mov.a #(WarriorBegin-Source), $Source

ResetDest
	mov.ab #(WarriorEnd - Dest), $Dest

; Dest := Dest + ( ( L * 2 ) - L );
MultipleIncrementation
	mul.ab #2, $Incrementation

AddIncrementation	
	add.b $Incrementation, $Dest
	sub.ab #WarriorLength, $Dest

Reloop
; further extensions could be made here after core conquer
;	djn Copy, #9	
	jmp Copy

Source
Dest
	dat #WarriorBegin, #WarriorEnd

Incrementation
	dat $0, #WarriorLength

WarriorEnd
	dat $0, $0








