
PlayerMovementSubs:
	lda #$00			;set A to init crouch flag by default
	ldy PlayerSize		;is player small?
	bne SetCrouch		;if so, branch
	lda Player_State	;check state of player
	bne ProcMove		;if not on the ground, branch
	lda Up_Down_Buttons	;load controller bits for up and down
	and #%00000100		;single out bit for down button
SetCrouch:
	sta CrouchingFlag	;store value in crouch flag
ProcMove:
	jsr PlayerPhysicsSub	;run sub related to jumping and swimming
	lda PlayerChangeSizeFlag  ;if growing/shrinking flag set,
	bne NoMoveSub		;branch to leave
	lda Player_State
	cmp #$03			;get player state
	beq MoveSubs		;if climbing, branch ahead, leave timer unset
	ldy #$18
	sty ClimbSideTimer	;otherwise reset timer now
MoveSubs:
	jsr JumpEngine

	.dw OnGroundStateSub
	.dw JumpSwimSub
	.dw FallingSub
	.dw ClimbingSub

NoMoveSub:
	rts

;-------------------------------------------------------------------------------------
;$00 - used by ClimbingSub to store high vertical adder

OnGroundStateSub:
	jsr GetPlayerAnimSpeed     ;do a sub to set animation frame timing
	lda Left_Right_Buttons
	beq GndMove		;if left/right controller bits not set, skip instruction
	sta PlayerFacingDir	;otherwise set new facing direction
GndMove:
	jsr ImposeFriction	;do a sub to impose friction on player's walk/run
	jsr MovePlayerHorizontally ;do another sub to move player horizontally
	sta Player_X_Scroll	;set returned value as player's movement speed for scroll
	rts

;--------------------------------

FallingSub:
	lda VerticalForceDown
	sta VerticalForce	;dump vertical movement force for falling into main one
	jmp LRAir		;movement force, then skip ahead to process left/right movement

;--------------------------------

JumpSwimSub:
	ldy Player_Y_Speed	;if player's vertical speed zero
	bpl DumpFall		;or moving downwards, branch to falling
	lda A_B_Buttons
	and #A_Button		;check to see if A button is being pressed
	and PreviousA_B_Buttons    ;and was pressed in previous frame
	bne ProcSwim		;if so, branch elsewhere
	lda JumpOrigin_Y_Position  ;get vertical position player jumped from
	sec
	sbc Player_Y_Position	;subtract current from original vertical coordinate
	cmp DiffToHaltJump	;compare to value set here to see if player is in mid-jump
	bcc ProcSwim		;or just starting to jump, if just starting, skip ahead
DumpFall:
	lda VerticalForceDown	;otherwise dump falling into main fractional
	sta VerticalForce
ProcSwim:
	lda SwimmingFlag	;if swimming flag not set,
	beq LRAir			;branch ahead to last part
	jsr GetPlayerAnimSpeed     ;do a sub to get animation frame timing
	lda Player_Y_Position
	cmp #$14			;check vertical position against preset value
	bcs LRWater		;if not yet reached a certain position, branch ahead
	lda #$18
	sta VerticalForce	;otherwise set fractional
LRWater:
	lda Left_Right_Buttons     ;check left/right controller bits (check for swimming)
	beq LRAir			;if not pressing any, skip
	sta PlayerFacingDir	;otherwise set facing direction accordingly
LRAir:
	lda Left_Right_Buttons     ;check left/right controller bits (check for jumping/falling)
	beq JSMove		;if not pressing any, skip
	jsr ImposeFriction	;otherwise process horizontal movement
JSMove:
	jsr MovePlayerHorizontally ;do a sub to move player horizontally
	sta Player_X_Scroll	;set player's speed here, to be used for scroll later
	lda GameEngineSubroutine
	cmp #$0b			;check for specific routine selected
	bne ExitMov1		;branch if not set to run
	lda #$28
	sta VerticalForce	;otherwise set fractional
ExitMov1:
	jmp MovePlayerVertically   ;jump to move player vertically, then leave

ClimbAdderLow:
	.db $0e, $04, $fc, $f2
ClimbAdderHigh:
	.db $00, $00, $ff, $ff

ClimbingSub:
	lda Player_YMF_Dummy
	clc			;add movement force to dummy variable
	adc Player_Y_MoveForce   ;save with carry
	sta Player_YMF_Dummy
	ldy #$00		;set default adder here
	lda Player_Y_Speed	;get player's vertical speed
	bpl MoveOnVine	;if not moving upwards, branch
	dey			;otherwise set adder to $ff
