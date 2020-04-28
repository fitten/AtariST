	include "GEMDOS_1.asm"

	xdef	NewLine
	xdef	PrintChar
	xdef	PrintString
	xdef	puts
	xdef	putsln
	xdef	putslnw
	xdef	WaitAnyKey
	xdef	PrintLine
	
	
	SECTION CODE

NewLine:
	movem.l	d0,-(sp)			;save register that will be used
	move.b	#$0D,d0				;CR
	jsr		PrintChar			;Print it
	move.b	#$0A,d0				;LF
	jsr		PrintChar			;Print it
	movem.l	(sp)+,d0			;restore register
	rts							;Return
	
PrintChar:
	movem.l d0,-(sp)					;Save registers
	and.l	#$00FF,d0					;Clear off all by the byte
	move.w	d0,-(sp)					;Push character onto the stack
	move.w	#GEMDOS_1_Cconout,-(sp)		;ConOut GemDos trap number
	trap	#GEMDOS_1					;Call GemDos
	addq.l	#4,sp						;Clear up the stack
	movem.l (sp)+,d0					;Restore registers
	rts									;Return

PrintLine:
	jsr		PrintString
	jsr		NewLine
	rts
	
PrintString:
	movem.l	d0/a3,-(sp)			;Save state
PrintString_Loop:
	move.b	(a3)+,d0			;Load a byte
	cmp.b	#$00,d0				;End of string?
	beq		PrintString_done	;At the end of string
	jsr		PrintChar			;print the character
	bra		PrintString_Loop	;print the next character
PrintString_done:
	movem.l	(sp)+,d0/a3			;restore state
	rts							;Return

puts:
	movem.l		d0-d7/a0-a7,-(sp)
	move.l		a0,-(sp)
	move.w		#GEMDOS_1_Cconws,-(sp)
	trap		#GEMDOS_1
	move.w		(sp)+,d0
	move.l		(sp)+,a0
	movem.l		(sp)+,d0-d7/a0-a7
	rts
	
putsln:
	jsr		puts
	jsr		NewLine
	rts
	
putslnw:
	jsr		putsln
	jsr		WaitAnyKey
	rts
	
WaitAnyKey:
	movem.l	d0-d7/a0-a7,-(sp)
	move.w	#GEMDOS_1_Cconin,-(sp)
	trap	#GEMDOS_1
	addq.l	#2,sp
	movem.l	(sp)+,d0-d7/a0-a7
	rts
