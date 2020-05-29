;redcode
;name DivideAndConquerV2Neo
;author Skybuck Flying
;strategy Skybuck's Divide and Concuer + Neogryzor's Bomber :)
;version 2
;date 2 february 2009
;assert 1

WarriorLength equ (WarriorEnd-WarriorBegin)

WarriorBegin

Initialization

Copy
mov }Source, >Dest
Loop djn Copy, #WarriorLength
sub #(WarriorLength-(SpawnHere-WarriorBegin)), $Dest
spl @Dest
SpawnHere
mov.ab #WarriorLength, $Loop
mov.a #(WarriorBegin-Source), $Source
div #2, $Dest
djn Copy, #8

Warrior2Begin

gate equ (head-2)   ;<- where the pointer for clearing is

head: spl #0
        mov.i bmb,>gate
        djn.f -1,>gate
bmb: dat <2667,(1-gate)

Warrior2End

Source
Dest
dat #WarriorBegin, #(CORESIZE / 2) - (WarriorLength / 2)
WarriorEnd
dat $0, $0
