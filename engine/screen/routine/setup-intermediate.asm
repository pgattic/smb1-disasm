
SetupIntermediate:
	lda BackgroundColorCtrl  ;save current background color control
	pha			;and player status to stack
	lda PlayerStatus
	pha
	lda #$00		;set background color to black
	sta PlayerStatus	;and player status to not fiery
	lda #$02		;this is the ONLY time background color control
	sta BackgroundColorCtrl  ;is set to less than 4
	jsr GetPlayerColors
	pla			;we only execute this routine for
	sta PlayerStatus	;the intermediate lives display
	pla			;and once we're done, we return bg
	sta BackgroundColorCtrl  ;color ctrl and player status from stack
	jmp IncSubtask	;then move onto the next task
