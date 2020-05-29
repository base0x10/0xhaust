;redcode-94nop
;name Rolling Thunder 2
;strategy 0.8c scanner
;author Anton Marsden
;assert CORESIZE==8000

ptr EQU (bomb-6) ; 11

step EQU 9

bomb  spl.x  #1,{1
kill  mov    bomb,<ptr
mptr  mov    >ptr,>ptr
      jmn.f  kill,>ptr
top   jmn.f  chk, @ptr   ;; an innovation - scans directly after the bombing run
a     sub.x  #-step, ptr
      sne.x  *ptr, @ptr  ;; using SNE.X instead of SNE.I
      sub.x  @0, @a
scan  jmz.f  top, *ptr
      mov.x  @mptr,@mptr
chk   slt.b  ptr,#btm-ptr+3
      djn    kill,@mptr
      djn    a,#16
btm:  jmp    a,{kill

FOR 68
      dat 0,0
ROF

away EQU (bomb-2300) 

boot: mov    btm,@dest
N FOR 12
      mov    btm-N,<dest
ROF
      spl    @dest,1
dest: mov    sVal,@away
      mov    bomb,<dest
      div.f  #0,dest
sVal  dat    400,4400

END boot

