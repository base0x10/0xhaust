;redcode-94nop
;name ZoomRescanner
;author Roy van Rijn
;assert 1

sStart  equ     sSpan-(sStep*900)
sStep   equ     6255
sSpan   equ     14

sTop    mov.ab  sScan           , #sRet
        mov.i   sBomb           , >-1
        add.f   sAdd            , 1
sScan   seq     sStart-sSpan    , }sStart
        djn.a   sTop            , @sTop
        jmn.f   *sRet           , @sTop
        mov.ab  #8              , sTop
        mov.a   #-6             , 1
sRet    jmn.a   sScan-1         , sTop

sAdd    spl     #sStep          , sStep
        mov.i   2               , >sTop+1
        djn.f   -1              , >sTop+1
        dat     <2667           , >17

for 10
        dat     0               , 0
rof

sBomb   spl     #0              , }0

end sScan

