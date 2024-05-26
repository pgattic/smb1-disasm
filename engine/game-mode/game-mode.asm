
;indirect jump routine called when
;$0770 is set to 1
GameMode:
	lda OperMode_Task
	jsr JumpEngine

	.dw InitializeArea
	.dw ScreenRoutines
	.dw SecondaryGameSetup
	.dw GameCoreRoutine
