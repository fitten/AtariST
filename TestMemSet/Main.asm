
	xref	ReturnToOS
	xref	puts
	xref	putsln
	xref	putslnw
	xref	memset
	xref	MemoryDumpAndWait
	
BUFFSIZE	EQU	32
	
	SECTION	CODE
Main:
	movem.l		d0-d7/a0-a7,-(sp)
	
	lea			BeginMessage,a0
	jsr			putsln
	
	lea			BetweenMessage,a0
	jsr			putslnw
	
	;Easy case first
	move.w		#$AA,-(sp)
	move.w		#16,-(sp)	
	lea			Chunk1,a0
	move.l		a0,-(sp)
	jsr			memset
	move.l		(sp)+,d0
	move.w		(sp)+,d0
	move.w		(sp)+,d0
	
	jsr			DumpAllData
	
	lea			BetweenMessage,a0
	jsr			putslnw
	
	;Off by 3
	move.w		#$BB,-(sp)
	move.w		#22,-(sp)
	lea			Pad2,a0
	move.l		a0,-(sp)
	jsr			memset
	move.l		(sp)+,d0
	move.w		(sp)+,d0
	move.w		(sp)+,d0
	
	jsr			DumpAllData
	
	
	lea			EndMessage,a0
	jsr			putslnw
	
	movem.l		(sp)+,d0-d7/a0-a7
	jmp			ReturnToOS


DumpAllData:
	movem.l		d0-d7/a0-a7,-(sp)
	
	lea			PrePad,a0
	move.l		#8,d0
	jsr			MemoryDumpAndWait
	lea			Pad1,a0
	move.l		#2,d0
	jsr			MemoryDumpAndWait
	lea			Chunk1,a0
	move.l		#8,d0
	jsr			MemoryDumpAndWait
	lea			Pad5,a0
	move.l		#2,d0
	jsr			MemoryDumpAndWait
	lea			PostPad,a0
	move.l		#8,d0
	jsr			MemoryDumpAndWait
	
	movem.l		(sp)+,d0-d7/a0-a7
	rts

	SECTION	DATA
	align	4
BeginMessage:	dc.b	'Starting...',0
EndMessage:		dc.b	'Done.',0
BetweenMessage:	dc.b	'Test starting', 0

	align	4
PrePad:		dc.l	0,0,0,0
Pad1:		dc.b	0
Pad2:		dc.b	0
Pad3:		dc.b	0
Pad4:		dc.b	0
Chunk1:		dc.l	0,0,0,0
Pad5:		dc.b	0
Pad6:		dc.b	0
Pad7:		dc.b	0
Pad8:		dc.b	0
PostPad:	dc.l	0,0,0,0