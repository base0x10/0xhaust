;redcode-94nop
;name Sneaky Tweaky
;author Schmidt/Metcalf
;strategy Self-Replicating Stone/scanner
;assert CORESIZE == 8000

sLen   equ 21
sOff1  equ 219+sStep1
sOff2  equ 7771+sStep2
sStep1 equ 3431
sStep2 equ 3916
sAwa   equ 2543

pAwa   equ 5895


sStart  mov     #sLen,   #sLen
sGo     add.f   sTab,    sScan
sScan   mov.i   }sOff1,  sOff2
        jmz.f   -2,      {sScan
        mov.i   iBmb,    }sScan
        mov     <sStart, {to
        jmn     -2,      sStart
        spl     >sStart, }-200
to      jmz     sAwa,    *0
sTab    dat     <sStep1, >sStep2
iBmb    dat     <2667,   <5334

        end     sScan

