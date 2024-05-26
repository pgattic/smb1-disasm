
Vine_AutoClimb:
	lda Player_Y_HighPos   ;check to see whether player reached position
	bne AutoClimb	;above the status bar yet and if so, set modes
	lda Player_Y_Position
	cmp #$e4
	bcc SetEntr
AutoClimb:
	lda #%00001000	;set controller bits override to up
	sta JoypadOverride
	ldy #$03		;set player state to climbing
	sty Player_State
	jmp AutoControlPlayer
SetEntr:
	lda #$02		;set starting position to override
	sta AltEntranceControl
	jmp ChgAreaMode	;set modes
