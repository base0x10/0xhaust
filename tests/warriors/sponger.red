;redcode-94b
;assert CORESIZE == 8000
;name   Sponger
;author doug

loc0 equ 937
loc1 equ 1600
binc0 equ 7115
binc1 equ 944
binc2 equ 52

ss  spl.b 1, 0
    mov.i -1, 0
    mov.i -1, 0
    mov.i -1, 0
s0  spl.b @0, <loc0
    mov.i }s0, >s0
s1  spl.b @0, <loc1
    mov.i }s1, >s1
j0  spl.b #j0, #j0
b0  mov.i >binc0+(binc1), {-binc0+(binc2)
b1  add.f i0, b0
    djn.f b0, *b0
i0  dat   #binc0, #-binc0


; Safety buffer (SIZE 24).
for 24
	dat 0, 0
rof

; Decoy (BLOCKS 21, SIZE 3, TOTAL 63).
for 21
	mov -10, <3000           ; DECOY (01)
	mov <5771, <4210         ; DECOY (06)
	mov <2055, {4482         ; DECOY (09)
rof
end ss

