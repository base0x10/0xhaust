;redcode-94m
;name Grendel
;author S.Fernandes
;strategy scanner
;assert 1
        org     shades
step    equ     7792
offset  equ     step
sep     equ     8
count   equ     444

target  mov.b   shades      ,    #speedup+1
wipe    mov     inc         ,    >target
loop    add     inc         ,    shades
shades  seq     }offset+sep ,    offset
        djn.f   target      ,    <target
speedup djn     loop        ,    #count
inc     spl     #step       ,    step
clear   mov     cleanup     ,    >clear-3
        djn.f   clear       ,    >clear-3
cleanup dat     >4001       ,    7
        end

