	include "Global_Inc.asm"

	xdef	PrintPuzzle
	
	xref	PrintChar
	xref	NewLine
	xref	puts
	xref	putsln
	xref	putslnw

	

SPACE		EQU		' '
ZEROASCII	EQU		'0'

	SECTION	CODE

;Pass address of puzzle in a3 (long), row size in d7 (word), and row sqrt in d6 (word)
PrintPuzzle:
	movem.l	d0-d7/a0-a7,-(sp)			;Save regs
	move.l	a3,a1						;Scratch value
	clr.w	d1							;Column index
	clr.w	d2							;Coloumn counter for spacer
	clr.w	d3							;Row index
	clr.w	d4							;Row counter for spacer
	
	;Count for the characters in the vertical spacer
	move.w	d6,d5
	subq.w	#2,d5
	add.w	d7,d5
	
	;Load the base pointer to the line buffer
	lea		Buffer,a0
	
StartNextRow:
	clr.w	d1							;Column index
	clr.w	d2							;Horizontal spacer counter
	lea		Buffer,a2					;where to put the next character

DoTheNextColumn:
	move.w	(a1)+,d0					;Load value to print
	add.w	#ZEROASCII,d0				;make it ASCII
	and.w	#$00FF,d0					;Clear it off
	move.b	d0,(a2)+					;Put the char in the buffer
	;move.b	#SPACE,(a2)+				;Put a space in the buffer
	addq.w	#1,d1						;Increment column index
	addq.w	#1,d2						;Increment column counter for horizontal spacer
	cmp.w	d7,d1						;Are we at the end of a row?
	beq		HandleEndOfRow				;If so, do end of row things
	cmp.w	d6,d4						;Are we at the point where we need a line of vertical spacers?
	beq		PrintVerticalSpacers		;If so, do it
	cmp.w	d6,d2						;Are we at the point where we need a horizonal spacer?
	beq		AddHorizontalSpacer			;If so, go add one to the buffer
	bra		DoTheNextColumn

HandleEndOfRow:
	jsr		TerminateBuffer
	jsr		puts						;Print the buffer
	addq.w	#1,d3						;Increment row index
	addq.w	#1,d4						;Increment vertical spacer counter
	cmp.w	d7,d3						;Are we at the end of the puzzle?
	beq		Exit
	bra		StartNextRow				;Start the next row

TerminateBuffer:
	move.b	#CR,(a2)+					;CR
	move.b	#LF,(a2)+					;LF
	move.b	#NULL,(a2)					;null terminate the buffer
	rts

Exit:
	movem.l	(sp)+,d0-d7/a0-a7			;Restore regs
	rts									;Return
	
HorizontalSpacer	EQU		'|'
AddHorizontalSpacer:
	move.b		#HorizontalSpacer,(a2)+	;horizontal spacer
	;move.b		#Space,(a2)+			;space
	clr.w		d2						;Reset horizontal count for spacer
	jmp			DoTheNextColumn

	
VerticalSpacer		EQU		'-'
PrintVerticalSpacers:
	lea		Buffer,a2
	move.w	d5,d0
PVS:
	move.b	#VerticalSpacer,(a2)+
	dbeq	d0,PVS
	jsr		TerminateBuffer
	jsr		puts
	clr.w	d4							;Reset vertical spacer count
	jmp		StartNextRow
	
	
	SECTION	DATA
	align 1
Buffer:		dcb.b		64,0
	align 1
Here:		dc.b		'Here!',0