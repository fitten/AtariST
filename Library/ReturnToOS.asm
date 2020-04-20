	include "GEMDOS_1.asm"

	xdef	ReturnToOS

	SECTION	CODE

ReturnToOS:
	clr.w	-(sp)	;Return to OS
	trap	#GEMDOS_1