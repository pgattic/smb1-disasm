
DemoActionData:
	.db $01, $80, $02, $81, $41, $80, $01
	.db $42, $c2, $02, $80, $41, $c1, $41, $c1
	.db $01, $c1, $01, $02, $80, $00

DemoTimingData:
	.db $9b, $10, $18, $05, $2c, $20, $24
	.db $15, $5a, $10, $20, $28, $30, $20, $10
	.db $80, $20, $30, $30, $01, $ff, $00

DemoEngine:
	ldx DemoAction	;load current demo action
	lda DemoActionTimer    ;load current action timer
	bne DoAction	;if timer still counting down, skip
	inx
	inc DemoAction	;if expired, increment action, X, and
	sec			;set carry by default for demo over
	lda DemoTimingData-1,x ;get next timer
	sta DemoActionTimer    ;store as current timer
	beq DemoOver	;if timer already at zero, skip
DoAction:
	lda DemoActionData-1,x ;get and perform action (current or next)
	sta SavedJoypad1Bits
	dec DemoActionTimer    ;decrement action timer
	clc			;clear carry if demo still going
DemoOver:
	rts

