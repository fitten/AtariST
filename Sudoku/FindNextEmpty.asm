	xdef	Sudoku_Solver_FindNextEmpty

	xref	SudokuSolver_PuzzleRowLength

	SECTION CODE

COLINDEX	EQU	8
ROWINDEX	EQU	10
PUZZLEPOS	EQU	12

Sudoku_Solver_FindNextEmpty:
	link		a6,#0							;save a frame
	movem.l		d1-d7/a0-a7,-(sp)				;save state	

	move.w		COLINDEX(a6),d1					;Get current column index
	move.w		ROWINDEX(a6),d2					;Get current row index
	move.l		PUZZLEPOS(a6),a0				;Get current location
	
	move.w		SudokuSolver_PuzzleRowLength,d3	;Row length
Loop:
	move.w		(a0),d7							;get the value
	cmp.w		#0,d7							;is it empty?
	beq			ReturnSuccess					;if so, this is the spot
	addq.l		#2,a0							;increment pointer
	addq.w		#1,d1							;increment column index
	cmp.w		d3,d1							;are we at the end of a row?
	bne			Loop							;no, go back to next
	clr.w		d1								;Yep, set column index to zero
	addq.w		#1,d2							;increment row index
	cmp.w		d3,d2							;are we at the end of the puzzle?
	beq			ReturnFailure
	bra			Loop
	
ReturnSuccess:
	clr.w		d0								;return successful
	move.l		a0,PUZZLEPOS(a6)
	move.w		d2,ROWINDEX(a6)
	move.w		d1,COLINDEX(a6)
	bra			Exit
ReturnFailure:
	moveq		#-1,d0
Exit:
	movem.l		(sp)+,d1-d7/a0-a7				;restore state
	unlk		a6
	rts