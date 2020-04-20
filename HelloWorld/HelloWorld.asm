	xref	PrintString
	xref	NewLine
	xref	WaitAnyKey
	xref	ReturnToOS

	SECTION CODE

_start:
_Main:
	lea		Message,a3
	jsr		PrintString
	jsr		NewLine
	jsr		WaitAnyKey
	
	jmp		ReturnToOS
	

	SECTION	DATA

Message:	dc.b	'Hello World, Shane!', 0
	even

