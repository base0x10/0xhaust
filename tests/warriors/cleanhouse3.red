;redcode
;name CleanTheHouseV3
;author Skybuck Flying
;version 3
;date 2 february 2009
;assert 1

; bomb the core first with imps

WarriorSize equ WarriorEnd - WarriorBegin

WarriorBegin

Here mov $imp, >counter
add #2, $counter
djn Here, #(CORESIZE/3 - WarriorSize)-500
djn 0, <-6
mov -2, <-7
jmp -2, <-8
imp mov $0, $1
WarriorEnd
counter dat $0, $0
