;redcode
;name ProtectorV4FasterNoSelfKill
;author Skybuck Flying
;date 9 december 2007
;assert 1
;version 4FasterNoSelfKill
;strategy Tries to protect itself with 3 bombers left and 3 bombers right
;history version 4FasterNoSelfKill created on 9 december 2007

; I noticed how the warrior performed pretty will during different fights but ultimately lost because it probably killed itself
; A simple solution would be to replace the jump loop with a conditional jump, add a reset and rejump, now it should no longer kill itself ;) and still bomb
; the core completely :)
; core clear not completely perfect, but it's better than nothing :)

spl protectleft1
spl protectright1

spl protectleft2
spl protectright2

spl protectleft3
spl protectright3

WarriorLength equ WarriorEnd - WarriorBegin

BombingLength equ ((CORESIZE - (WarriorLength + right)) / 3) + 5; because there are 3 warriors incrementing/decrementing per direction :)

WarriorBegin


left dat #-1

protectleft1
mov bomb, <left
protectleft1loop djn protectleft1, #BombingLength
mov.ab #-1, left			; reset bombing position
mov.ab #BombingLength, protectleft1loop ; reset bombing length
jmp protectleft1

protectleft2
mov bomb, <left
protectleft2loop djn protectleft2, #BombingLength
mov.ab #-1, left			; reset bombing position
mov.ab #BombingLength, protectleft2loop ; reset bombing length
jmp protectleft2

protectleft3
mov bomb, <left
protectleft3loop djn protectleft3, #BombingLength
mov.ab #-1, left			; reset bombing position
mov.ab #BombingLength, protectleft3loop	; reset bombing length
jmp protectleft3

bomb dat #0

protectright1
mov bomb, >right
protectright1loop djn protectright1, #BombingLength
mov.ab #1, right				; reset bombing position
mov.ab #BombingLength, protectright1loop	; reset bombing length
jmp protectright1

protectright2
mov bomb, >right
protectright2loop djn protectright2, #BombingLength
mov.ab #1, right				; reset bombing position
mov.ab #BombingLength, protectright2loop 	; reset bombing length
jmp protectright2

protectright3
mov bomb, >right
protectright3loop djn protectright3, #BombingLength
mov.ab #1, right				; reset bombing position
mov.ab #BombingLength, protectright3loop 	; reset bombing length
jmp protectright3

right dat #1

WarriorEnd
dat $0, $0
