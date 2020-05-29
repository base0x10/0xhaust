;redcode-94nop
;name Falcon Fly
;author Christian Schmidt
;strategy scanner
;assert 1

sStep   equ     2748
sAwa    equ     4556
sWip    equ     4320
  
stream  equ     (ptr-317)
imp     equ     2667
cstart  equ     (last+2-ptr)


ptr     dat.f   bomb1,          #805        
bomb3   dat.f   <imp,           <(2*imp)
bomb2   spl.a   #(bomb3-ptr),   cstart

for 3
        dat     0,              0
rof

top     mov.b   2,              #sWip
        mov     bomb1,          >top
        add     #sStep,         #sAwa
start   jmz.f   -2,             @-1
        jmn     top,            *top
bomb1   spl.a   #(bomb2-ptr),   cstart
clear   mov.i   *ptr,           >ptr
        mov.i   *ptr,           >ptr
last    djn.f   clear,          <stream

end     start

