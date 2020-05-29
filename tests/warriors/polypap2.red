;redcode-94
;name PolyPap II
;author Jakub/Roy
;assert 1
;strategy Q^4 -> Paper / ImpPaper
;strategy	v1.1 == added boot, minor optimization
;strategy	v1.2 == this version was developed Roy
;strategy			- added paperimp module !!!
;strategy			- Q^3 replaced by Q^4
;strategy			- new bombing routine
;
; ******* PolyPap II *********
; koth    - 140.00 (my bench.)
; wilfiz  - 135.73
; wilmoo  - 135.33
; wilkies - 167.89
; ********* PolyPap **********
; koth	  - 134.95
; wilfiz  - 130.66
; wikmoo  - 130.07
; wilkies - 160.76

	org 	qGo

P_STEP1 equ     560			; ###			# cp1 step
P_STEP2 equ     2680			; ####  PolyPap's	# cp2 step
P_STEP3 equ     -1120			; ####  constants	# cp3 step
B_STEP1	equ	7334			; ###			# boot step

D_STEP1 equ 	7454			; ### 			# cp step
B_STEP2 equ 	1319			; ####   Dawn's		# boot step
I_STEP 	equ 	1143			; ####  constants	# imp step
BOMB	equ	3237			; ###			# bomb step

; ========== PP BOOT ===============

p_start	spl     1, 	<qC		; ###
qTab2	spl	1, 	{qD		; #### generate 8 processes
	spl	1, 	<qE		; ###
	spl	d_start,<-2300

	mov.i	{p_cp1,	<p_boot1	; boot PolyPap
p_boot1	jmz.a	@0, 	B_STEP1		; if somebody attacked our copy
					; continue, else jump
; ============ POLYPAP =============

p_cp1  	spl     @p_cp3+1,<P_STEP1	; make 1st copy
        mov     }p_cp1,	>p_cp1

p_cp2  	spl     @0, 	<P_STEP2	; make 2nd copy
        mov     }p_cp2,	>p_cp2

	mov.i	#1, 	<1		; some bombing
	mov.i   <-3781,	{-2013		; decoy maker

        mov     {p_cp2,	{p_cp3		; make 3rd copy
p_cp3  	djn.f	P_STEP3,<1504		; jump there

for 24
	dat	0, 	0
rof

; ============= D BOOT =============

d_start	mov.i	{d_cp,	<d_boot		; boot Dawn
d_boot	jmz.a	@0,	B_STEP2		; split there

; ============== DAWN ==============

d_cp	spl     @imp+1,	}D_STEP1	; make copy
        mov.i   }d_cp,	>d_cp

launch  spl     #I_STEP,<-1+BOMB	; imp spiral launcher
	mov.i	bmb,	>jump		; do some bombing
        add.f   launch,	jump		; 8x => jmp.f imp2, ...
jump    djn.f   imp-I_STEP*8,{-6+BOMB	;  | =>	jmp.f imp2 + I_STEP, ...
					;  | => jmp.f imp2 + 2 * I_STEP
bmb	dat	<2667,	<5334		;  |		...
imp     mov.i   #I_STEP, *0		;  = 7pt imp spiral

for 24
	dat	0,	0
rof

; ============== Q^4 =============

	qX      equ     3080
        qA      equ     3532
        qB      equ     2051
        qC      equ     6177
        qD      equ     4696
        qE      equ     3215
        qF      equ     583

        qStep   equ     7
        qTime   equ     16
        qOff    equ     87

	dat	0,	qA
qTab1	dat	0,	qB

qBomb   dat     {qOff   , qF

qGo     sne     qPtr+qX*qE      , qPtr+qX*qE+qE
        seq     <qTab2+1        , qPtr+qX*(qE-1)+(qE-1)
        jmp     qDec            , }qDec+2
        sne     qPtr+qX*qF      , qPtr+qX*qF+qD
        seq     <qBomb          , qPtr+qX*(qF-1)+qD
        jmp     qDec            , }qDec
        sne     qPtr+qX*qA      , qPtr+qX*qA+qD
        seq     <qTab1-1        , qPtr+qX*(qA-1)+qD
        djn.a   qDec            , {qDec
        sne     qPtr+qX*qB      , qPtr+qX*qB+qD
        seq     <qTab1          , qPtr+qX*(qB-1)+qD
        djn.a   qDec            , *0
        sne     qPtr+qX*qC      , qPtr+qX*qC+qC
        seq     <qTab2-1        , qPtr+qX*(qC-1)+(qC-1)
        jmp     qDec            , {qDec+2
        sne     qPtr+qX*qD      , qPtr+qX*qD+qD
        jmz.f   p_start         , <qTab2

qDec    mul.b   *2      , qPtr
qSkip   sne     <qTab1  , @qPtr
        add.b   qTab2   , qPtr
qLoop   mov     qBomb   , @qPtr
qPtr    mov     qBomb   , }qX
        sub     #qStep  , @qSkip
        djn     qLoop   , #qTime
        djn.f   p_start , #0

        end

