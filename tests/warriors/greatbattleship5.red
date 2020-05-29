;redcode
;name Great Battleship V5
;author Skybuck Flying
;strategy Fires bombs like a great naval battleship ! =D
;inspiration Empire Total War Great Naval Sea Battles ! =D
;version 1, date 1 march 2009
;version 5, date 5 march 2009
; mostly fun to watch ! =D
; slightly modified to make it more usefull...
; linesize offset changed so it bombs more...
; not bad for a first version ! :)
; it actually does work a bit this bombing pattern funnnnny ! =D
; jumps added to re-use the threads, 
; incrementors/decrementors added in the jumps to change the aim
; line size constant now closer to original idea.
;assert 1

LineSize equ 128+1

spl TopCannon1Begin
spl BottomCannon1Begin

spl TopCannon2Begin
spl BottomCannon2Begin

spl TopCannon3Begin
spl BottomCannon3Begin

spl TopCannon4Begin
spl BottomCannon4Begin

spl TopCannon5Begin
spl BottomCannon5Begin

spl TopCannon6Begin
spl BottomCannon6Begin
dat #0, #0

TopCannon1Begin
spl $0, $0
TopCannon1Fire
TopCannon1Target mov $TopCannon1Bomb, $-LineSize
sub #LineSize, TopCannon1Target
TopCannon1Loop
jmp TopCannon1Fire, >TopCannon1Target
TopCannon1Bomb
dat #0, #0
TopCannon1End

BottomCannon1Begin
spl $0, $0
BottomCannon1Fire
BottomCannon1Target mov $BottomCannon1Bomb, $LineSize
add #LineSize, BottomCannon1Target
BottomCannon1Loop
jmp BottomCannon1Fire, <BottomCannon1Target
BottomCannon1Bomb
dat #0, #0
BottomCannon1End

TopCannon2Begin
spl $0, $0
TopCannon2Fire
TopCannon2Target mov $TopCannon2Bomb, $-LineSize
sub #LineSize, TopCannon2Target
TopCannon2Loop
jmp TopCannon2Fire, >TopCannon2Target
TopCannon2Bomb
dat #0, #0
TopCannon2End

BottomCannon2Begin
spl $0, $0
BottomCannon2Fire
BottomCannon2Target mov $BottomCannon2Bomb, $LineSize
add #LineSize, BottomCannon2Target
BottomCannon2Loop
jmp BottomCannon2Fire, <BottomCannon2Target
BottomCannon2Bomb
dat #0, #0
BottomCannon2End

TopCannon3Begin
spl $0, $0
TopCannon3Fire
TopCannon3Target mov $TopCannon3Bomb, $-LineSize
sub #LineSize, TopCannon3Target
TopCannon3Loop
jmp TopCannon3Fire, >TopCannon3Target
TopCannon3Bomb
dat #0, #0
TopCannon3End

BottomCannon3Begin
spl $0, $0
BottomCannon3Fire
BottomCannon3Target mov $BottomCannon3Bomb, $LineSize
add #LineSize, BottomCannon3Target
BottomCannon3Loop
jmp BottomCannon3Fire, <BottomCannon3Target
BottomCannon3Bomb
dat #0, #0
BottomCannon3End

TopCannon4Begin
spl $0, $0
TopCannon4Fire
TopCannon4Target mov $TopCannon4Bomb, $-LineSize
sub #LineSize, TopCannon4Target
TopCannon4Loop
jmp TopCannon4Fire, >TopCannon4Target
TopCannon4Bomb
dat #0, #0
TopCannon4End

BottomCannon4Begin
spl $0, $0
BottomCannon4Fire
BottomCannon4Target mov $BottomCannon4Bomb, $LineSize
add #LineSize, BottomCannon4Target
BottomCannon4Loop
jmp BottomCannon4Fire, <BottomCannon4Target
BottomCannon4Bomb
dat #0, #0
BottomCannon4End

TopCannon5Begin
spl $0, $0
TopCannon5Fire
TopCannon5Target mov $TopCannon5Bomb, $-LineSize
sub #LineSize, TopCannon5Target
TopCannon5Loop
jmp TopCannon5Fire, >TopCannon5Target
TopCannon5Bomb
dat #0, #0
TopCannon5End

BottomCannon5Begin
spl $0, $0
BottomCannon5Fire
BottomCannon5Target mov $BottomCannon5Bomb, $LineSize
add #LineSize, BottomCannon5Target
BottomCannon5Loop
jmp BottomCannon5Fire, <BottomCannon5Target
BottomCannon5Bomb
dat #0, #0
BottomCannon5End

TopCannon6Begin
spl $0, $0
TopCannon6Fire
TopCannon6Target mov $TopCannon6Bomb, $-LineSize
sub #LineSize, TopCannon6Target
TopCannon6Loop
jmp TopCannon6Fire, >TopCannon6Target
TopCannon6Bomb
dat #0, #0
TopCannon6End

BottomCannon6Begin
spl $0, $0
BottomCannon6Fire
BottomCannon6Target mov $BottomCannon6Bomb, $LineSize
add #LineSize, BottomCannon6Target
BottomCannon6Loop
jmp BottomCannon6Fire, <BottomCannon6Target
BottomCannon6Bomb
dat #0, #0
; BottomCannon6End
