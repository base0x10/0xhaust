;redcode-94nop
;name Monowire
;author Miz
;strategy Oneshot
;strategy First Koth-ready version
;assert 1

n equ 5
const equ  24

up add.f      3,   1
sc sne.i  -6833, -6840
   djn.f     -2, <-300
   spl   #const, #const
   mov.i     @2, >sc
   mov.i     @1, >sc
   djn.f     -2, {2
   dat      -20,  7
   spl    #-500,  8

for 12
spl #n*356,>n*653
spl }3653+n,@3566-n
spl >253*n,3656+n
spl #35*n, *n*355
spl <256+n,>64*n-5*n
rof
boot mov <src, <dst
for 8
     mov <src, <dst
rof
src spl @dst, up+9
dst dat #1, -1100+9
end boot
