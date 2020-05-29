;redcode-94nop
;name Nasty Twins
;author Christian Schmidt
;strategy double blur-scanner
;assert 1

dist equ 1924
step equ 2891
time equ 2210

top    mov.b  2, #2148
       mov   sp, >top
       add #step, #-step*time
start  jmz.f -2, @-1
       jmn  top, *top
sp     spl   0, 0
       mov    2, >top-3
       djn.f -1, >top-3
       dat    0,  5-top

for 33
dat 0, 0
rof

scan   mov <boot, <dest
     for 8
       mov <boot, <dest
     rof
spl 2
boot   jmp start+dist, top+9
dest   jmp start,  dist+9

end scan

