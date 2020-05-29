;redcode-94
;name Crazy Days ... A20
;author Steve Gunnell
;strategy The Machine mod 8.
;strategy Like HazyLazy was intended to be.
;assert 1

STEP    equ (67*8)
GSTART  equ 5714
SIZE    equ (1+3)
SKIP    equ (Incr-Gate+2)
START   equ (2-STEP*596)

Top:    ADD.F   Incr    , Scan
Scan:   SNE.I    START  , START-4
        JMP     Top     , 0
Gate:   MOV.B   Scan    , #GSTART
        SLT.A   #3      , Scan
        MOV.I   }Wipe   , 1
        MOV.AB  #SIZE   , Bcnt
Wipe:   MOV.I   Incr    , >Gate
        MOV.I   *Wipe   , >Gate
Bcnt:   DJN.B   Wipe    , #SIZE
        JMP     Top     , 0
        DAT.F   $0     , $0
Incr:   SPL     #STEP   , #STEP
        DAT     {1      , SKIP
        for   (MAXLENGTH-CURLINE)
        DAT.F   $0     , $0
        rof

END Top