MoveOnVine:
	sty $00			;store adder here
	adc Player_Y_Position    ;add carry to player's vertical position
	sta Player_Y_Position    ;and store to move player up or down
	lda Player_Y_HighPos
	adc $00			;add carry to player's page location
	sta Player_Y_HighPos     ;and store
	lda Left_Right_Buttons   ;compare left/right controller bits
	and Player_CollisionBits ;to collision flag
	beq InitCSTimer	;if not set, skip to end
	ldy ClimbSideTimer	;otherwise check timer 
	bne ExitCSub		;if timer not expired, branch to leave
	ldy #$18
	sty ClimbSideTimer	;otherwise set timer now
	ldx #$00		;set default offset here
	ldy PlayerFacingDir	;get facing direction
	lsr			;move right button controller bit to carry
	bcs ClimbFD		;if controller right pressed, branch ahead
	inx
	inx			;otherwise increment offset by 2 bytes
ClimbFD:
	dey			;check to see if facing right
	beq CSetFDir		;if so, branch, do not increment
	inx			;otherwise increment by 1 byte
CSetFDir:
	lda Player_X_Position
	clc			;add or subtract from player's horizontal position
	adc ClimbAdderLow,x	;using value here as adder and X as offset
	sta Player_X_Position
	lda Player_PageLoc	;add or subtract carry or borrow using value here
	adc ClimbAdderHigh,x     ;from the player's page location
	sta Player_PageLoc
	lda Left_Right_Buttons   ;get left/right controller bits again
	eor #%00000011	;invert them and store them while player
	sta PlayerFacingDir	;is on vine to face player in opposite direction
ExitCSub:
	rts			;then leave
InitCSTimer:
	sta ClimbSideTimer	;initialize timer here
	rts

;-------------------------------------------------------------------------------------
;$00 - used to store offset to friction data

JumpMForceData:
	.db $20, $20, $1e, $28, $28, $0d, $04

FallMForceData:
	.db $70, $70, $60, $90, $90, $0a, $09

PlayerYSpdData:
	.db $fc, $fc, $fc, $fb, $fb, $fe, $ff

InitMForceData:
	.db $00, $00, $00, $00, $00, $80, $00

MaxLeftXSpdData:
	.db $d8, $e8, $f0

MaxRightXSpdData:
	.db $28, $18, $10
	.db $0c ;used for pipe intros

FrictionData:
	.db $e4, $98, $d0

Climb_Y_SpeedData:
	.db $00, $ff, $01

Climb_Y_MForceData:
	.db $00, $20, $ff

PlayerPhysicsSub:
	lda Player_State	;check player state
	cmp #$03
	bne CheckForJumping	;if not climbing, branch
	ldy #$00
	lda Up_Down_Buttons	;get controller bits for up/down
	and Player_CollisionBits  ;check against player's collision detection bits
	beq ProcClimb		;if not pressing up or down, branch
	iny
	and #%00001000		;check for pressing up
	bne ProcClimb
	iny
ProcClimb:
	ldx Climb_Y_MForceData,y  ;load value here
	stx Player_Y_MoveForce    ;store as vertical movement force
	lda #$08			;load default animation timing
	ldx Climb_Y_SpeedData,y   ;load some other value here
	stx Player_Y_Speed	;store as vertical speed
	bmi SetCAnim		;if climbing down, use default animation timing value
	lsr			;otherwise divide timer setting by 2
SetCAnim:
	sta PlayerAnimTimerSet    ;store animation timer setting and leave
	rts

CheckForJumping:
	lda JumpspringAnimCtrl    ;if jumpspring animating, 
	bne NoJump		;skip ahead to something else
	lda A_B_Buttons	;check for A button press
	and #A_Button
	beq NoJump		;if not, branch to something else
	and PreviousA_B_Buttons   ;if button not pressed in previous frame, branch
	beq ProcJumping
NoJump:
	jmp X_Physics		;otherwise, jump to something else

ProcJumping:
	lda Player_State	;check player state
	beq InitJS		;if on the ground, branch
	lda SwimmingFlag	;if swimming flag not set, jump to do something else
	beq NoJump		;to prevent midair jumping, otherwise continue
	lda JumpSwimTimer	;if jump/swim timer nonzero, branch
	bne InitJS
	lda Player_Y_Speed	;check player's vertical speed
	bpl InitJS		;if player's vertical speed motionless or down, branch
	jmp X_Physics		;if timer at zero and player still rising, do not swim
