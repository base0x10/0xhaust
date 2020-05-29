;redcode
;name SuperImpKillerV4
;author Skybuck Flying
;strategy Faster ImpBomber + ImpKiller (Self Terminates :( :))
;version 4
;date 2 february 2009
;assert 1

WarriorSize equ WarriorEnd - WarriorBegin

WarriorBegin

BomberCounter  ScannerCounter dat $0, $-5

dat $0, $0
dat $0, $0
dat $0, $0

ORG WarriorStart

WarriorStart 
Here mov $Imp, >counter
add #11, $counter
djn Here, #(CORESIZE/12) - WarriorSize

Scanner 
; bomb ahead of scanner
MOV $Bomb, <BomberCounter

; scan behind bomber
SNE Imp, *ScannerCounter

;jump to ImpKiller when imp detected
JMP BombingSection

; jump to bombing/scanning section
JMP Scanner, {ScannerCounter

Imp mov 0, 1
Bomb dat $0, $1

BombingSection
add.a #8, $ScannerCounter
;mov Bomb, *ScannerCounter
mov.x Bomb, *ScannerCounter
djn -1, *ScannerCounter
; go back a bit to clear it out again
mov.ab $ScannerCounter, $BomberCounter
add.a #15, $ScannerCounter
add.ab #10, $BomberCounter
jmp Scanner

counter dat $0, $0

WarriorEnd

end 
