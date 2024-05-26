
PlayerStarting_X_Pos:
	.db $28, $18
	.db $38, $28

AltYPosOffset:
	.db $08, $00

PlayerStarting_Y_Pos:
	.db $00, $20, $b0, $50, $00, $00, $b0, $b0
	.db $f0

PlayerBGPriorityData:
	.db $00, $20, $00, $00, $00, $00, $00, $00

GameTimerData:
	.db $20 ;dummy byte, used as part of bg priority data
	.db $04, $03, $02

Entrance_GameTimerSetup:
	lda ScreenLeft_PageLoc	;set current page for area objects
	sta Player_PageLoc	;as page location for player
	lda #$28			;store value here
	sta VerticalForceDown	;for fractional movement downwards if necessary
	lda #$01			;set high byte of player position and
	sta PlayerFacingDir	;set facing direction so that player faces right
	sta Player_Y_HighPos
	lda #$00			;set player state to on the ground by default
	sta Player_State
	dec Player_CollisionBits    ;initialize player's collision bits
	ldy #$00			;initialize halfway page
	sty HalfwayPage	
	lda AreaType		;check area type
	bne ChkStPos		;if water type, set swimming flag, otherwise do not set
	iny
ChkStPos:
	sty SwimmingFlag
	ldx PlayerEntranceCtrl	;get starting position loaded from header
	ldy AltEntranceControl	;check alternate mode of entry flag for 0 or 1
	beq SetStPos
	cpy #$01
	beq SetStPos
	ldx AltYPosOffset-2,y	;if not 0 or 1, override $0710 with new offset in X
SetStPos:
	lda PlayerStarting_X_Pos,y  ;load appropriate horizontal position
	sta Player_X_Position	;and vertical positions for the player, using
	lda PlayerStarting_Y_Pos,x  ;AltEntranceControl as offset for horizontal and either $0710
	sta Player_Y_Position	;or value that overwrote $0710 as offset for vertical
	lda PlayerBGPriorityData,x
	sta Player_SprAttrib	;set player sprite attributes using offset in X
	jsr GetPlayerColors	;get appropriate player palette
	ldy GameTimerSetting	;get timer control value from header
	beq ChkOverR		;if set to zero, branch (do not use dummy byte for this)
	lda FetchNewGameTimerFlag   ;do we need to set the game timer? if not, use 
	beq ChkOverR		;old game timer setting
	lda GameTimerData,y	;if game timer is set and game timer flag is also set,
	sta GameTimerDisplay	;use value of game timer control for first digit of game timer
	lda #$01
	sta GameTimerDisplay+2	;set last digit of game timer to 1
	lsr
	sta GameTimerDisplay+1	;set second digit of game timer
	sta FetchNewGameTimerFlag   ;clear flag for game timer reset
	sta StarInvincibleTimer     ;clear star mario timer
ChkOverR:
	ldy JoypadOverride	;if controller bits not set, branch to skip this part
	beq ChkSwimE
	lda #$03			;set player state to climbing
	sta Player_State
	ldx #$00			;set offset for first slot, for block object
	jsr InitBlock_XY_Pos
	lda #$f0			;set vertical coordinate for block object
	sta Block_Y_Position
	ldx #$05			;set offset in X for last enemy object buffer slot
	ldy #$00			;set offset in Y for object coordinates used earlier
	jsr Setup_Vine		;do a sub to grow vine
ChkSwimE:
	ldy AreaType		;if level not water-type,
	bne SetPESub		;skip this subroutine
	jsr SetupBubble		;otherwise, execute sub to set up air bubbles
SetPESub:
	lda #$07			;set to run player entrance subroutine
	sta GameEngineSubroutine    ;on the next frame of game engine
	rts
