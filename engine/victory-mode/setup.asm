
SetupVictoryMode:
	ldx ScreenRight_PageLoc  ;get page location of right side of screen
	inx			;increment to next page
	stx DestinationPageLoc   ;store here
	lda #EndOfCastleMusic
	sta EventMusicQueue	;play win castle music
	jmp IncModeTask_B	;jump to set next major task in victory mode
