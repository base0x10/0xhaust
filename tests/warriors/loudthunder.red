;redcode-94nop
;name Loud Thunder
;strategy .8c scanner
;author Roy van Rijn
;assert 1

ptr dat 4400,400

dat 0,0
dat 0,0
dat 0,0

bomb  spl.x  #0,}0

dat 0,0
dat 0,0
dat 0,0

kill  mov    bomb,<ptr
      mov    >ptr,>ptr
iptr  jmn.f  kill,>ptr
top   jmn.f  chk, @ptr
a     sub.f  #-9, ptr
      sne.x  {ptr, @ptr
      sub.f  a, @iptr
scan  jmz.f  top, *ptr
      mov.x  @iptr,@iptr
chk   slt.b  @iptr,#btm-ptr+2
      djn    kill,@iptr
      djn    a,#15
btm:  jmp    a,{kill

end top

