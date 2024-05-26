
VictoryMode:
	jsr VictoryModeSubroutines  ;run victory mode subroutines
	lda OperMode_Task	;get current task of victory mode
	beq AutoPlayer		;if on bridge collapse, skip enemy processing
	ldx #$00
	stx ObjectOffset		;otherwise reset enemy object offset 
	jsr EnemiesAndLoopsCore     ;and run enemy code
AutoPlayer:
	jsr RelativePlayerPosition  ;get player's relative coordinates
	jmp PlayerGfxHandler	;draw the player, then leave
