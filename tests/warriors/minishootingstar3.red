;redcode
;name MiniShootingStarV3
;author Skybuck Flying
;strategy Serial-Threaded-InSync-Super-Fast-Copy-Across-TheCore
;version 3
;date 2 april 2008
;history version 1 created on 9 december 2007
;history version 1 contains lots of comments idead etc
;history version 2 created on 14 december 2007
;history version 2 runs at same speed as version 1
;history version 2 shorter boot program and threads run in sync
;history version 2 one instruction less but still need an extra
;history version 2 data member so it is of same size
;history version 2 kinda strange and interesting though,
;history version 2 longer boot program does not prevent
;history version 2 version 1 from immediatly starting
;history version 3 created on 2 april 2008
;history version 3 the nop replaced with a dat to be a little bit more 
; deadly
;history version 3 slightly longer bootup time because of extra jump in boot 
; program
;history version 3 faster execution of main because of optimized jump 
; instruction
;history version 3 jump destructor added to prevent followers
;assert 1

Target equ 131

spl $1
mov -1, 0
jmp 2, {-3 ; {-3 = extra decoy near boot program
SourceDest dat $0, $Target
mov }SourceDest, >SourceDest
jmp $Target-1, {-131  ; {-131 = jump destructor




