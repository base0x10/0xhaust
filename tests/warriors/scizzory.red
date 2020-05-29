;redcode-94b
;name scizzory
;author Miz
;strategy big scanner
;strategy 124 wilkies 103 wilfiz
;strategy for filling b-hill
;assert 1
step equ 28
gap equ 8


ptr: dat 100, 100+gap
  dat $0, $0
dat >5335, >15
s: spl #step, #step
mov.i -1, >ptr
djn.b -1, lenght

add.f s,  ptr
scan: seq.i *ptr, @ptr
slt.ab #32, ptr
djn.b -3, #4500
lenght: add.ab #12, #0

sub.ab #12, ptr
jmn.b -8, -3
nop >-8, {-9
jmp -11
end scan

