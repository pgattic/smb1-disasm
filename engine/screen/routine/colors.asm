
AreaPalette:
	.db $01, $02, $03, $04

GetAreaPalette:
	ldy AreaType		;select appropriate palette to load
	ldx AreaPalette,y	;based on area type
SetVRAMAddr_A:
	stx VRAM_Buffer_AddrCtrl ;store offset into buffer control
NextSubtask:
	jmp IncSubtask	;move onto next task

;-------------------------------------------------------------------------------------
;$00 - used as temp counter in GetPlayerColors

BGColorCtrl_Addr:
	.db $00, $09, $0a, $04

BackgroundColors:
	.db $22, $22, $0f, $0f ;used by area type if bg color ctrl not set
	.db $0f, $22, $0f, $0f ;used by background color control if set

PlayerColors:
	.db $22, $16, $27, $18 ;mario's colors
	.db $22, $30, $27, $19 ;luigi's colors
	.db $22, $37, $27, $16 ;fiery (used by both)

GetBGPlayerColor:
	ldy BackgroundColorCtrl   ;check background color control
	beq NoBGColor		;if not set, increment task and fetch palette
	lda BGColorCtrl_Addr-4,y  ;put appropriate palette into vram
	sta VRAM_Buffer_AddrCtrl  ;note that if set to 5-7, $0301 will not be read
NoBGColor:
	inc ScreenRoutineTask     ;increment to next subtask and plod on through
	
GetPlayerColors:
	ldx VRAM_Buffer1_Offset  ;get current buffer offset
	ldy #$00
	lda CurrentPlayer	;check which player is on the screen
	beq ChkFiery
	ldy #$04		;load offset for luigi
ChkFiery:	lda PlayerStatus	;check player status
	cmp #$02
	bne StartClrGet	;if fiery, load alternate offset for fiery player
	ldy #$08
StartClrGet:
	lda #$03		;do four colors
	sta $00
ClrGetLoop:
	lda PlayerColors,y	;fetch player colors and store them
	sta VRAM_Buffer1+3,x     ;in the buffer
	iny
	inx
	dec $00
	bpl ClrGetLoop
	ldx VRAM_Buffer1_Offset  ;load original offset from before
	ldy BackgroundColorCtrl  ;if this value is four or greater, it will be set
	bne SetBGColor	;therefore use it as offset to background color
	ldy AreaType		;otherwise use area type bits from area offset as offset
SetBGColor:
	lda BackgroundColors,y   ;to background color instead
	sta VRAM_Buffer1+3,x
	lda #$3f		;set for sprite palette address
	sta VRAM_Buffer1,x	;save to buffer
	lda #$10
	sta VRAM_Buffer1+1,x
	lda #$04		;write length byte to buffer
	sta VRAM_Buffer1+2,x
	lda #$00		;now the null terminator
	sta VRAM_Buffer1+7,x
	txa			;move the buffer pointer ahead 7 bytes
	clc			;in case we want to write anything else later
	adc #$07
SetVRAMOffset:
	sta VRAM_Buffer1_Offset  ;store as new vram buffer offset
	rts

;-------------------------------------------------------------------------------------

GetAlternatePalette1:
	lda AreaStyle		;check for mushroom level style
	cmp #$01
	bne NoAltPal
	lda #$0b		;if found, load appropriate palette
SetVRAMAddr_B:
	sta VRAM_Buffer_AddrCtrl
NoAltPal:	jmp IncSubtask	;now onto the next task
