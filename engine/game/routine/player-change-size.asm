
PlayerChangeSize:
	lda TimerControl    ;check master timer control
	cmp #$f8		;for specific moment in time
	bne EndChgSize	;branch if before or after that point
	jmp InitChangeSize  ;otherwise run code to get growing/shrinking going
EndChgSize:
	cmp #$c4		;check again for another specific moment
	bne ExitChgSize     ;and branch to leave if before or after that point
	jsr DonePlayerTask  ;otherwise do sub to init timer control and set routine
ExitChgSize:
	rts		;and then leave
