
VerticalPipeEntry:
	lda #$01		;set 1 as movement amount
	jsr MovePlayerYAxis  ;do sub to move player downwards
	jsr ScrollHandler    ;do sub to scroll screen with saved force if necessary
	ldy #$00		;load default mode of entry
	lda WarpZoneControl  ;check warp zone control variable/flag
	bne ChgAreaPipe	;if set, branch to use mode 0
	iny
	lda AreaType	;check for castle level type
	cmp #$03
	bne ChgAreaPipe	;if not castle type level, use mode 1
	iny
	jmp ChgAreaPipe	;otherwise use mode 2

MovePlayerYAxis:
	clc
	adc Player_Y_Position ;add contents of A to player position
	sta Player_Y_Position
	rts
