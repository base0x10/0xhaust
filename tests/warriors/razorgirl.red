;redcode-94nop
;name Razorgirl
;author S.Fernandes
;strategy oneshot
;assert 1

        org    decoy
step    equ    30
gap     equ    6
first   equ    loop+step*20

ptr     dat    first+gap     ,  first

        dat    0     ,  0

x       dat    1     ,  10
clr     spl    #3500 ,  15
        mov    *x    ,  >ptr
        mov    *x    ,  >ptr
        djn.f  clr+1 ,  }clr

        for    4
        dat    0     ,  0
        rof

loop    add    inc   ,  ptr
        sne    *ptr  ,  @ptr
        add    inc   ,  ptr
        sne    *ptr  ,  @ptr
        djn.f  loop  ,  *ptr
        djn.f  clr   ,  ptr
inc     dat    step  ,  step

        for    64
        dat    0     ,  0
        rof

decoy   mov    >loop+4-2500  ,  <loop+3-2510        
        mov    <loop+4-2510  ,  {loop+3-2520
        mov    {loop+4-2520  ,  <loop+3-2530
        mov    <loop+4-2530  ,  {loop+3-2540
        mov    {loop+4-2540  ,  <loop+3-2550
        mov.i  <loop+3-2560  ,  #0
        mov    {loop+4-2560  ,  <loop+3-2570
        mov    <loop+4-2570  ,  {loop+3-2580
        djn.f  loop+1,  <loop+4-1090

        end

