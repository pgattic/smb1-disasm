
SideExitPipeEntry:
	jsr EnterSidePipe	;execute sub to move player to the right
	ldy #$02
ChgAreaPipe:
	dec ChangeAreaTimer	;decrement timer for change of area
	bne ExitCAPipe
	sty AltEntranceControl    ;when timer expires set mode of alternate entry
ChgAreaMode:
	inc DisableScreenFlag     ;set flag to disable screen output
	lda #$00
	sta OperMode_Task	;set secondary mode of operation
	sta Sprite0HitDetectFlag  ;disable sprite 0 check
ExitCAPipe:
	rts			;leave

EnterSidePipe:
	lda #$08		;set player's horizontal speed
	sta Player_X_Speed
	ldy #$01		;set controller right button by default
	lda Player_X_Position  ;mask out higher nybble of player's
	and #%00001111	;horizontal position
	bne RightPipe
	sta Player_X_Speed     ;if lower nybble = 0, set as horizontal speed
	tay			;and nullify controller bit override here
RightPipe:
	tya			;use contents of Y to
	jsr AutoControlPlayer  ;execute player control routine with ctrl bits nulled
	rts
