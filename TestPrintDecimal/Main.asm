
	xref	ReturnToOS
	xref	puts
	xref	putsln
	xref	putslnw
	xref	ValueToDecimalASCII_16b
	
BUFFSIZE	EQU	32
	
	SECTION	CODE
Main:
	lea		Message,a0
	jsr		puts
	
	lea		Buffer,a0
	move.l	a0,-(sp)
	move.w	#BUFFSIZE,-(sp)
	move.w	#$A5,-(sp)
	
	jsr		ValueToDecimalASCII_16b
	
	add.l	#8,sp
	
	lea		Buffer,a0
	jsr		putslnw
	
	lea		Bye,a0
	jsr		putslnw
	
	jmp		ReturnToOS



	SECTION	DATA
	align 2
Message:	dc.b	'Number is: ',0
	align 2
Buffer:		ds.b	BUFFSIZE
	align 2
Bye:		dc.b	'Done.',0
