;redcode-94nop
;name uffa!
;author C. De Rosa
;strategy scan
;assert CORESIZE==8000

ciao	DAT	0,	4000
step    DAT	#1443,	#1443
PUNT	DAT	-261, -255
bomb2	DAT	8,	8
start   spl	#16,	#16
wipe1	mov	start, }ciao
wipe2	djn	wipe1,#0
	djn.a	wipe1,wipe1

sciot	mov	start,>ciao
scan	sub	step,PUNT
sott	seq	*PUNT,@PUNT
	SLT	#(fine-ciao+12),PUNT
cont	DJN	sciot,#6000
	MOV	PUNT,ciao
	JMN	sciot,cont
	jmp	wipe1

fine
end sott

