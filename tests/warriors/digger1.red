;redcode
;author Matthias
;name Digger V1
;assert 1

start   NOP     0, #10
ix2     for     4
               DJN     0 , <-100 - ix2
       rof
       djn -5 , #10
       MOV     start-1, -5
       JMP     -1 , <-1
ix      for     80
               dat 0, 1
       rof

