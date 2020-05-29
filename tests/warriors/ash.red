;redcode-94nop
;name Ash
;author John Metcalf
;strategy scanner
;assert CORESIZE == 8000

; wondering whether HSA scanners are still effective

; scored 135 points (43% wins, 50% losses, 7% ties) when it
; entered the 94nop hill on 28th January 2014 (10th place)

        x equ 3718
        y equ -2207
        step equ 17
        count equ 15

ptr     dat   y,     x+y-1

        for   3
        dat   0,        0
        rof

        dat   >0,       0
sb      spl   #0,       {0

wipe    mov   @bp,      <ptr
        mov   >ptr,     >ptr
        jmn.f wipe,     >ptr

scan    sub   inc,      ptr
        sne.x @ptr,     *ptr
inc     sub.x #-step,   ptr
        jmn.f hit,      @ptr
        jmz.f scan,     *ptr

        mov.x @scan,    @scan
hit     slt.b @scan,    #last+3-ptr
        djn.f wipe,     ptr
        djn   scan,     #count
bp      djn.f scan,     #sb

last    end   scan+1

