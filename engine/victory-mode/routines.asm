
VictoryModeSubroutines:
	lda OperMode_Task
	jsr JumpEngine

	.dw BridgeCollapse
	.dw SetupVictoryMode
	.dw PlayerVictoryWalk
	.dw PrintVictoryMessages
	.dw PlayerEndWorld
