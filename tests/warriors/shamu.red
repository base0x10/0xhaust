;redcode-94nop
;name Shamu
;author P.Kline
;strategy oneshot, spl-wipe, sd clear
;assert 1

fPeek    equ     16
fFlag    equ     (lLoop+fPeek)
fStep    equ     (1001+7*7201)

fStart   add.ab  #fStep   ,fPtr
         mov     lGate    ,@fPtr
fPtr     jmz.f   fStart   ,*fFlag-fStep*235
         jmn.f   lGeist   ,fFlag
fJmp     jmp     leach
     for 39
         dat     0,0
     rof
lGate    dat     -fPeek   ,2700
lBmb     dat     1        ,fPeek
lGeist   spl     #lGate+100 ,8-lGate
         mov     *lBmb    ,>lGate
         mov     *lBmb    ,>lGate
         djn.f   -2       ,}lGeist
     for 26
         dat 0,0
     rof
leach    add.b   fPtr     ,lPtr
lWipe    jmz.f   #0       ,>lPtr
lPtr     jmp     lLoop    ,fPtr-fPeek-101
     for 7
         dat     0,0
     rof
lLoop    mov     lGeist   ,>lPtr
         slt.ab  @lPtr    ,#120
         slt.ab  @lPtr    ,#-110
lCnt     djn     lLoop    ,#102
         mov     lPtr     ,lWipe
         add.ab  @lPtr    ,lWipe
         mov     lGeist   ,>lWipe
         djn.a   -1       ,lWipe
         jmn.b   lCnt     ,lCnt
         jmp     lGeist

         end     fStart+1

