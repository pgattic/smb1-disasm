
PrintVictoryMessages:
	lda SecondaryMsgCounter   ;load secondary message counter
	bne IncMsgCounter	;if set, branch to increment message counters
	lda PrimaryMsgCounter     ;otherwise load primary message counter
	beq ThankPlayer	;if set to zero, branch to print first message
	cmp #$09			;if at 9 or above, branch elsewhere (this comparison
	bcs IncMsgCounter	;is residual code, counter never reaches 9)
	ldy WorldNumber	;check world number
	cpy #World8
	bne MRetainerMsg	;if not at world 8, skip to next part
	cmp #$03			;check primary message counter again
	bcc IncMsgCounter	;if not at 3 yet (world 8 only), branch to increment
	sbc #$01			;otherwise subtract one
	jmp ThankPlayer	;and skip to next part
MRetainerMsg:
	cmp #$02			;check primary message counter
	bcc IncMsgCounter	;if not at 2 yet (world 1-7 only), branch
ThankPlayer:
	tay			;put primary message counter into Y
	bne SecondPartMsg	;if counter nonzero, skip this part, do not print first message
	lda CurrentPlayer	;otherwise get player currently on the screen
	beq EvalForMusic	;if mario, branch
	iny			;otherwise increment Y once for luigi and
	bne EvalForMusic	;do an unconditional branch to the same place
SecondPartMsg:
	iny			;increment Y to do world 8's message
	lda WorldNumber
	cmp #World8		;check world number
	beq EvalForMusic	;if at world 8, branch to next part
	dey			;otherwise decrement Y for world 1-7's message
	cpy #$04			;if counter at 4 (world 1-7 only)
	bcs SetEndTimer	;branch to set victory end timer
	cpy #$03			;if counter at 3 (world 1-7 only)
	bcs IncMsgCounter	;branch to keep counting
EvalForMusic:
	cpy #$03			;if counter not yet at 3 (world 8 only), branch
	bne PrintMsg		;to print message only (note world 1-7 will only
	lda #VictoryMusic	;reach this code if counter = 0, and will always branch)
	sta EventMusicQueue	;otherwise load victory music first (world 8 only)
PrintMsg:	tya			;put primary message counter in A
	clc			;add $0c or 12 to counter thus giving an appropriate value,
	adc #$0c			;($0c-$0d = first), ($0e = world 1-7's), ($0f-$12 = world 8's)
	sta VRAM_Buffer_AddrCtrl  ;write message counter to vram address controller
IncMsgCounter:
	lda SecondaryMsgCounter
	clc
	adc #$04			;add four to secondary message counter
	sta SecondaryMsgCounter
	lda PrimaryMsgCounter
	adc #$00			;add carry to primary message counter
	sta PrimaryMsgCounter
	cmp #$07			;check primary counter one more time
SetEndTimer:
	bcc ExitMsgs			;if not reached value yet, branch to leave
	lda #$06
	sta WorldEndTimer		;otherwise set world end timer
IncModeTask_A:
	inc OperMode_Task		;move onto next task in mode
ExitMsgs:	rts				;leave
