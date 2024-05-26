
PlayerEndWorld:
	lda WorldEndTimer	;check to see if world end timer expired
	bne EndExitOne		;branch to leave if not
	ldy WorldNumber		;check world number
	cpy #World8		;if on world 8, player is done with game, 
	bcs EndChkBButton	;thus branch to read controller
	lda #$00
	sta AreaNumber		;otherwise initialize area number used as offset
	sta LevelNumber		;and level number control to start at area 1
	sta OperMode_Task	;initialize secondary mode of operation
	inc WorldNumber		;increment world number to move onto the next world
	jsr LoadAreaPointer	;get area address offset for the next area
	inc FetchNewGameTimerFlag  ;set flag to load game timer from header
	lda #GameModeValue
	sta OperMode		;set mode of operation to game mode
EndExitOne:
	rts				;and leave
EndChkBButton:
	lda SavedJoypad1Bits
	ora SavedJoypad2Bits	;check to see if B button was pressed on
	and #B_Button		;either controller
	beq EndExitTwo		;branch to leave if not
	lda #$01			;otherwise set world selection flag
	sta WorldSelectEnableFlag
	lda #$ff			;remove onscreen player's lives
	sta NumberofLives
	jsr TerminateGame	;do sub to continue other player or end game
EndExitTwo:
	rts				;leave
