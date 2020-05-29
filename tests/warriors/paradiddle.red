;redcode-94
;name Paradiddle
;author Sheep
;strategy   drop some quick bombs -> Paper / Imps
;assert 1

FS1	equ	2000
FS2	equ	2900
FS3	equ	3800
FS4	equ	4700
FS5	equ	5600
FS6	equ	6500

O1	equ	3875
O2	equ	2312
O3	equ	6276

B1	equ	750
BD1	equ	6890
CCO	equ	-450

ISZ	equ	2667
IMPDIS	equ	665
IMPSIZE	equ	3
AIMP	equ	(imp - IMPDIS)
BIMP	equ	(imp - 2*IMPDIS)
CIMP	equ	(imp - 3*IMPDIS)

QB	equ	(spiral+500)
QS	equ	220


qBomb1	spl	qBomb2, {FS4
ipy	for	6
	mov.i	{QB+ (2*ipy-2)*QS, {QB+ (2*ipy-1)*QS
	rof
spiral	mov.i	imp	, AIMP
	mov.i	imp	, BIMP
	mov.i	imp	, CIMP
	spl	1	, <FS5
	spl	1	, }FS6
	spl	*vt+1	, }0
	spl	*vt+1+IMPSIZE+1, }0
	spl	@vt+1+IMPSIZE+1, }0
vt	jmp	@vt+1	, }0
idx	for	IMPSIZE+1
	dat	#AIMP+ (idx-1)*ISZ, #imp+ (idx-1)*ISZ
	rof
idy	for	IMPSIZE+1
	dat	#BIMP+ (idy-1)*ISZ, #CIMP+ (idy-1)*ISZ
	rof
imp	mov.i	#ISZ	, *0	

pc	for	MAXLENGTH-CURLINE-22
	dat.f	$0, $0
	rof

qBomb2
ipy	for	9
	mov.i	{QB+ (2*ipy+10)*QS, {QB+ (2*ipy+11)*QS
	rof

paper	spl 2, <FS1    
      	spl 2, <FS2     
     	spl 1,   }0      
    	spl 1, {FS3   

one	spl	@0  , #O1
	mov.i	}one, >one
two	spl	@0  , #O2
	mov.i	}two, >two
	mov.i	}B1 , <BD1
	mov.i	{two, {three
three	spl	O3  , #CCO
 	mov.i 	2   , <three
        djn.f 	-1  , <three

	end	qBomb1

