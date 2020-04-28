	include "Global_Inc.asm"

	xref	PrintPuzzle
	xref	NewLine
	xref	PrintLine
	xref	WaitAnyKey
	xref	SolveSudoku
	xref	ReturnToOS
	xref	Grid1
	xref	Grid1RootSize
	xref	Grid1RowLength
	xref	putslnw
	
	SECTION	CODE
Main:
	lea		BeginMessage,a0
	jsr		putslnw
	
	lea		Grid1,a3
	move.w	Grid1RowLength,d7
	move.w	Grid1RootSize,d6
	
	jsr		PrintPuzzle
	jsr		NewLine
	jsr		WaitAnyKey

	lea		Grid1,a3
	move.w	Grid1RowLength,d7
	move.w	Grid1RootSize,d6	
	jsr		SolveSudoku
	jsr		NewLine

	lea		Grid1,a3
	move.w	Grid1RowLength,d7
	move.w	Grid1RootSize,d6
	jsr		PrintPuzzle
	jsr		WaitAnyKey
	jsr		NewLine
	
	lea		ExitMessage,a0
	jsr		putslnw
	jmp		ReturnToOS



	SECTION	DATA
	align 1
BeginMessage:	dc.b	'Starting Program.',0
	align 1
ExitMessage:	dc.b	'Exiting Program.',0
