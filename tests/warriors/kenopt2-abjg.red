;redcode-94
;name Kenshin B test 89
;author Steve Gunnell
;strategy Similar in style to the RB scanner but
;strategy reworked from the ground up 8-).
;strategy Loosend starting constraints and added decoy.
;assert 1

STEP  equ  1294
fDec  equ  (bptr-176)
START equ  34

bptr  equ  head-2

head  slt    #START   ,#tail-(bptr)+5
go    mov.a  head     ,bptr
trash mov    tail     ,}bptr
      add.a  #STEP    ,@hptr
      jmz.f  trash    ,*head
hptr  jmn.a  @hptr    ,head
      jmp    @hptr    ,}trash
tail  spl #0, }0
      dat <2667, <5334
      dat <1143, <2286

      end   go

