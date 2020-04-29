	xref	HexDump32
	xref	HexDump16
	xref	NewLine
	xref	PrintChar
	xref	WaitAnyKey

	xdef	MemoryDump
	xdef	MemoryDumpAndWait

	SECTION	CODE
	
	;A0 is memory location
	;D0	is number of words (long)
MemoryDump:
	movem.l	d0-d7/a0-a7,-(sp)

	move.l	a0,d1
	andi.l	#-2,d1		;even word boundary
	move.l	d1,a1
	move.l	d0,d1
	subq.l	#1,d1		;Remember dbeq will do for 0 as well

	jsr		NewLine
Loop:
	move.l	a1,d0
	jsr		HexDump32
	move.w	#':',d0
	jsr		PrintChar
	move.w	#' ',d0
	jsr		PrintChar
	move.w	(a1)+,d0
	jsr		HexDump16
	jsr		NewLine
	dbeq	d1,LOOP
	jsr		NewLine
	movem.l	(sp)+,d0-d7/a0-a7
	rts
	
MemoryDumpAndWait:
	jsr		MemoryDump
	jsr		WaitAnyKey
	rts