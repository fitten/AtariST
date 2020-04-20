	xdef	RegisterDump	
	xdef	RegisterDumpAndWait
	
	xref	PrintString
	xref	WaitAnyKey
	
	SECTION CODE

	
RegisterDump:
	movem.l		d0-d7/a0-a7,-(sp)
	jsr			NewLine
	move.l		sp,a5
	move.w		#'0',d7
	jsr			RegisterDumpNextRegisters
	jsr			RegisterDumpNextRegisters
	jsr			RegisterDumpNextRegisters
	jsr			RegisterDumpNextRegisters
	jsr			RegisterDumpNextRegisters
	jsr			RegisterDumpNextRegisters
	jsr			RegisterDumpNextRegisters
	jsr			RegisterDumpNextRegisters
	movem.l		(sp)+,d0-d7/a0-a7
	rts
	
RegisterDumpAndWait:
	movem.l	d0-d7/a0-a7,-(sp)
	jsr		RegisterDump
	jsr		WaitAnyKey
	movem.l	(sp)+,d0-d7/a0-a7
	rts
	
RegisterDumpNextRegisters:
	move.l		(a5),d0
	move.l		32(a5),d1
	movem.l		d0-d1,-(sp)
	jsr			RegisterDumpOneLine
	movem.l		(sp)+,d0-d1
	addq.l		#4,a5
	addq.l		#1,d7
	rts

RegisterDumpOneLine:
	lea			RegisterLabel,a3
	move.b		#'D',(a3)
	move.b		d7,1(a3)
	jsr			PrintString
	move.l		4(sp),d0
	jsr			HexDump32
	lea			RegisterLabelSpacer,a3
	jsr			PrintString
	lea			RegisterLabel,a3
	move.b		#'A',(a3)
	move.b		d7,1(a3)
	jsr			PrintString
	move.l		8(sp),d0
	jsr			HexDump32
	jsr			NewLine	
	rts
	
	
RegisterLabel:			dc.b	'  :',0
RegisterLabelSpacer		dc.b	'    ',0
	even
