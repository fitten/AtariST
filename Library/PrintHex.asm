	xdef	HexDump8
	xdef	HexDump16
	xdef	HexDump32
	xdef	PrintHexChar
	xdef	ConvertHexNibbleToAscii
	
	xref	PrintChar

	SECTION	CODE

HexDump8:
	movem.l		d0,-(sp)
	ror.b		#4,d0
	jsr			PrintHexChar
	ror.b		#4,d0
	jsr			PrintHexChar
	movem.l		(sp)+,d0
	rts
	
HexDump16:
	movem.l		d0,-(sp)
	ror.w		#8,d0
	ror.b		#4,d0
	jsr			PrintHexChar
	ror.b		#4,d0
	jsr			PrintHexChar
	ror.w		#8,d0
	ror.b		#4,d0
	jsr			PrintHexChar	
	ror.b		#4,d0
	jsr			PrintHexChar
	movem.l		(sp)+,d0
	rts

HexDump32:
	movem.l		d0,-(sp)
	swap		d0
	jsr			HexDump16
	swap		d0
	jsr			HexDump16
	movem.l		(sp)+,d0
	rts

PrintHexChar:
	movem.l		d0,-(sp)
	jsr			ConvertHexNibbleToAscii
	jsr			PrintChar
	movem.l		(sp)+,d0
	rts

ConvertHexNibbleToAscii:
	and.w		#$000f,d0
	cmp.b		#9,d0
	ble			CharLessThan10
	add.b		#'A'-10,d0
	rts
CharLessThan10:
	add.b		#'0',d0
	rts
