
GameRoutines:
	lda GameEngineSubroutine  ;run routine based on number (a few of these routines are   
	jsr JumpEngine		;merely placeholders as conditions for other routines)

	.dw Entrance_GameTimerSetup
	.dw Vine_AutoClimb
	.dw SideExitPipeEntry
	.dw VerticalPipeEntry
	.dw FlagpoleSlide
	.dw PlayerEndLevel
	.dw PlayerLoseLife
	.dw PlayerEntrance
	.dw PlayerCtrlRoutine
	.dw PlayerChangeSize
	.dw PlayerInjuryBlink
	.dw PlayerDeath
	.dw PlayerFireFlower
