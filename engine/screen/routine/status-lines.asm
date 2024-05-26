
WriteTopStatusLine:
	lda #$00	;select main status bar
	jsr WriteGameText ;output it
	jmp IncSubtask    ;onto the next task

;-------------------------------------------------------------------------------------

WriteBottomStatusLine:
	jsr GetSBNybbles	;write player's score and coin tally to screen
	ldx VRAM_Buffer1_Offset
	lda #$20		;write address for world-area number on screen
	sta VRAM_Buffer1,x
	lda #$73
	sta VRAM_Buffer1+1,x
	lda #$03		;write length for it
	sta VRAM_Buffer1+2,x
	ldy WorldNumber	;first the world number
	iny
	tya
	sta VRAM_Buffer1+3,x
	lda #$28		;next the dash
	sta VRAM_Buffer1+4,x
	ldy LevelNumber	;next the level number
	iny			;increment for proper number display
	tya
	sta VRAM_Buffer1+5,x    
	lda #$00		;put null terminator on
	sta VRAM_Buffer1+6,x
	txa			;move the buffer offset up by 6 bytes
	clc
	adc #$06
	sta VRAM_Buffer1_Offset
	jmp IncSubtask
