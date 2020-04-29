
	xdef	ValueToDecimalASCII_16b
	
	xref	RegisterDumpAndWait
	xref	MemoryDumpAndWait
	xref	memset

LOCALBUFFERSIZE		EQU		16

CALLERBUFFERPTR		EQU		12
CALLERBUFFERSIZE	EQU		10
CALLERVALUE			EQU		8

	SECTION		CODE
	
	
	;Value to print is in d0 (word)
	;Length of buffer is in d1 (word)
	;Pointer to buffer to store is in a0, has to be size of string + 1 for null termination
ValueToDecimalASCII_16b:
	link		a6,#-LOCALBUFFERSIZE		;Allocate some space for a temporary buffer, max length that a 32-bit value can be
	movem.l		d0-d7/a0-a7,-(sp)

	move.w		#0,-(sp)
	move.l		#LOCALBUFFERSIZE,-(sp)
	move.l		a6,a0
	sub.l		#LOCALBUFFERSIZE,a0
	move.l		a0,-(sp)
	jsr			memset
	add.l		#10,sp


	move.l		CALLERBUFFERPTR(a6),a0
	clr.l		d0
	move.w		CALLERBUFFERSIZE(a6),d0
	lsr.l		#1,d0
	jsr			RegisterDumpAndWait
	jsr			MemoryDumpAndWait
	
	move.w		#0,-(sp)
	clr.l		d0
	move.w		CALLERBUFFERSIZE(a6),d0
	move.l		d0,-(sp)
	move.l		CALLERBUFFERPTR(a6),-(sp)
	jsr			RegisterDumpAndWait
	jsr			memset
	add.l		#10,sp

	move.l		CALLERBUFFERPTR(a6),a0
	clr.l		d0
	move.w		CALLERBUFFERSIZE(a6),d0
	lsr.l		#1,d0
	jsr			RegisterDumpAndWait
	jsr			MemoryDumpAndWait

	jsr			RegisterDumpAndWait
	
Exit:
	movem.l	(sp)+,d0-d7/a0-a7
	unlk	a6
	rts

NotEnoughBuffer:
	subq.w	#1,d1
	lea		ErrorMessage,a2
CopyError:
	move.b	(a2)+,(a0)+
	dbeq	d1,CopyError
	bra		Exit
	
	align 2
ErrorMessage:
	dc.b	'Err',0