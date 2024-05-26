;$00 - vram buffer address table low
;$01 - vram buffer address table high

DrawTitleScreen:
	lda OperMode		;are we in title screen mode?
	bne IncModeTask_B		;if not, exit
	lda #>TitleScreenDataOffset  ;load address $1ec0 into
	sta PPU_ADDRESS		;the vram address register
	lda #<TitleScreenDataOffset
	sta PPU_ADDRESS
	lda #$03			;put address $0300 into
	sta $01			;the indirect at $00
	ldy #$00
	sty $00
	lda PPU_DATA		;do one garbage read
OutputTScr:
	lda PPU_DATA		;get title screen from chr-rom
	sta ($00),y			;store 256 bytes into buffer
	iny
	bne ChkHiByte		;if not past 256 bytes, do not increment
	inc $01			;otherwise increment high byte of indirect
ChkHiByte:
	lda $01			;check high byte?
	cmp #$04			;at $0400?
	bne OutputTScr		;if not, loop back and do another
	cpy #$3a			;check if offset points past end of data
	bcc OutputTScr		;if not, loop back and do another
	lda #$05			;set buffer transfer control to $0300,
	jmp SetVRAMAddr_B		;increment task and exit
