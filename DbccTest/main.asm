	xref	ReturnToOS
	xref	PrintString
	xref	PrintChar
	xref	WaitAnyKey
	xref	NewLine
	xref	RegisterDump

	SECTION	CODE
Main:
	lea		StartString,a3
	jsr		PrintLine
	clr.l	d0
	clr.l	d1
	move.w	#'1',d0
	move.w	#8,d1
Loop:
	jsr		RegisterDump
	jsr		PrintChar
	jsr		NewLine
	jsr		WaitAnyKey
	addq	#1,d0
	dbeq.w	d1,Loop
	

	lea		EndString,a3
	jsr		PrintLine
	jsr		WaitAnyKey
	jmp ReturnToOS
	
	SECTION	DATA
StartString:	dc.b	'Starting....',0
EndString:		dc.b	'End.',0