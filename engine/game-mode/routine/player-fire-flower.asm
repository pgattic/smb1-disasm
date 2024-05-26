
PlayerFireFlower:
	lda TimerControl	;check master timer control
	cmp #$c0		;for specific moment in time
	beq ResetPalFireFlower ;branch if at moment, not before or after
	lda FrameCounter	;get frame counter
	lsr
	lsr			;divide by four to change every four frames

CyclePlayerPalette:
	and #$03		;mask out all but d1-d0 (previously d3-d2)
	sta $00		;store result here to use as palette bits
	lda Player_SprAttrib  ;get player attributes
	and #%11111100	;save any other bits but palette bits
	ora $00		;add palette bits
	sta Player_SprAttrib  ;store as new player attributes
	rts			;and leave

ResetPalFireFlower:
	jsr DonePlayerTask    ;do sub to init timer control and run player control routine

ResetPalStar:
	lda Player_SprAttrib  ;get player attributes
	and #%11111100	;mask out palette bits to force palette 0
	sta Player_SprAttrib  ;store as new player attributes
	rts			;and leave

ExitDeath:
	rts	;leave from death routine
