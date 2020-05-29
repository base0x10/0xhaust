;redcode-94
;name silk4
;author christian m.
;assert 1
;strategy q^3 scanner, replicator, linear bombing
;strategy thanks to christian s. for helping

size  		equ 1800
size2 		equ 2200
size3 		equ 3044

init 		spl    		2
    		spl    		2
    		spl    		1
    		mov    		-1	,	0
silk  		spl.a  		@0 	, 	{size
      		mov.i  		}silk 	, 	>silk
silk2 		spl.a  		@0 	, 	<size2
      		mov.i  		}silk2 	, 	>silk2
silk3 		spl.a  		@0 	,	<size3
      		mov.i  		}silk3 	, 	>silk3
x    		mov    		bomb 	, 	<500
      		djn.f  		x 	, 	{-234
bomb  		mov.i 		#1	, 	<1

;bomb dat    <2667 , <5334

for 45
	dat 0, 0
rof


org 		qGo

qf 		equ 	qKil
qs 		equ 	200
qd 		equ 	4000
qi 		equ 	7
qr 		equ 	8

qBmb 		dat  	{qi*qr-10	, {1
qGo  		seq  	qd+qf+qs	        , qf+qs
    		jmp  	qSki		, {qd+qf+qs+qi+2
    		sne  	qd+qf+5*qs	, qf+5*qs
    		seq  	qf+4*qs		, {qTab
		jmp  	qFas		, }qTab
		sne  	qd+qf+8*qs	, qf+8*qs
    		seq  	qf+7*qs		, {qTab-1
    		jmp  	qFas		, {qFas
		sne  	qd+qf+10*qs	, qf+10*qs
    		seq  	qf+9*qs		, {qTab+1
		jmp  	qFas		, }qFas
		seq  	qd+qf+2*qs	, qf+2*qs
		jmp	qFas		, {qTab
		seq	qd+qf+6*qs	, qf+6*qs
		djn.a	qFas		, {qFas
		seq  	qd+qf+3*qs	, qf+3*qs
      		jmp  	qFas		, {qd+qf+3*qs+qi+2
		sne  	qd+qf+14*qs	, qf+14*qs
		seq 	qf+13*qs  	, <qTab
		jmp  	qSlo		, >qTab
		sne  	qd+qf+17*qs	, qf+17*qs
		seq  	qf+16*qs	        , <qTab-1
		jmp  	qSlo		, {qSlo
		seq  	qd+qf+11*qs	, qf+11*qs
		jmp  	qSlo		, <qTab
		seq  	qd+qf+15*qs	, qf+15*qs
		djn.b	 qSlo		, {qSlo
		sne  	qd+qf+12*qs	, qf+12*qs
		jmz  	init		, qd+qf+12*qs-qi
qSlo 		mov.ba 	qTab		, qTab
qFas	 	mul.ab 	qTab		, qKil
qSki  		sne  	qBmb-1		, @qKil
    	 	add  	#qd		, qKil
qLoo  		mov.i  	qBmb		, @qKil
qKil	  	mov.i  	qBmb		, *qs
      		sub.ab 	#qi		, qKil
      		djn    	qLoo		, #qr
      		jmp    	init		, <-4000
    		dat  	5408		, 7217
qTab  		dat  	4804		, 6613
dSrc  		dat  	5810		, qBmb-5

end

