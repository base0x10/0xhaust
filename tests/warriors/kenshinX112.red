;redcode-94nop
;name Kenshin X test 112
;author Steve Gunnell
;strategy Mirage style scanner with decoy.
;assert 1

STEP  equ  1453
START equ  4470
LEAP  equ  (head+2652)
bptr  equ  (head-2)

; Your decoy of choice goes here
      dat.f  1        ,1

boot  spl    LEAP     ,head
      mov.i  >boot    ,}boot
      mov.i  >boot    ,}boot
      mov.i  >boot    ,}boot
      mov.i  >boot    ,}boot
      mov.i  >boot    ,}boot
      mov.i  >boot    ,}boot
      mov.i  >boot    ,}boot
      mov.i  >boot    ,}boot
      mov.i  >boot    ,}boot
      mov.i  >boot    ,}boot
      sub.f  boot     ,boot
      dat.f  0        ,0

head  slt    #START   ,#tail-bptr+5
      mov.a  head     ,bptr
trash mov    *tail    ,}bptr
      add.a  #STEP    ,@hptr
      jmz.f  trash    ,*head
hptr  jmn.a  @hptr    ,head
      jmp    @hptr    ,}tail
tail  spl    #0       ,}0
      jmp    #0       ,}0
      dat.f  $0       ,$0

      end    boot

