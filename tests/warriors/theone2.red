;redcode-94nop
;assert 1
;name The One v2
;author Catageek
;strategy 0.75c scan/stone + spl-dat clear
;date 2009-Dec-7
;version 2

;org     sGo

STEP    equ	3271
START   equ     4587
LENGTH  equ     (fin-sGo)-(ptr-sGo)
GATE	equ	1520
TARGET	equ	2978
TARGET2	equ	80

sGo     add     step,   @4     ; 0.75c scan
ptr     sne.x   START,  START
back	add.x   step,   ptr
	jmz.f   sGo,    @ptr
	
	slt	#LENGTH,ptr
	jmp	sGo


sBomb	mov     bomb,	>ptr
	mov	bomb+1,	>ptr

	mov.ba	ptr,	*0

	djn	sGo,	1

count	jmp	c1,	7

	for	22
	dat	0,	0
	rof
	
; data

step    spl     #2*STEP,>STEP

	for	22
	dat	0,	0
	rof

bomb	spl	#2,	>2
	mov	-1,	}-1

	for	22
	dat	0,	0
	rof

; clear

ptr2    dat     -TARGET2,	TARGET	; <- move to this pointer
c1      spl     #7998,	<ptr1-ptr2	; <- core-clear spl bomb, also imp-gate
c2      mov     @ptr1,  >ptr2		; <- does all the moves
	mov     @ptr1,  {ptr2		; <- does all the moves
c3      djn.f	c2,	<ptr2-GATE
ptr1    dat     0,	#c1		; <- move from this pointer


	for	4
	dat	0,	0
	rof

bomb2	dat	<5334,<2667

fin	end

