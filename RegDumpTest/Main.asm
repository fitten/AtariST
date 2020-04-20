	xref	PrintString
	xref	NewLine
	xref	WaitAnyKey
	xref	ReturnToOS

	SECTION	TEXT

RegDumpTestMain:
	lea		Message,a3
	jsr		PrintString
	jsr		NewLine
	jsr		WaitAnyKey
	move.l	#$00000000,d0
	move.l	#$11111111,d1
	move.l	#$22222222,d2
	move.l	#$33333333,d3
	move.l	#$44444444,d4
	move.l	#$55555555,d5
	move.l	#$66666666,d6
	move.l	#$77777777,d7
	
	move.l	#$88888888,a0
	move.l	#$99999999,a1
	move.l	#$AAAAAAAA,a2
	move.l	#$BBBBBBBB,a3
	move.l	#$CCCCCCCC,a4
	move.l	#$DDDDDDDD,a5
	move.l	#$EEEEEEEE,a6
	
	jsr		RegisterDump
	jsr		NewLine
	jsr		NewLine
	lea		Message,a3
	jsr		PrintString
	jsr		NewLine
	jsr		WaitAnyKey
	jmp		ReturnToOS
	
data1:
	dc.l	$1a2b3c4d
	even
data2:
	dc.l	$f7e6d5c4
	even

Message:	dc.b	'Hello World, Shane!', 0
	even
	
