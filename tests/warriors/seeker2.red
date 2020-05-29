;redcode-94
;name Seeker
;author Strake
;assert CORESIZE==8000

org scan

step    equ 7440
gap     equ 40
s1      equ tail+MINDISTANCE    ; initval of 1st scan ptr
s2      equ tail+MINDISTANCE+gap; initval of 2nd scan ptr

top

ammo:   spl 0

inc:    dat #step, #step

kmod:   add.ab #120, $scan+4    ; reset scan counter
        add.a #1, $strike       ; dat bomb mode
scan:   add.f $inc, $ptr        ; .8c scanning loop
ptr:    sne.i $s1, $s2          ; where to scan
        add.f $inc, $ptr
        sne.i *ptr, @ptr
        djn.b $scan, #120       ; lather, rinse, repeat
        sne.a #ammo+1, $strike  ; if already kill mode
        jmp $cc                 ; core clear
        jmz.b $kmod, $-2        ; else switch to kill mode *evil grin*
strike: mov.i $ammo, }ptr       ; bombs away!
        djn.b $strike, #gap     ; loop counter
        add.ab #gap, $-1        ; reset loop counter
        jmp $scan               ; here we go again

cc:     mov.i $ammo, >4         ; core clear (spl carpet)
        djn $cc, #CORESIZE-4    ; next
        add.a #1, $cc           ; dat clear mode
        mov $1, $-2
        jmp $cc, $1

tail:   end 

