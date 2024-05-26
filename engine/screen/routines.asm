
ScreenRoutines:
	lda ScreenRoutineTask	;run one of the following subroutines
	jsr JumpEngine
    
	.dw InitScreen
	.dw SetupIntermediate
	.dw WriteTopStatusLine
	.dw WriteBottomStatusLine
	.dw DisplayTimeUp
	.dw ResetSpritesAndScreenTimer
	.dw DisplayIntermediate
	.dw ResetSpritesAndScreenTimer
	.dw AreaParserTaskControl
	.dw GetAreaPalette
	.dw GetBGPlayerColor
	.dw GetAlternatePalette1
	.dw DrawTitleScreen
	.dw ClearBuffersDrawIcon
	.dw WriteTopScore
