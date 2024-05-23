
PlayerInjuryBlink:
	lda TimerControl	;check master timer control
	cmp #$f0		;for specific moment in time
	bcs ExitBlink	;branch if before that point
	cmp #$c8		;check again for another specific point
	beq DonePlayerTask     ;branch if at that point, and not before or after
	jmp PlayerCtrlRoutine  ;otherwise run player control routine
ExitBlink:
	bne ExitBoth	;do unconditional branch to leave

InitChangeSize:
	ldy PlayerChangeSizeFlag  ;if growing/shrinking flag already set
	bne ExitBoth		;then branch to leave
	sty PlayerAnimCtrl	;otherwise initialize player's animation frame control
	inc PlayerChangeSizeFlag  ;set growing/shrinking flag
	lda PlayerSize
	eor #$01			;invert player's size
	sta PlayerSize
ExitBoth:
	rts			;leave
