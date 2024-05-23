
OperModeExecutionTree:
	lda OperMode     ;this is the heart of the entire program,
	jsr JumpEngine   ;most of what goes on starts here

	.dw TitleScreenMode
	.dw GameMode
	.dw VictoryMode
	.dw GameOverMode
