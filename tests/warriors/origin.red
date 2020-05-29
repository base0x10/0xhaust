;redcode-94nop
;name Origin of Storms v2
;author John Metcalf
;strategy v2 scanner
;assert CORESIZE==8000

; entered the KOTH.org 94nop hill in 11th place on 10th May 2014

scan    sne    222,     3517   ; scissors / scanner
        add    inc,     scan   ; - sparse attack on empty memory
        mov    bomb,    }scan  ; - dense attack on occupied memory
        mov    bomb,    >scan
        djn    scan,    #343

bomb    spl    #1,      1
clear   mov    inc,     >scan  ; clear / wipe memory
        djn.f  clear,   >scan
inc     dat    12,      12

        end

