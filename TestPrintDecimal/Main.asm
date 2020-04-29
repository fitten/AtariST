
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
	move.w	#123,d0
	move.w	#BUFFSIZE,d1
	
	jsr		ValueToDecimalASCII_16b
	
	lea		Buffer,a0
	jsr		putslnw
	
	
	jmp		ReturnToOS



	SECTION	DATA
	align 2
Message:	dc.b	'Number is: ',0
Buffer:		ds.b	BUFFSIZE
