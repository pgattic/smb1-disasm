;$00 - used in CyclePlayerPalette to store current palette to cycle

PlayerDeath:
	lda TimerControl	;check master timer control
	cmp #$f0		;for specific moment in time
	bcs ExitDeath	;branch to leave if before that point
	jmp PlayerCtrlRoutine  ;otherwise run player control routine

DonePlayerTask:
	lda #$00
	sta TimerControl	;initialize master timer control to continue timers
	lda #$08
	sta GameEngineSubroutine  ;set player control routine to run next frame
	rts			;leave
