	include "Global_Inc.asm"

	xref	Sudoku_Solver
	xref	SudokuSolver_PuzzleRowLength
	xref	SudokuSolver_PuzzleRowSqrt
	xref	SudokuSolver_PuzzleBasePointer
	xref	NewLine
	xref	WaitAnyKey
	xref	PrintPuzzle
	
	xdef	SolveSudoku
	xdef	PrintPuzzleGlobals

	SECTION	CODE
	
	;Address of the puzzle in a3, row length in d7 (word)
SolveSudoku:
	link		a6,#0
	movem.l		d1-d7/a0-a7,-(sp)		;Save
	
	;Store some globals
	move.l		a3,SudokuSolver_PuzzleBasePointer
	move.w		d7,SudokuSolver_PuzzleRowLength
	move.w		d6,SudokuSolver_PuzzleRowSqrt
	
	move.l		a3,-(sp)				;current pointer is the base
	clr.w		-(sp)					;current row index (0)
	clr.w		-(sp)					;current column index (0)

	jsr			Sudoku_Solver_FindNextEmpty
	cmp.w		#SUCCESS,d0				;Found an empty spot?
	bne			SetErrorAndReturn		;No, set error, clean up, and exit
	jsr			Sudoku_Solver			;Let's solve this puzzle! We keep the same stack as returned by the call

CleanAndReturn:
	move.w		(sp)+,d6				;Current column
	move.w		(sp)+,d7				;Current row
	move.l		(sp)+,a3				;Current position
	
	movem.l		(sp)+,d1-d7/a0-a7		;Restore
	unlk		a6
	rts									;Return

SetErrorAndReturn:
	move.w		#FAILURE,d0
	bra			CleanAndReturn

PrintPuzzleGlobals:
	movem.l	d0-d7/a0-a7,-(sp)
	move.l	(SudokuSolver_PuzzleBasePointer),a3
	move.w	(SudokuSolver_PuzzleRowLength),d7
	move.w	(SudokuSolver_PuzzleRowSqrt),d6
	jsr		PrintPuzzle
	jsr		NewLine
	jsr		WaitAnyKey
	movem.l	(sp)+,d0-d7/a0-a7
	rts
	
	SECTION	DATA
ColumnString:	dc.b	'Column Index:',0
RowString:		dc.b	'Row Index   :',0