;redcode
;name SimpleJMNWarriorV2
;author Skybuck Flying
;version 2
;strategy SimpleJMNScannerAndBomber for JMN testing
;date 2 february 2009
;assert 1

WarriorSize equ WarriorEnd - WarriorBegin

WarriorBegin

JMNScannerCounter jmp $Start, $CORESIZE/2

; land zone for imps
dat $0, $0
dat $0, $0
dat $0, $0

Start

JMNScannerLoop jmn InsertSection, <JMNScannerCounter
JMNScannerRepeat jmz JMNScannerLoop, <JMNScannerCounter

InsertSection

; MagicCookyCheck
SNE $MagicCookyProtection, @JMNScannerCounter

; MagicCookySkipOverOurselfes
SUB #WarriorSize, $JMNScannerCounter

mov $Bomb, @JMNScannerCounter

jmp JMNScannerLoop , <JMNScannerCounter

; Warrior Data
Bomb dat $0, $0

MagicCookyProtection
nop $3498, $3498
WarriorEnd
nop $3498, $3498

