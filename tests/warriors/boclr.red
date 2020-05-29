;redcode-94nop quiet
;name Boclr
;author Roy van Rijn
;strategy Bombing clear scanner
;strategy New type of scanner trick
;assert 1

        times   equ 499
        step    equ 208
        span    equ 8

clrPtr  dat   shoot+1,0
scnPtr  dat   scan+3+(times*step)  , scan+3+span+(times*step)

for 8
dat 0,0
rof

clear   spl     #step           , }step+1
        mov.i   b               , >clrPtr
        djn.f   -1              , >clrPtr
b       dat     <2667           , }16

for 10
dat 0 , 0
rof

att     mov.x   scnPtr          , clrPtr
shoot   mov.i   clear           , @scnPtr ;gets self-mutated in @clrPtr
incr    sub.f   clear           , scnPtr
scan    seq.i   *scnPtr         , >scnPtr
        djn.b   att             , {clrPtr
loop    jmp     shoot           , >clrPtr ;gets bombed with SPL bomb
gate    jmp     clear

end scan 

