;redcode-94
;name Sugartooth
;author Miz
;assert 1

ORG	16
SPL.B	#	0,	$	0	 
SPL.B	#	0,	#	0	 
SPL.B	#	0,	#	0	 
SPL.B	#	0,	#	28	 
MOV.I	$	2,	>	-1	 
JMP.B	$	-2,	$	0	 
DAT.F	$	0,	$	0	 
DAT.F	$	0,	$	0	 
DAT.F	$	0,	$	0	 
DAT.F	$	0,	$	0	 
DAT.F	$	0,	$	0	 
DAT.F	$	0,	$	0	 
DAT.F	$	0,	$	0	 
DAT.F	$	0,	$	0	 
DAT.F	$	0,	$	0	 
JMP.B	*	18,	$	0	 
ADD.F	$	3,	$	-1	 
MOV.I	@	0,	@	-2	 
JMN.F	$	-2,	$	15	 
SPL.B	#	2376,	#	-2376	 
MOV.I	$	2,	>	-23	 
DJN.F	$	-1,	>	-24	 
DAT.F	$	0,	$	35	 
DAT.F	$	0,	$	0	 
DAT.F	$	0,	$	0	 
DAT.F	$	0,	$	0	 
DAT.F	$	0,	$	0	 
DAT.F	$	0,	$	0	 
DAT.F	$	0,	$	0	 
DAT.F	$	0,	$	0	 
DAT.F	$	0,	$	0	 
DAT.F	$	0,	$	0	 
DAT.F	$	0,	$	0	 
JMP.B	$	-33,	#	1	 
END

