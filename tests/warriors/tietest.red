;redcode-94nop
;name Tie Test
;author John Metcalf
;strategy paper/imp
;assert CORESIZE==8000

; aiming for maximum ties!

; scored 124 points (13% wins, 1% losses, 86% ties) when it
; entered the 94nop hill on 17th January 2014 (20th place)

        istep  equ 1143
        pstep  equ 808
        dpos   equ 1066
        pboot  equ paper-3845

        spl    1,        >-1941
        spl    1,        >-1934
        spl    1,        >2513

        mov    {paper,   {boot
boot    spl    pboot,    >-2564

paper   spl    @0+8,     >pstep
        mov.i  }paper,   >paper
        spl    #2291,    >impgo
        add.i  #istep,   impgo
impgo   jmp    imp-istep*8,>dpos

imp     mov.i  #1,       istep

        end