InitJS:
	lda #$20			;set jump/swim timer
	sta JumpSwimTimer
	ldy #$00			;initialize vertical force and dummy variable
	sty Player_YMF_Dummy
	sty Player_Y_MoveForce
	lda Player_Y_HighPos	;get vertical high and low bytes of jump origin
	sta JumpOrigin_Y_HighPos   ;and store them next to each other here
	lda Player_Y_Position
	sta JumpOrigin_Y_Position
	lda #$01			;set player state to jumping/swimming
	sta Player_State
	lda Player_XSpeedAbsolute  ;check value related to walking/running speed
	cmp #$09
	bcc ChkWtr		;branch if below certain values, increment Y
	iny				;for each amount equal or exceeded
	cmp #$10
	bcc ChkWtr
	iny
	cmp #$19
	bcc ChkWtr
	iny
	cmp #$1c
	bcc ChkWtr		;note that for jumping, range is 0-4 for Y
	iny
ChkWtr:
	lda #$01			;set value here (apparently always set to 1)
	sta DiffToHaltJump
	lda SwimmingFlag	;if swimming flag disabled, branch
	beq GetYPhy
	ldy #$05			;otherwise set Y to 5, range is 5-6
	lda Whirlpool_Flag	;if whirlpool flag not set, branch
	beq GetYPhy
	iny				;otherwise increment to 6
GetYPhy:
	lda JumpMForceData,y	;store appropriate jump/swim
	sta VerticalForce	;data here
	lda FallMForceData,y
	sta VerticalForceDown
	lda InitMForceData,y
	sta Player_Y_MoveForce
	lda PlayerYSpdData,y
	sta Player_Y_Speed
	lda SwimmingFlag	;if swimming flag disabled, branch
	beq PJumpSnd
	lda #Sfx_EnemyStomp	;load swim/goomba stomp sound into
	sta Square1SoundQueue	;square 1's sfx queue
	lda Player_Y_Position
	cmp #$14			;check vertical low byte of player position
	bcs X_Physics		;if below a certain point, branch
	lda #$00			;otherwise reset player's vertical speed
	sta Player_Y_Speed	;and jump to something else to keep player
	jmp X_Physics		;from swimming above water level
PJumpSnd:
	lda #Sfx_BigJump	;load big mario's jump sound by default
	ldy PlayerSize		;is mario big?
	beq SJumpSnd
	lda #Sfx_SmallJump	;if not, load small mario's jump sound
SJumpSnd:
	sta Square1SoundQueue	;store appropriate jump sound in square 1 sfx queue
X_Physics:
	ldy #$00
	sty $00			;init value here
	lda Player_State	;if mario is on the ground, branch
	beq ProcPRun
	lda Player_XSpeedAbsolute  ;check something that seems to be related
	cmp #$19			;to mario's speed
	bcs GetXPhy		;if =>$19 branch here
	bcc ChkRFast		;if not branch elsewhere
ProcPRun:
	iny				;if mario on the ground, increment Y
	lda AreaType		;check area type
	beq ChkRFast		;if water type, branch
	dey				;decrement Y by default for non-water type area
	lda Left_Right_Buttons     ;get left/right controller bits
	cmp Player_MovingDir	;check against moving direction
	bne ChkRFast		;if controller bits <> moving direction, skip this part
	lda A_B_Buttons		;check for b button pressed
	and #B_Button
	bne SetRTmr		;if pressed, skip ahead to set timer
	lda RunningTimer	;check for running timer set
	bne GetXPhy		;if set, branch
ChkRFast:
	iny				;if running timer not set or level type is water, 
	inc $00			;increment Y again and temp variable in memory
	lda RunningSpeed
	bne FastXSp		;if running speed set here, branch
	lda Player_XSpeedAbsolute
	cmp #$21			;otherwise check player's walking/running speed
	bcc GetXPhy		;if less than a certain amount, branch ahead
FastXSp:
	inc $00			;if running speed set or speed => $21 increment $00
	jmp GetXPhy		;and jump ahead
SetRTmr:
	lda #$0a			;if b button pressed, set running timer
	sta RunningTimer
GetXPhy:
	lda MaxLeftXSpdData,y	;get maximum speed to the left
	sta MaximumLeftSpeed
	lda GameEngineSubroutine   ;check for specific routine running
	cmp #$07			;(player entrance)
	bne GetXPhy2		;if not running, skip and use old value of Y
	ldy #$03			;otherwise set Y to 3
