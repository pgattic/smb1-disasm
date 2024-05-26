
PlayerEntrance:
	lda AltEntranceControl    ;check for mode of alternate entry
	cmp #$02
	beq EntrMode2		;if found, branch to enter from pipe or with vine
	lda #$00	
	ldy Player_Y_Position     ;if vertical position above a certain
	cpy #$30			;point, nullify controller bits and continue
	bcc AutoControlPlayer     ;with player movement code, do not return
	lda PlayerEntranceCtrl    ;check player entry bits from header
	cmp #$06
	beq ChkBehPipe		;if set to 6 or 7, execute pipe intro code
	cmp #$07			;otherwise branch to normal entry
	bne PlayerRdy
ChkBehPipe:
	lda Player_SprAttrib	;check for sprite attributes
	bne IntroEntr		;branch if found
	lda #$01
	jmp AutoControlPlayer     ;force player to walk to the right
IntroEntr:
	jsr EnterSidePipe	;execute sub to move player to the right
	dec ChangeAreaTimer	;decrement timer for change of area
	bne ExitEntr		;branch to exit if not yet expired
	inc DisableIntermediate   ;set flag to skip world and lives display
	jmp NextArea		;jump to increment to next area and set modes
EntrMode2:
	lda JoypadOverride	;if controller override bits set here,
	bne VineEntr		;branch to enter with vine
	lda #$ff			;otherwise, set value here then execute sub
	jsr MovePlayerYAxis	;to move player upwards (note $ff = -1)
	lda Player_Y_Position     ;check to see if player is at a specific coordinate
	cmp #$91			;if player risen to a certain point (this requires pipes
	bcc PlayerRdy		;to be at specific height to look/function right) branch
	rts			;to the last part, otherwise leave
VineEntr:
	lda VineHeight
	cmp #$60			;check vine height
	bne ExitEntr		;if vine not yet reached maximum height, branch to leave
	lda Player_Y_Position     ;get player's vertical coordinate
	cmp #$99			;check player's vertical coordinate against preset value
	ldy #$00			;load default values to be written to 
	lda #$01			;this value moves player to the right off the vine
	bcc OffVine		;if vertical coordinate < preset value, use defaults
	lda #$03
	sta Player_State	;otherwise set player state to climbing
	iny			;increment value in Y
	lda #$08			;set block in block buffer to cover hole, then 
	sta Block_Buffer_1+$b4    ;use same value to force player to climb
OffVine:
	sty DisableCollisionDet   ;set collision detection disable flag
	jsr AutoControlPlayer     ;use contents of A to move player up or right, execute sub
	lda Player_X_Position
	cmp #$48			;check player's horizontal position
	bcc ExitEntr		;if not far enough to the right, branch to leave
PlayerRdy:
	lda #$08			;set routine to be executed by game engine next frame
	sta GameEngineSubroutine
	lda #$01			;set to face player to the right
	sta PlayerFacingDir
	lsr			;init A
	sta AltEntranceControl    ;init mode of entry
	sta DisableCollisionDet   ;init collision detection disable flag
	sta JoypadOverride	;nullify controller override bits
ExitEntr:
	rts			;leave!
