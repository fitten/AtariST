	xref	PrintPuzzle
	xref	NewLine
	xref	PrintLine
	xref	WaitAnyKey
	xref	SolveSudoku
	xref	ReturnToOS
	xref	Grid1
	xref	Grid1RootSize
	xref	Grid1RowLength
	xref	PrintStringPtrLineWait
	
	SECTION	CODE
Main:
	lea		StartMessage,a0
	jsr		PrintStringPtrLineWait
	
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
	jsr		PrintStringPtrLineWait
	jmp		ReturnToOS



	SECTION	DATA
	align 1
StartMessage:	dc.b	'Starting Program.',0
	align 1
ExitMessage:	dc.b	'Exiting Program.',0
