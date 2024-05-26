
GameCoreRoutine:
	ldx CurrentPlayer	;get which player is on the screen
	lda SavedJoypadBits,x	;use appropriate player's controller bits
	sta SavedJoypadBits	;as the master controller bits
	jsr GameRoutines	;execute one of many possible subs
	lda OperMode_Task	;check major task of operating mode
	cmp #$03			;if we are supposed to be here,
	bcs GameEngine		;branch to the game engine itself
	rts

GameEngine:
	jsr ProcFireball_Bubble    ;process fireballs and air bubbles
	ldx #$00
ProcELoop:
	stx ObjectOffset	;put incremented offset in X as enemy object offset
	jsr EnemiesAndLoopsCore    ;process enemy objects
	jsr FloateyNumbersRoutine  ;process floatey numbers
	inx
	cpx #$06			;do these two subroutines until the whole buffer is done
	bne ProcELoop
	jsr GetPlayerOffscreenBits ;get offscreen bits for player object
	jsr RelativePlayerPosition ;get relative coordinates for player object
	jsr PlayerGfxHandler	;draw the player
	jsr BlockObjMT_Updater     ;replace block objects with metatiles if necessary
	ldx #$01
	stx ObjectOffset	;set offset for second
	jsr BlockObjectsCore	;process second block object
	dex
	stx ObjectOffset	;set offset for first
	jsr BlockObjectsCore	;process first block object
	jsr MiscObjectsCore	;process misc objects (hammer, jumping coins)
	jsr ProcessCannons	;process bullet bill cannons
	jsr ProcessWhirlpools	;process whirlpools
	jsr FlagpoleRoutine	;process the flagpole
	jsr RunGameTimer	;count down the game timer
	jsr ColorRotation	;cycle one of the background colors
	lda Player_Y_HighPos
	cmp #$02			;if player is below the screen, don't bother with the music
	bpl NoChgMus
	lda StarInvincibleTimer    ;if star mario invincibility timer at zero,
	beq ClrPlrPal		;skip this part
	cmp #$04
	bne NoChgMus		;if not yet at a certain point, continue
	lda IntervalTimerControl   ;if interval timer not yet expired,
	bne NoChgMus		;branch ahead, don't bother with the music
	jsr GetAreaMusic	;to re-attain appropriate level music
NoChgMus:
	ldy StarInvincibleTimer    ;get invincibility timer
	lda FrameCounter	;get frame counter
	cpy #$08			;if timer still above certain point,
	bcs CycleTwo		;branch to cycle player's palette quickly
	lsr				;otherwise, divide by 8 to cycle every eighth frame
	lsr
CycleTwo:
	lsr				;if branched here, divide by 2 to cycle every other frame
	jsr CyclePlayerPalette     ;do sub to cycle the palette (note: shares fire flower code)
	jmp SaveAB		;then skip this sub to finish up the game engine
ClrPlrPal:
	jsr ResetPalStar	;do sub to clear player's palette bits in attributes
SaveAB:	lda A_B_Buttons		;save current A and B button
	sta PreviousA_B_Buttons    ;into temp variable to be used on next frame
	lda #$00
	sta Left_Right_Buttons     ;nullify left and right buttons temp variable
UpdScrollVar:
	lda VRAM_Buffer_AddrCtrl
	cmp #$06			;if vram address controller set to 6 (one of two $0341s)
	beq ExitEng		;then branch to leave
	lda AreaParserTaskNum	;otherwise check number of tasks
	bne RunParser
	lda ScrollThirtyTwo	;get horizontal scroll in 0-31 or $00-$20 range
	cmp #$20			;check to see if exceeded $21
	bmi ExitEng		;branch to leave if not
	lda ScrollThirtyTwo
	sbc #$20			;otherwise subtract $20 to set appropriately
	sta ScrollThirtyTwo	;and store
	lda #$00			;reset vram buffer offset used in conjunction with
	sta VRAM_Buffer2_Offset    ;level graphics buffer at $0341-$035f
RunParser:
	jsr AreaParserTaskHandler  ;update the name table with more level graphics
ExitEng:
	rts				;and after all that, we're finally done!
