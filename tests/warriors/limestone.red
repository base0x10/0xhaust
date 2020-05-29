;redcode-94nop
;name Limestone
;author John Metcalf
;strategy stone/imp
;assert CORESIZE == 8000

; entered the KOTH.org 94nop hill in 2nd place on 30th April 2014

        org    start

        step   equ 4485

        dat    3

        for    3
        dat    0,0
        rof

inc     spl    #step,      >-step
stone   mov    >step,      -7-step
        add    inc,        stone
        djn.f  stone,      <-2496

        for    65
        dat    0,0
        rof

        istep  equ 2667
        iboot  equ imp-1126

start   spl    stone-1,       <1450
        mov    imp,           iboot
        spl    8,             <1550
        spl    4,             <1650
        spl    2,             <1750
        jmp    iboot,         <1850
        jmp    iboot+istep,   <1950
        spl    2,             <2050
        jmp    iboot+istep*2, <2150
        jmp    iboot+istep*3, <2250
        spl    4,             <2350
        spl    2,             <2450
        jmp    iboot+istep*4, <2550
        jmp    iboot+istep*5, <2650
        spl    2,             <2750
        jmp    iboot+istep*6, <2850
        jmp    stone-1,       <2950

imp     mov.i  #1,        istep

        end

