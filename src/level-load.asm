LoadAreaPointer:
	jsr FindAreaPointer  ;find it and store it here
	sta AreaPointer
GetAreaType:
	and #%01100000	;mask out all but d6 and d5
	asl
	rol
	rol
	rol			;make %0xx00000 into %000000xx
	sta AreaType	;save 2 MSB as area type
	rts

FindAreaPointer:
	ldy WorldNumber	;load offset from world variable
	lda WorldAddrOffsets,y
	clc			;add area number used to find data
	adc AreaNumber
	tay
	lda AreaAddrOffsets,y  ;from there we have our area pointer
	rts


GetAreaDataAddrs:
	lda AreaPointer	;use 2 MSB for Y
	jsr GetAreaType
	tay
	lda AreaPointer	;mask out all but 5 LSB
	and #%00011111
	sta AreaAddrsLOffset     ;save as low offset
	lda EnemyAddrHOffsets,y  ;load base value with 2 altered MSB,
	clc			;then add base value to 5 LSB, result
	adc AreaAddrsLOffset     ;becomes offset for level data
	tay
	lda EnemyDataAddrLow,y   ;use offset to load pointer
	sta EnemyDataLow
	lda EnemyDataAddrHigh,y
	sta EnemyDataHigh
	ldy AreaType		;use area type as offset
	lda AreaDataHOffsets,y   ;do the same thing but with different base value
	clc
	adc AreaAddrsLOffset	
	tay
	lda AreaDataAddrLow,y    ;use this offset to load another pointer
	sta AreaDataLow
	lda AreaDataAddrHigh,y
	sta AreaDataHigh
	ldy #$00		;load first byte of header
	lda (AreaData),y     
	pha			;save it to the stack for now
	and #%00000111	;save 3 LSB for foreground scenery or bg color control
	cmp #$04
	bcc StoreFore
	sta BackgroundColorCtrl  ;if 4 or greater, save value here as bg color control
	lda #$00
StoreFore:
	sta ForegroundScenery    ;if less, save value here as foreground scenery
	pla			;pull byte from stack and push it back
	pha
	and #%00111000	;save player entrance control bits
	lsr			;shift bits over to LSBs
	lsr
	lsr
	sta PlayerEntranceCtrl	;save value here as player entrance control
	pla			;pull byte again but do not push it back
	and #%11000000	;save 2 MSB for game timer setting
	clc
	rol			;rotate bits over to LSBs
	rol
	rol
	sta GameTimerSetting     ;save value here as game timer setting
	iny
	lda (AreaData),y	;load second byte of header
	pha			;save to stack
	and #%00001111	;mask out all but lower nybble
	sta TerrainControl
	pla			;pull and push byte to copy it to A
	pha
	and #%00110000	;save 2 MSB for background scenery type
	lsr
	lsr			;shift bits to LSBs
	lsr
	lsr
	sta BackgroundScenery    ;save as background scenery
	pla	
	and #%11000000
	clc
	rol			;rotate bits over to LSBs
	rol
	rol
	cmp #%00000011	;if set to 3, store here
	bne StoreStyle	;and nullify other value
	sta CloudTypeOverride    ;otherwise store value in other place
	lda #$00
StoreStyle:
	sta AreaStyle
	lda AreaDataLow	;increment area data address by 2 bytes
	clc
	adc #$02
	sta AreaDataLow
	lda AreaDataHigh
	adc #$00
	sta AreaDataHigh
	rts
