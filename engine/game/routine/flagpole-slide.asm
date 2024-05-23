
FlagpoleSlide:
	lda Enemy_ID+5	;check special use enemy slot
	cmp #FlagpoleFlagObject  ;for flagpole flag object
	bne NoFPObj		;if not found, branch to something residual
	lda FlagpoleSoundQueue   ;load flagpole sound
	sta Square1SoundQueue    ;into square 1's sfx queue
	lda #$00
	sta FlagpoleSoundQueue   ;init flagpole sound queue
	ldy Player_Y_Position
	cpy #$9e		;check to see if player has slid down
	bcs SlidePlayer	;far enough, and if so, branch with no controller bits set
	lda #$04		;otherwise force player to climb down (to slide)
SlidePlayer:
	jmp AutoControlPlayer    ;jump to player control routine
NoFPObj:
	inc GameEngineSubroutine ;increment to next routine (this may
	rts			;be residual code)
