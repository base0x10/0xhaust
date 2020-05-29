;redcode-94nop verbose
;name Lemuria
;author Nenad Tomasev
;assert CORESIZE==8000
;strategy oneshot

ini equ 214
gap equ 12
ioff equ 157
step equ 2006

 org scan
 for 30
 dat 0, 0
 rof
pok dat 4009+ioff, {gap+ioff
jump jmp 4009, gap
 dat 0, 0
 dat 0, 0
 jmp 7829, <2667
clr spl #4007, gap
 mov @switch, >pok
 mov jump, }pok
switch djn clr+1, {clr
 for 44
 dat 0, 0
 rof
stop sub.f more, @inc
scan sne }pok, >pok
inc sub.f more, pok
 sne *pok, >pok
 djn.f stop, <pok
 jmp clr, <pok
 for 10
 dat 0, 0
 rof
more dat -step, -step
 end
