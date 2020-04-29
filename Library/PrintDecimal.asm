
	xdef	PrintDecimal_16b

	SECTION		CODE
	
	
	;Value to print is in d0 (word)
	;Length of buffer is in d1 (word)
	;Pointer to buffer to store is in a0, has to be size of string + 1 for null termination
PrintDecimal_16b:
	link	a6,#10					;Allocate some space for a temporary buffer, max length that a 32-bit value can be
	movem.l	d0-d7/a0-a7,-(sp)
	move.l	a6,a5					;a5 will be our temporary buffer
	
	swap	d0						;Exchange upper and lower word
	clr.w	d0						;Clear lower word
	swap	d0						;Swap it back (this makes sure that the value is 16 bit
	
	clr.w	d2						;Index to make sure we don't overrun buffer
	
	move.w	d1,d3
	addq	#-1,d3
	move.b	#0,d3(a0)				;Null terminate the end of the buffer for safety
	move.b	#0,-(a5)				;Null terminate our number string (put it on our mini-stack first)

NextDigit:
	divs.w	#10,d0					;Divide the number by 10 (will also get the remainder)
	swap	d0						;Swap so the remainder is in the low word, since we know that this will be less than a byte in size, we can do things
	addq.b	#'0',d0					;Make it an ASCII numeric character
	move.b	d0,-(a5)				;Push it into our little storage space
	swap	d0						;Get back the quotient
	cmp.w	#0,d0					;Is it zero yet?
	bne		NextDigit				;If not, get the next digit
	
	move.l	a5,d4					;Copy the pointer to d4
	move.l	a6,d5					;Copy the stack frame to d6
	sub.l	d4,d5					;This will be how many characters were generated
	cmp.w	d5,d1					;Compare to how many bytes we have in the buffer
	bgt		NotEnoughBuffer			;If not enough, go to error handling
	
	
DoCopy:
	move.b	(a5)+,(a0)+
	dbeq	d5,DoCopy	
	
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
	dc.b	'BuffErr',0