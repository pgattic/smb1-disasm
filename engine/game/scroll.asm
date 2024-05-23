
ScrollHandler:
	lda Player_X_Scroll	;load value saved here
	clc
	adc Platform_X_Scroll     ;add value used by left/right platforms
	sta Player_X_Scroll	;save as new value here to impose force on scroll
	lda ScrollLock		;check scroll lock flag
	bne InitScrlAmt	;skip a bunch of code here if set
	lda Player_Pos_ForScroll
	cmp #$50			;check player's horizontal screen position
	bcc InitScrlAmt	;if less than 80 pixels to the right, branch
	lda SideCollisionTimer    ;if timer related to player's side collision
	bne InitScrlAmt	;not expired, branch
	ldy Player_X_Scroll	;get value and decrement by one
	dey			;if value originally set to zero or otherwise
	bmi InitScrlAmt	;negative for left movement, branch
	iny
	cpy #$02			;if value $01, branch and do not decrement
	bcc ChkNearMid
	dey			;otherwise decrement by one
ChkNearMid:
	lda Player_Pos_ForScroll
	cmp #$70			;check player's horizontal screen position
	bcc ScrollScreen	;if less than 112 pixels to the right, branch
	ldy Player_X_Scroll	;otherwise get original value undecremented

ScrollScreen:
	tya
	sta ScrollAmount	;save value here
	clc
	adc ScrollThirtyTwo	;add to value already set here
	sta ScrollThirtyTwo	;save as new value here
	tya
	clc
	adc ScreenLeft_X_Pos	;add to left side coordinate
	sta ScreenLeft_X_Pos	;save as new left side coordinate
	sta HorizontalScroll	;save here also
	lda ScreenLeft_PageLoc
	adc #$00			;add carry to page location for left
	sta ScreenLeft_PageLoc    ;side of the screen
	and #$01			;get LSB of page location
	sta $00			;save as temp variable for PPU register 1 mirror
	lda Mirror_PPU_CTRL_REG1  ;get PPU register 1 mirror
	and #%11111110		;save all bits except d0
	ora $00			;get saved bit here and save in PPU register 1
	sta Mirror_PPU_CTRL_REG1  ;mirror to be used to set name table later
	jsr GetScreenPosition     ;figure out where the right side is
	lda #$08
	sta ScrollIntervalTimer   ;set scroll timer (residual, not used elsewhere)
	jmp ChkPOffscr		;skip this part
InitScrlAmt:
	lda #$00
	sta ScrollAmount	;initialize value here
ChkPOffscr:
	ldx #$00			;set X for player offset
	jsr GetXOffscreenBits     ;get horizontal offscreen bits for player
	sta $00			;save them here
	ldy #$00			;load default offset (left side)
	asl			;if d7 of offscreen bits are set,
	bcs KeepOnscr		;branch with default offset
	iny				;otherwise use different offset (right side)
	lda $00
	and #%00100000		;check offscreen bits for d5 set
	beq InitPlatScrl		;if not set, branch ahead of this part
KeepOnscr:
	lda ScreenEdge_X_Pos,y	;get left or right side coordinate based on offset
	sec
	sbc X_SubtracterData,y	;subtract amount based on offset
	sta Player_X_Position	;store as player position to prevent movement further
	lda ScreenEdge_PageLoc,y    ;get left or right page location based on offset
	sbc #$00			;subtract borrow
	sta Player_PageLoc	;save as player's page location
	lda Left_Right_Buttons	;check saved controller bits
	cmp OffscrJoypadBitsData,y  ;against bits based on offset
	beq InitPlatScrl		;if not equal, branch
	lda #$00
	sta Player_X_Speed	;otherwise nullify horizontal speed of player
InitPlatScrl:
	lda #$00			;nullify platform force imposed on scroll
	sta Platform_X_Scroll
	rts

X_SubtracterData:
	.db $00, $10

OffscrJoypadBitsData:
	.db $01, $02

GetScreenPosition:
	lda ScreenLeft_X_Pos    ;get coordinate of screen's left boundary
	clc
	adc #$ff		;add 255 pixels
	sta ScreenRight_X_Pos   ;store as coordinate of screen's right boundary
	lda ScreenLeft_PageLoc  ;get page number where left boundary is
	adc #$00		;add carry from before
	sta ScreenRight_PageLoc ;store as page number where right boundary is
	rts
