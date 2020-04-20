	xdef	Sudoku_Solver
		
	xref	MemoryDumpAndWait
	xref	MemoryDump
	xref	RegisterDump
	xref	RegisterDumpAndWait
	xref	Sudoku_Solver_FindNextEmpty
	xref	PrintPuzzleGlobals
	xref	SudokuSolver_PuzzleBasePointer
	xref	SudokuSolver_PuzzleRowLength
	xref	SudokuSolver_PuzzleRowSqrt

COLINDEX	EQU	8
ROWINDEX	EQU	10
PUZZLEPOS	EQU	12

	SECTION	CODE

	;Stack on entry:
	;	Base address of puzzle
	;	Address of location of interest
	;	Row Index
	;	Column Index
	;	Row Length
Sudoku_Solver:
	link		a6,#0
	movem.l		d1-d7/a0-a7,-(sp)		;Save
	move.l		PUZZLEPOS(a6),a1
	move.w		ROWINDEX(a6),d7
	move.w		COLINDEX(a6),d6
	moveq		#1,d1					;candidate value

Loop:
	move.w		#$10,(a1)			;Just put something in the puzzle so i can see it
	jsr			PrintPuzzleGlobals
	move.l		a1,-(sp)			;Store variables for next call to self
	move.w		d7,-(sp)			;Store variables for next call to self
	move.w		d6,-(sp)			;Store variables for next call to self
	
	jsr			Sudoku_Solver_FindNextEmpty
	cmp.w		#-1,d0				;Couldn't find an empty spot
	beq			CleanAndExit
	jsr			Sudoku_Solver
	
CleanAndExit:
	move.w		(sp)+,d6			;Clear the stack from the call
	move.w		(sp)+,d7			;Clear the stack from the call
	move.l		(sp)+,a1			;Clear the stack from the call

Exit:
	movem.l		(sp)+,d1-d7/a0-a7		;Restore
	unlk		a6
	rts
	
	
	
	
	;Test value in d1, column index d6, row index d7
	;Return value in d0
Sudoku_Solver_TestRow:
	link		a6,#0
	movem.l		d2-d7/a0-a7,-(sp)		;Save
	clr.l		d2									;set whole register to 0 for upcoming add to address
	move.w		(SudokuSolver_PuzzleRowLength),d2	;rowlength
	move.w		d2,d3								;will need a copy of this for later
	lsl.w		#1,d2								;how many bytes are in a row
	mulu		d7,d2								;multiply bytes in a row by how many rows
	move.l		(SudokuSolver_PuzzleBasePointer),a0	;load the base address of the puzzle
	add.l		d2,a0								;add the row start to base
RowTest:
	move.w		(a0),d4								;Load the value at this location
	cmp.w		d0,d4								;Is this location the same value as the test value?
	beq			NotAllowedOnRow						;If they are the same, it's not allowed
	addq		#2,a0								;They aren't the same so increment pointer
	dbeq		d4,RowTest							;Are we at the end of the row? if not, test the next location
	clr.l		d0									;Return success
	bra			RowTestCleanAndExit
NotAllowedOnRow:
	moveq		#-1,d0
RowTestCleanAndExit:
	movem.l		(sp)+,d2-d7/a0-a7		;Restore
	unlk		a6
	rts
	
	;Test value in d1, column index d6, row index d7
	;Return value in d0
Sudoku_Solver_TestColumn:
	link		a6,#0
	movem.l		d2-d7/a0-a7,-(sp)		;Save
	move.w		#0,d0
	movem.l		(sp)+,d2-d7/a0-a7		;Restore
	unlk		a6
	rts

	;Test value in d1, column index d6, row index d7
	;Return value in d0
Sudoku_Solver_TestSubBlock:
	link		a6,#0
	movem.l		d2-d7/a0-a7,-(sp)		;Save
	move.w		#0,d0
	movem.l		(sp)+,d2-d7/a0-a7		;Restore
	unlk		a6
	rts
	
