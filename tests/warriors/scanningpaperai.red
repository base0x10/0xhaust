;redcode-94
;name Scanning Paper AI
;author Christian Schmidt
;strategy bomb/scan then replicate
;assert 1

;----Replication----
l       equ     26
zofs    equ     2309

;------Bombing------
bo1     equ     6327
bo2     equ     2285
color   equ     686
a       equ     4029
b       equ     5354
c       equ     4846


sOff1   equ    4208
sOff2   equ    4064
sStep1  equ    3003
sStep2  equ    105

        add.f  sTab,     sScan
sScan   mov.i  }sOff1,   sOff2
        jmz.f  -2,       {sScan
        sub.a  #20,      sScan
        mov.i  <sRef,    {sScan
        djn    -1,       #9
sRef    jmp    *sScan,   d1+1

   for 5
        dat    0,        0
   rof

sTab    dat    #sStep1,  <sStep2

   for 68
        dat    0,        0
   rof

from    mov    #l,      #0
loop    mov    d1 ,     >a
        mov    d1 ,     >b
        mov    d1 ,     >c
        mov    <from,   {to
        jmn    loop,    from
        spl    >from,   }color
to      jmz    zofs,    *0
d1      dat    <5334 ,  <2667

        end    sScan

