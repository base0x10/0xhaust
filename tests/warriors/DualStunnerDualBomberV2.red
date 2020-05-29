;redcode
;name DualStunnerDualBomberV2
;strategy Dual Stun Bomber, Dual Clear Bomber
;author Skybuck Flying
;date 14 march 2008
;version 2
;assert 1

mov $StunCounter, $CORESIZE/2 + 12
mov $StunFire1, $CORESIZE/2  + 12
mov $StunFire2, $CORESIZE/2  + 12
mov $StunFire3, $CORESIZE/2  + 12
mov $StunFire4, $CORESIZE/2  + 12
mov $StunFire5, $CORESIZE/2  + 12
mov $StunFire6, $CORESIZE/2  + 12
mov $StunFire7, $CORESIZE/2  + 12
mov $StunFire8, $CORESIZE/2  + 12
mov $StunRepeat, $CORESIZE/2  + 12
mov $StunBomb, $CORESIZE/2  + 12
mov $ClearBomb, $CORESIZE/2  + 12
spl $CORESIZE/2


WarriorLength equ WarriorEnd - WarriorBegin

WarriorBegin

BombingLength equ $-( (CORESIZE / 2) - 11 )

StunCounter nop $WeaponSelect, BombingLength  ; will be overwritten as to 
                                              ; reset itself :)
StunFire1 mov *StunCounter, >StunCounter
StunFire2 mov *StunCounter, >StunCounter
StunFire3 mov *StunCounter, >StunCounter
StunFire4 mov *StunCounter, >StunCounter
StunFire5 mov *StunCounter, >StunCounter
StunFire6 mov *StunCounter, >StunCounter
StunFire7 mov *StunCounter, >StunCounter
StunFire8 mov *StunCounter, >StunCounter
StunRepeat jmp StunFire1

WeaponSelect
StunBomb spl $(-StunCounter)+1, BombingLength
ClearBomb dat $(-StunCounter)-1, BombingLength

WarriorEnd
dat $0, $0



