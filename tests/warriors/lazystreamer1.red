;redcode
;name LazyStreamerV1
;author Skybuck Flying
;strategy 4 lazy streams up your ass.
;version 1
;date 9 january 2009 
;assert 1
spl spawnstream
spl impstream
spl stunstream

djnstream
spl #0, #0
DJN.A #6000, <6000

spawnstream
spl #0, #0
jmp >1000

stunstream
add #1, $4002
spl $1, $1
mov -1, >4000

impstream
mov 0, 1

