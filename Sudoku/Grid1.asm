	include "Global_Inc.asm"

	xdef	Grid1
	xdef	Grid1RowLength
	xdef	Grid1RootSize

	SECTION	DATA
	align 2
Grid1:
	dc.w	0,0,3,0,2,0,6,0,0
	dc.w	9,0,0,3,0,5,0,0,1
	dc.w	0,0,1,8,0,6,4,0,0
	dc.w	0,0,8,1,0,2,9,0,0
	dc.w	7,0,0,0,0,0,0,0,8
	dc.w	0,0,6,7,0,8,2,0,0
	dc.w	0,0,2,6,0,9,5,0,0
	dc.w	8,0,0,2,0,3,0,0,9
	dc.w	0,0,5,0,1,0,3,0,0

	align 2
Grid1RowLength:	dc.w	9
Grid1RootSize:	dc.w	3