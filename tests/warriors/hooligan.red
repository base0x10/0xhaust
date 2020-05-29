;redcode-94
;name 	Hooligan
;author G.Labarga
;assert CORESIZE==8000

;strategy	Blur-style scanner

	cmod equ 4
	step equ 19*2*cmod	;19*19
	gate equ ptr-2
	decoy equ scan-2204

ptr:	mov.i *1,>4000
loop:	mov inc,>ptr
scan:	seq.i }step+cmod,}step
	mov.b @1,@loop
	sub.f inc,scan
	jmn.b loop,scan
inc:	spl #-step,-step
clop:	mov.i bmb,>gate
	djn.f clop,>gate
bmb:	dat <2667,13
for 79
	dat 0,0
rof
	seq.i }92,}88
	djn.f -1,{decoy+8-4
start:	mov.i {decoy+1,<decoy+7		;transparent ~3c decoy maker
	mov.i {decoy+2,<decoy+6
	mov.i <decoy+3,{decoy+10
	djn.f scan,<decoy+14
	jmp scan,<decoy+15

	end start

