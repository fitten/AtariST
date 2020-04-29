
	xdef	memset
	
	xdef	RegisterDumpAndWait

BUFFERPTR				EQU		8
BUFFERSIZE				EQU		12
BUFFERVALUE				EQU		16

	SECTION	CODE
memset:
	link		a6,#0				;Make our own stack frame
	movem.l		d0-d7/a0-a7,-(sp)
	
	move.w		BUFFERVALUE(a6),d0	;Load the word into d0, but remember it's a byte value
	move.w		d0,d1				;Make a copy
	rol.w		#8,d1				;Move it over
	move.b		d0,d1				;Now we have the value twice
	move.w		d1,d0				;Copy it over
	swap		d0					;Swamp lo/hi
	move.w		d1,d0				;Now we have the value four times in the 32-bit
	
	
	move.l		BUFFERSIZE(a6),d1	;The buffer size (long)
	move.l		BUFFERPTR(a6),a0	;Check buffer alignment
	move		a0,d2				;Make a copy
	
	and.w		#3,d2				;Mask it off to check alignment
	cmp.w		#0,d2				;Aligned to 32-bit?
	beq			PtrAligned32		;If so, go straight to the fast copy
	
	lea			PtrAligned32,a4		;Ok, it's not aligned so let's hack this... push a return address onto the stack
	move.l		a4,-(sp)			;Push a return address onto the stack
	cmp.w		#3,d2				;Is it off by 3?
	beq			PtrOff3
	cmp.w		#2,d2				;Is it off by 2?
	beq			PtrOff2
	cmp.w		#1,d2				;Is it off by 1?
	beq			PtrOff1
	move		(sp)+,a4			;Correct the stack if we get to here

PtrAligned32:
	;The pointer should be 32-bit aligned at this point
	move.l		d1,d2				;Make a copy of the current counter
	lsr.l		#2,d2				;This will be the number of 32-bit values
	subq.l		#1,d2				;dbeq will also do one for the zero, so reduce the counter by 1
		
Loop32:
	move.l		d0,(a0)+			;Move 32-bit value to memory
	dbeq		d2,Loop32			;Not done, loop
	
	;Do we have any bytes to clean up?
	and.l		#3,d1				;How many bytes left over?
	cmp.w		#0,d1				;None? we're done
	beq			Exit
	
	lea			Exit,a4				;OK, there are some left over so let's hack this... push a return address onto the stack
	move.l		a4,-(sp)
	cmp.w		#3,d1				;3 bytes
	beq			PtrOff3
	cmp.w		#2,d1				;2 bytes
	beq			PtrOff2
	cmp.w		#1,d1				;1 byte
	beq			PtrOff1
	move		(sp)+,a4			;Correct the stack if we get this far

	
Exit:
	movem.l	(sp)+,d0-d7/a0-a7
	unlk	a6
	rts


PtrOff3:
	move.b		d0,(a0)+
	subq.l		#1,d1
PtrOff2:
	move.b		d0,(a0)+
	subq.l		#1,d1
PtrOff1:
	move.b		d0,(a0)+
	subq.l		#1,d1
	rts

	


