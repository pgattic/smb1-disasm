;$07 - used to hold upper limit of high byte when player falls down hole

AutoControlPlayer:
	sta SavedJoypadBits	;override controller bits with contents of A if executing here

PlayerCtrlRoutine:
	lda GameEngineSubroutine    ;check task here
	cmp #$0b			;if certain value is set, branch to skip controller bit loading
	beq SizeChk
	lda AreaType		;are we in a water type area?
	bne SaveJoyp		;if not, branch
	ldy Player_Y_HighPos
	dey				;if not in vertical area between
	bne DisJoyp		;status bar and bottom, branch
	lda Player_Y_Position
	cmp #$d0			;if nearing the bottom of the screen or
	bcc SaveJoyp		;not in the vertical area between status bar or bottom,
DisJoyp:
	lda #$00			;disable controller bits
	sta SavedJoypadBits
SaveJoyp:
	lda SavedJoypadBits	;otherwise store A and B buttons in $0a
	and #%11000000
	sta A_B_Buttons
	lda SavedJoypadBits	;store left and right buttons in $0c
	and #%00000011
	sta Left_Right_Buttons
	lda SavedJoypadBits	;store up and down buttons in $0b
	and #%00001100
	sta Up_Down_Buttons
	and #%00000100		;check for pressing down
	beq SizeChk		;if not, branch
	lda Player_State		;check player's state
	bne SizeChk		;if not on the ground, branch
	ldy Left_Right_Buttons	;check left and right
	beq SizeChk		;if neither pressed, branch
	lda #$00
	sta Left_Right_Buttons	;if pressing down while on the ground,
	sta Up_Down_Buttons	;nullify directional bits
SizeChk:
	jsr PlayerMovementSubs	;run movement subroutines
	ldy #$01			;is player small?
	lda PlayerSize
	bne ChkMoveDir
	ldy #$00			;check for if crouching
	lda CrouchingFlag
	beq ChkMoveDir		;if not, branch ahead
	ldy #$02			;if big and crouching, load y with 2
ChkMoveDir:
	sty Player_BoundBoxCtrl     ;set contents of Y as player's bounding box size control
	lda #$01			;set moving direction to right by default
	ldy Player_X_Speed	;check player's horizontal speed
	beq PlayerSubs		;if not moving at all horizontally, skip this part
	bpl SetMoveDir		;if moving to the right, use default moving direction
	asl				;otherwise change to move to the left
SetMoveDir:
	sta Player_MovingDir	;set moving direction
PlayerSubs:
	jsr ScrollHandler	;move the screen if necessary
	jsr GetPlayerOffscreenBits  ;get player's offscreen bits
	jsr RelativePlayerPosition  ;get coordinates relative to the screen
	ldx #$00			;set offset for player object
	jsr BoundingBoxCore	;get player's bounding box coordinates
	jsr PlayerBGCollision	;do collision detection and process
	lda Player_Y_Position
	cmp #$40			;check to see if player is higher than 64th pixel
	bcc PlayerHole		;if so, branch ahead
	lda GameEngineSubroutine
	cmp #$05			;if running end-of-level routine, branch ahead
	beq PlayerHole
	cmp #$07			;if running player entrance routine, branch ahead
	beq PlayerHole
	cmp #$04			;if running routines $00-$03, branch ahead
	bcc PlayerHole
	lda Player_SprAttrib
	and #%11011111		;otherwise nullify player's
	sta Player_SprAttrib	;background priority flag
PlayerHole:
	lda Player_Y_HighPos	;check player's vertical high byte
	cmp #$02			;for below the screen
	bmi ExitCtrl		;branch to leave if not that far down
	ldx #$01
	stx ScrollLock		;set scroll lock
	ldy #$04
	sty $07			;set value here
	ldx #$00			;use X as flag, and clear for cloud level
	ldy GameTimerExpiredFlag    ;check game timer expiration flag
	bne HoleDie		;if set, branch
	ldy CloudTypeOverride	;check for cloud type override
	bne ChkHoleX		;skip to last part if found
HoleDie:
	inx				;set flag in X for player death
	ldy GameEngineSubroutine
	cpy #$0b			;check for some other routine running
	beq ChkHoleX		;if so, branch ahead
	ldy DeathMusicLoaded	;check value here
	bne HoleBottom		;if already set, branch to next part
	iny
	sty EventMusicQueue	;otherwise play death music
	sty DeathMusicLoaded	;and set value here
HoleBottom:
	ldy #$06
	sty $07			;change value here
ChkHoleX:
	cmp $07			;compare vertical high byte with value set here
	bmi ExitCtrl		;if less, branch to leave
	dex				;otherwise decrement flag in X
	bmi CloudExit		;if flag was clear, branch to set modes and other values
	ldy EventMusicBuffer	;check to see if music is still playing
	bne ExitCtrl		;branch to leave if so
	lda #$06			;otherwise set to run lose life routine
	sta GameEngineSubroutine    ;on next frame
ExitCtrl:
	rts				;leave

CloudExit:
	lda #$00
	sta JoypadOverride	;clear controller override bits if any are set
	jsr SetEntr		;do sub to set secondary mode
	inc AltEntranceControl  ;set mode of entry to 3
	rts
