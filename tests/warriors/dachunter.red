;redcode
;name D&C hunter
;author Neo
;assert CORESIZE==8000
;strategy Basic oneshot

step equ (19*8) 	;mod 8 scan

ptr:	dat 0,-1+step      ;pointer
	dat 0,0
	dat 0,0
sbm:	dat <2667,5-ptr
clear:	spl #-900,6-ptr
	mov @bpt,>ptr
	mov @bpt,>ptr
bpt:	djn.f -2,{clear
for 19
	dat 0,0
rof
loop:	add.ab #step,ptr
scan:	jmz.f loop,@ptr		;<--starts here
	jmp clear,<ptr
end scan

