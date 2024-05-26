
PlayerVictoryWalk:
	ldy #$00		;set value here to not walk player by default
	sty VictoryWalkControl
	lda Player_PageLoc	;get player's page location
	cmp DestinationPageLoc  ;compare with destination page location
	bne PerformWalk	;if page locations don't match, branch
	lda Player_X_Position   ;otherwise get player's horizontal position
	cmp #$60		;compare with preset horizontal position
	bcs DontWalk		;if still on other page, branch ahead
PerformWalk:
	inc VictoryWalkControl  ;otherwise increment value and Y
	iny			;note Y will be used to walk the player
DontWalk:
	tya			;put contents of Y in A and
	jsr AutoControlPlayer   ;use A to move player to the right or not
	lda ScreenLeft_PageLoc  ;check page location of left side of screen
	cmp DestinationPageLoc  ;against set value here
	beq ExitVWalk	;branch if equal to change modes if necessary
	lda ScrollFractional
	clc			;do fixed point math on fractional part of scroll
	adc #$80	
	sta ScrollFractional    ;save fractional movement amount
	lda #$01		;set 1 pixel per frame
	adc #$00		;add carry from previous addition
	tay			;use as scroll amount
	jsr ScrollScreen	;do sub to scroll the screen
	jsr UpdScrollVar	;do another sub to update screen and scroll variables
	inc VictoryWalkControl  ;increment value to stay in this routine
ExitVWalk:
	lda VictoryWalkControl  ;load value set here
	beq IncModeTask_A	;if zero, branch to change modes
	rts			;otherwise leave
