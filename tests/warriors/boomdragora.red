;redcode-94
;author Christian Schmidt
;name Boomdragora
;strategy Bomb/Scan into Mandragora
;assert 1
;kill Boomdragora

;optimax 1234
;optimax work mandra4b
;optimax rounds 1 100 200 200
;optimax suite fsh94nop0.3

;optimax phase2 fsh94nop0.3/scn/recon2.red
;optimax phase2 140

;optimax phase3 top20
;optimax phase3 scn:pap
;optimax phase3 154

;optimax phase4 top20
;optimax phase4 100%

cAwa    equ     5691
iAwa    equ     5364
jAwa    equ     5539
cSwch   equ     5585

ptr   equ (wipe-5)

iStep   equ     2667

sOff1   equ    6924
sOff2   equ    3414
sStep1  equ    3854
sStep2  equ    6931

org sScan

zero   add.f    sTab,          sScan
sScan  mov.i    }sOff1,        sOff2
       jmz.f    -2,            {sScan
       mov.i    sTab,          *sScan
       mov      imp,           zero+jAwa
       djn.f    pGo,           <2954

for     6
        dat     0,              0
rof

pGo     mov     <wipe+5,        <bPtr1
bPtr1a  spl     1,              <7140
        spl     1,              <6813
        mov     <wipe+5,        <bPtr1
        mov     <iGo+4,         {bPtr2
bPtr1   spl     zero+cAwa-4,    zero+cAwa
bPtr2   djn.f   zero+iAwa,      <645

for     24
        dat     0,              0
rof

sTab    dat    #sStep1,  <sStep2

for     15
        dat     0,              0
rof

imp     mov.i   #iStep,         *0


for     3
        dat     0,              0
rof

iGo     spl     #iStep,         <3584
        add.f   iGo,            iPtr
iPtr    spl     jAwa-iAwa-iStep+1,  <5431
        djn.f   cAwa-iAwa-3,    <228

for     28
        dat     0,              0
rof

wipe    dat     1,              14
clear   spl     #cSwch,         14
        mov     *wipe,          >ptr
        mov     *wipe,          >ptr
        djn.f   -2,             }clear

end 

