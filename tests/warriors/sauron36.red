;redcode-94
;name Sauron v3.6
;author Michael Constant
;strategy  quick-scan -+-(found enemy)--> spl/dat cclear --> hyperperfect gate
;strategy              \-(found nothing)--> 3x4 spiral and cclearing stone
;kill Sauron
;macro
;assert 1

DIST    equ     2300

cclear  mov     split,  <-10
        jmz.a   cclear, last+10
split   spl     #11,    >-30
        mov     bomb,   <-5
jump    jmp     -1,     >-32

f
impgen  spl     1,      stone+4+1
        mov     -1,     0
        spl     1 
        spl     1 
        spl     2
        jmp     @0,     imp
        add     #2667,  -1

bomb    dat     >-31,   >-32          ; this will stop gate-crashers

look
qscan   for     35  ;this would be 38 if there was enough room in the program
        cmp.i   look+((qscan+1)*100), look+4000+((qscan+1)*100)
        mov.ab  #-25+look+((qscan+1)*100)-found, @found
        rof

found   jmz     blind,  #0
zap     mov.i   split,  >found
        mov.i   jump,   @found
        add     #4002,  found
        djn     -3,     #45
t       jmp     cclear, stone+4+1+DIST

stone   mov.i   <0+11,  3-11
        spl     -1,     <-3000
        add.f   toadd,  -2
        djn.f   -2,     <-3002
toadd   mov     11,     <-11

blind   spl     impgen
        mov     <f,     <t
        djn     -1,     #5
        jmp     stone+DIST

last
imp     mov.i   #0,     2667

        end     look
