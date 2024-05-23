
;$00 - vram buffer address table low, also used for pseudorandom bit
;$01 - vram buffer address table high

VRAM_AddrTable_Low:
	.db <VRAM_Buffer1, <WaterPaletteData, <GroundPaletteData
	.db <UndergroundPaletteData, <CastlePaletteData, <VRAM_Buffer1_Offset
	.db <VRAM_Buffer2, <VRAM_Buffer2, <BowserPaletteData
	.db <DaySnowPaletteData, <NightSnowPaletteData, <MushroomPaletteData
	.db <MarioThanksMessage, <LuigiThanksMessage, <MushroomRetainerSaved
	.db <PrincessSaved1, <PrincessSaved2, <WorldSelectMessage1
	.db <WorldSelectMessage2

VRAM_AddrTable_High:
	.db >VRAM_Buffer1, >WaterPaletteData, >GroundPaletteData
	.db >UndergroundPaletteData, >CastlePaletteData, >VRAM_Buffer1_Offset
	.db >VRAM_Buffer2, >VRAM_Buffer2, >BowserPaletteData
	.db >DaySnowPaletteData, >NightSnowPaletteData, >MushroomPaletteData
	.db >MarioThanksMessage, >LuigiThanksMessage, >MushroomRetainerSaved
	.db >PrincessSaved1, >PrincessSaved2, >WorldSelectMessage1
	.db >WorldSelectMessage2

VRAM_Buffer_Offset:
	.db <VRAM_Buffer1_Offset, <VRAM_Buffer2_Offset

NonMaskableInterrupt:
	lda Mirror_PPU_CTRL_REG1  ;disable NMIs in mirror reg
	and #%01111111		;save all other bits
	sta Mirror_PPU_CTRL_REG1
	and #%01111110		;alter name table address to be $2800
	sta PPU_CTRL_REG1	;(essentially $2000) but save other bits
	lda Mirror_PPU_CTRL_REG2  ;disable OAM and background display by default
	and #%11100110
	ldy DisableScreenFlag     ;get screen disable flag
	bne ScreenOff		;if set, used bits as-is
	lda Mirror_PPU_CTRL_REG2  ;otherwise reenable bits and save them
	ora #%00011110
ScreenOff:
	sta Mirror_PPU_CTRL_REG2  ;save bits for later but not in register at the moment
	and #%11100111		;disable screen for now
	sta PPU_CTRL_REG2
	ldx PPU_STATUS		;reset flip-flop and reset scroll registers to zero
	lda #$00
	jsr InitScroll
	sta PPU_SPR_ADDR	;reset spr-ram address register
	lda #$02			;perform spr-ram DMA access on $0200-$02ff
	sta SPR_DMA
	ldx VRAM_Buffer_AddrCtrl  ;load control for pointer to buffer contents
	lda VRAM_AddrTable_Low,x  ;set indirect at $00 to pointer
	sta $00
	lda VRAM_AddrTable_High,x
	sta $01
	jsr UpdateScreen	;update screen with buffer contents
	ldy #$00
	ldx VRAM_Buffer_AddrCtrl  ;check for usage of $0341
	cpx #$06
	bne InitBuffer
	iny			;get offset based on usage
InitBuffer:
	ldx VRAM_Buffer_Offset,y
	lda #$00			;clear buffer header at last location
	sta VRAM_Buffer1_Offset,x	
	sta VRAM_Buffer1,x
	sta VRAM_Buffer_AddrCtrl  ;reinit address control to $0301
	lda Mirror_PPU_CTRL_REG2  ;copy mirror of $2001 to register
	sta PPU_CTRL_REG2
	jsr SoundEngine	;play sound
	jsr ReadJoypads	;read joypads
	jsr PauseRoutine	;handle pause
	jsr UpdateTopScore
	lda GamePauseStatus	;check for pause status
	lsr
	bcs PauseSkip
	lda TimerControl	;if master timer control not set, decrement
	beq DecTimers		;all frame and interval timers
	dec TimerControl
	bne NoDecTimers
DecTimers:
	ldx #$14			;load end offset for end of frame timers
	dec IntervalTimerControl  ;decrement interval timer control,
	bpl DecTimersLoop	;if not expired, only frame timers will decrement
	lda #$14
	sta IntervalTimerControl  ;if control for interval timers expired,
	ldx #$23			;interval timers will decrement along with frame timers
DecTimersLoop:
	lda Timers,x		;check current timer
	beq SkipExpTimer	;if current timer expired, branch to skip,
	dec Timers,x		;otherwise decrement the current timer
SkipExpTimer:
	dex			;move onto next timer
	bpl DecTimersLoop	;do this until all timers are dealt with
NoDecTimers:
	inc FrameCounter	;increment frame counter
PauseSkip:
	ldx #$00
	ldy #$07
	lda PseudoRandomBitReg    ;get first memory location of LSFR bytes
	and #%00000010		;mask out all but d1
	sta $00			;save here
	lda PseudoRandomBitReg+1  ;get second memory location
	and #%00000010		;mask out all but d1
	eor $00			;perform exclusive-OR on d1 from first and second bytes
	clc			;if neither or both are set, carry will be clear
	beq RotPRandomBit
	sec			;if one or the other is set, carry will be set
RotPRandomBit:
	ror PseudoRandomBitReg,x  ;rotate carry into d7, and rotate last bit into carry
	inx			;increment to next byte
	dey			;decrement for loop
	bne RotPRandomBit
	lda Sprite0HitDetectFlag  ;check for flag here
	beq SkipSprite0
Sprite0Clr:
	lda PPU_STATUS		;wait for sprite 0 flag to clear, which will
	and #%01000000		;not happen until vblank has ended
	bne Sprite0Clr
	lda GamePauseStatus	;if in pause mode, do not bother with sprites at all
	lsr
	bcs Sprite0Hit
	jsr MoveSpritesOffscreen
	jsr SpriteShuffler
Sprite0Hit:
	lda PPU_STATUS		;do sprite #0 hit detection
	and #%01000000
	beq Sprite0Hit
	ldy #$14			;small delay, to wait until we hit horizontal blank time
HBlankDelay:
	dey
	bne HBlankDelay
SkipSprite0:
	lda HorizontalScroll	;set scroll registers from variables
	sta PPU_SCROLL_REG
	lda VerticalScroll
	sta PPU_SCROLL_REG
	lda Mirror_PPU_CTRL_REG1  ;load saved mirror of $2000
	pha
	sta PPU_CTRL_REG1
	lda GamePauseStatus	;if in pause mode, do not perform operation mode stuff
	lsr
	bcs SkipMainOper
	jsr OperModeExecutionTree ;otherwise do one of many, many possible subroutines
SkipMainOper:
	lda PPU_STATUS		;reset flip-flop
	pla
	ora #%10000000		;reactivate NMIs
	sta PPU_CTRL_REG1
	rti			;we are done until the next frame!