GetXPhy2:
	lda MaxRightXSpdData,y     ;get maximum speed to the right
	sta MaximumRightSpeed
	ldy $00			;get other value in memory
	lda FrictionData,y	;get value using value in memory as offset
	sta FrictionAdderLow
	lda #$00
	sta FrictionAdderHigh	;init something here
	lda PlayerFacingDir
	cmp Player_MovingDir	;check facing direction against moving direction
	beq ExitPhy		;if the same, branch to leave
	asl FrictionAdderLow	;otherwise shift d7 of friction adder low into carry
	rol FrictionAdderHigh	;then rotate carry onto d0 of friction adder high
ExitPhy:
	rts				;and then leave

;-------------------------------------------------------------------------------------

PlayerAnimTmrData:
	.db $02, $04, $07

GetPlayerAnimSpeed:
	ldy #$00			;initialize offset in Y
	lda Player_XSpeedAbsolute  ;check player's walking/running speed
	cmp #$1c			;against preset amount
	bcs SetRunSpd		;if greater than a certain amount, branch ahead
	iny				;otherwise increment Y
	cmp #$0e			;compare against lower amount
	bcs ChkSkid		;if greater than this but not greater than first, skip increment
	iny				;otherwise increment Y again
ChkSkid:
	lda SavedJoypadBits	;get controller bits
	and #%01111111		;mask out A button
	beq SetAnimSpd		;if no other buttons pressed, branch ahead of all this
	and #$03			;mask out all others except left and right
	cmp Player_MovingDir	;check against moving direction
	bne ProcSkid		;if left/right controller bits <> moving direction, branch
	lda #$00			;otherwise set zero value here
SetRunSpd:
	sta RunningSpeed	;store zero or running speed here
	jmp SetAnimSpd
ProcSkid:
	lda Player_XSpeedAbsolute  ;check player's walking/running speed
	cmp #$0b			;against one last amount
	bcs SetAnimSpd		;if greater than this amount, branch
	lda PlayerFacingDir
	sta Player_MovingDir	;otherwise use facing direction to set moving direction
	lda #$00
	sta Player_X_Speed	;nullify player's horizontal speed
	sta Player_X_MoveForce     ;and dummy variable for player
SetAnimSpd:
	lda PlayerAnimTmrData,y    ;get animation timer setting using Y as offset
	sta PlayerAnimTimerSet
	rts

;-------------------------------------------------------------------------------------

ImposeFriction:
	and Player_CollisionBits  ;perform AND between left/right controller bits and collision flag
	cmp #$00			;then compare to zero (this instruction is redundant)
	bne JoypFrict		;if any bits set, branch to next part
	lda Player_X_Speed
	beq SetAbsSpd		;if player has no horizontal speed, branch ahead to last part
	bpl RghtFrict		;if player moving to the right, branch to slow
	bmi LeftFrict		;otherwise logic dictates player moving left, branch to slow
JoypFrict:
	lsr			;put right controller bit into carry
	bcc RghtFrict		;if left button pressed, carry = 0, thus branch
LeftFrict:
	lda Player_X_MoveForce    ;load value set here
	clc
	adc FrictionAdderLow	;add to it another value set here
	sta Player_X_MoveForce    ;store here
	lda Player_X_Speed
	adc FrictionAdderHigh     ;add value plus carry to horizontal speed
	sta Player_X_Speed	;set as new horizontal speed
	cmp MaximumRightSpeed     ;compare against maximum value for right movement
	bmi XSpdSign		;if horizontal speed greater negatively, branch
	lda MaximumRightSpeed     ;otherwise set preset value as horizontal speed
	sta Player_X_Speed	;thus slowing the player's left movement down
	jmp SetAbsSpd		;skip to the end
RghtFrict:
	lda Player_X_MoveForce    ;load value set here
	sec
	sbc FrictionAdderLow	;subtract from it another value set here
	sta Player_X_MoveForce    ;store here
	lda Player_X_Speed
	sbc FrictionAdderHigh     ;subtract value plus borrow from horizontal speed
	sta Player_X_Speed	;set as new horizontal speed
	cmp MaximumLeftSpeed	;compare against maximum value for left movement
	bpl XSpdSign		;if horizontal speed greater positively, branch
	lda MaximumLeftSpeed	;otherwise set preset value as horizontal speed
	sta Player_X_Speed	;thus slowing the player's right movement down
XSpdSign:
	cmp #$00			;if player not moving or moving to the right,
	bpl SetAbsSpd		;branch and leave horizontal speed value unmodified
	eor #$ff
	clc			;otherwise get two's compliment to get absolute
	adc #$01			;unsigned walking/running speed
SetAbsSpd:
	sta Player_XSpeedAbsolute ;store walking/running speed here and leave
	rts

