;redcode-94nop 
;name tie my pretties, tie...
;author John Metcalf 
;strategy paper/imp + wimp 
;assert CORESIZE==8000 

        pstep  equ 2224 ; 5432 
        wpos   equ 4000 ; 5000 

warr    mov    wimp,       @wboot 
        spl    }0,         <2000 
wboot   spl    0,          wpos 

paper   spl    @paper-1,   {pstep-1 
        mov    }paper,     >paper 
        spl    #4000,      <1000 
        spl    imp+5334,   <3000 
        spl    imp+2667,   <4500 
imp     mov.i  #1000,      2667 

wimp    jmp    #0 

	end

