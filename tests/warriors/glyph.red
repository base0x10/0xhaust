;redcode-94nop
;name Glyph
;author inversed
;strategy Blur-type scanner with original zoom-trick,
;strategy core colouring and separate d-clear
;assert (CORESIZE==8000) && (MAXPROCESSES==8000)

clear   equ     inc
hop     equ     9
step    equ     2587
time    equ     700
zofs    equ     (-1-step*time)%CORESIZE
cptr    equ     (ptr)
gap1    equ     9
gap2    equ     10

org     bptr

bptr    jmp     *xtart, }0
       mov     bomb,   >bptr
ptr     seq     zofs,   }zofs+hop
xtart   mov.ab  ptr,    bptr
       add     inc,    ptr
jl      jmz     ptr,    bptr
e1      djn.f   ptr,    jl

       for     gap1
       dat     0,      0
       rof

inc     spl     #step,  step
       mov     kill,   >cptr
       djn.f   -1,     >cptr
kill    dat     0,      (kill-cptr+2)

       for     gap2
       dat     0,      0
       rof

bomb    spl     #1,     1



