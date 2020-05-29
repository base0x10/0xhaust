;redcode-94nop
;assert 1
;name nesca3.1a
;author lain
;version 3.1a


steps     equ     22
hob     equ     6-10

pointer        dat #2,#120
            dat.f #1,>5
dstart        spl #1,5
     mov.i *pointer,>pointer

             djn.f -1,{-8
step         dat #steps,#steps

            add.f step,scan
scan        sne.b $MINDISTANCE+10+hob,$MINDISTANCE+20+hob
            djn.a -2,{ -100 ;{-2*MINDISTANCE-1100

            mov.ab scan,pointer
            jmp dstart

    end scan
