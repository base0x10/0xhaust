;redcode-94nop
;name Spellbinder
;author John Metcalf
;strategy oneshot
;assert CORESIZE==8000

; entered the KOTH.org 94nop hill in 1st place on 5th May 2014

        org    oneshot+1

        gate   equ clear-4
        dec    equ 2500
        step   equ 6140
        gap    equ 6
        first  equ bptr-1+step

bptr    dat    #1,       #11
dptr    spl    #dec,     13
clear   mov    *bptr,    >gate
        mov    *bptr,    >gate
        djn.f  clear,    }dptr

        for    5
        dat    0,0
        rof

oneshot add    inc,      scanptr
scanptr sne    first+gap,}first
        djn.f  oneshot,  *scanptr
        mov    scanptr,  gate
        jmp    clear-1,  <gate

        for    5
        dat    0,0
        rof

inc     dat    step,     step
        end

