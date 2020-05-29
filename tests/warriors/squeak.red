;redcode-94nop 
;name Squeak and Let Die
;kill Squeak and Let Die
;author P.Kline 
;assert CORESIZE == 8000 
;strategy scanner-bomber with Squeak! 

step   equ    2946 
Qgap   equ    13 
Lgap   equ    13 

next   add.ab #step+1       ,gate 
       mov    Squeak        ,<gate 
gate   jmz.f  next          ,@step-50 
wptr   jmp    fin           ,<gate 
   for 5 
       dat    0             ,0 
   rof 
Squeak dat    {-Qgap        ,Lgap 
fin    spl    #100          ,#5-gate 
       mov    *wptr         ,>gate 
       mov    *wptr         ,>gate 
       djn.f  -2            ,}fin

       end    next+1
