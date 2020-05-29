;redcode-94nop
;name The Flood
;author Kiv Ridge
;assert (CORESIZE==8000)

                ORG pGo
pStep1 EQU 1241
pStep2 EQU 3421
pStep3 EQU 5001
bStep  EQU 100


pGo    SPL 1, {400
       MOV -1, 0
       SPL 1
       SPL 1, {4400

fsilk1 SPL @0, <pStep1
       MOV }fsilk1, >fsilk1

fsilk2 SPL @0, <pStep2
       MOV }fsilk2, >fsilk2

fsilk3 SPL @0, <pStep3
       MOV }fsilk3, >fsilk3

       MOV bsilk+1, <-bStep

ptr    SPL 1
       MOV bsilk+1, <ptr
       MOV bsilk+1, <ptr

bsilk  DJN -3, <-3
       DAT <2667, <2*2667

