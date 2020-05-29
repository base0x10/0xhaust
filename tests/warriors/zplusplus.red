;redcode-94nop 
;name Z++
;author Anton Marsden 
;strategy spl/spl/jmp scanner 
;strategy v2: improved scanner resistance 
;strategy v3: more step tweaking 
;assert CORESIZE==8000 
;kill Z++ 

step equ 228 
first equ (step+scan+1) 

bOff equ (dest+2605) 
jumpLoc equ (loop+step-1) 

org     boot 

boot    mov     last, <dest 
        mov     {boot, <dest 
dest    mov     dbomb, *bOff 
        mov     {boot, <dest 
        mov     {boot, <dest 
        mov     {boot, <dest 
        mov     {boot, <dest 
        mov     {boot, <dest 
        spl     @dest 
        mov     {boot, <dest 
        mov     {boot, <dest 
        add.ab  #jumpLoc+2-scan,dest 
        mov     jump,  <dest 
        div.f   #0, dest 
top     mov     split,   <scan 
        mov     >scan,   >scan 
scan    mov     step-1,  step+1      ; scanned 
loop    add.ab  {0, }0 
gate    jmz.f   -1,      >scan 
        djn.b   top,     @top 
split   spl     #0, 0           ; scanned 
        mov     dbomb,   >gate 
last    djn.f  -1,       >gate 
        dat     0,0 
        dat     0,0 
jump    jmp     -2 
dbomb   dat     <2667,   dbomb-gate+4 



FOR 13 
dat 0,0 
rof 

; big decoy 
      dat #0,0 
      spl.b #1, 1 
      spl.a #1, 1 
      spl.f #1, 1 

      jmp #0,0 
      spl.ba #1, 1 
      spl.ab #1, 1 
      spl.x #1, 1 

      mov #0,0 
      spl.i #1, 1 
      spl.a #1, #1 
      spl.f #1, #1 

      sne #0,0 
      sne.b #1, 1 
      sne.a #1, 1 
      sne.f #1, 1 

      add #0,0 
      djn.b #1, 1 
      djn.a #1, 1 
      djn.f #1, 1 

      sub #0,0 
      sub.b #1, 1 
      sub.a #1, 1 
      sub.f #1, 1 

      mul #0,0 
      mul.b #1, 1 
      mul.a #1, 1 
      mul.f #1, 1 

      div #0,0 
      div.b #1, 1 
      div.a #1, 1 
      div.f #1, 1 

      djn #0,0 
      djn.b #1, 1 
      djn.a #1, 1 
      djn.f #1, 1 

      mov.b #0,0 
      mov.b #1, 1 
      mov.a #1, 1 
      mov.f #1, 1 

      mov.x #0,0 
      mov.b #1, #1 
      mov.a #1, #1 
      mov.f #1, #1 

      add.x #0,0 
      spl.b #1, {1 
      spl.a #1, {1 
      spl.f #1, {1 

      sub.x #0,0 
      spl.b #1, <1 
      spl.a #1, <1 
      spl.f #1, <1 

      mul.x #0,0 
      spl.b #1, >1 
      spl.a #1, >1 
      spl.f #1, >1 

      div.x #0,0 
      spl.b #1, }1 
      spl.a #1, }1 
      spl.f #1, }1 

