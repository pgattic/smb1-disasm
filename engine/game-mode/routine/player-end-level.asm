
Hidden1UpCoinAmts:
	.db $15, $23, $16, $1b, $17, $18, $23, $63

PlayerEndLevel:
	lda #$01			;force player to walk to the right
	jsr AutoControlPlayer
	lda Player_Y_Position     ;check player's vertical position
	cmp #$ae
	bcc ChkStop		;if player is not yet off the flagpole, skip this part
	lda ScrollLock		;if scroll lock not set, branch ahead to next part
	beq ChkStop		;because we only need to do this part once
	lda #EndOfLevelMusic
	sta EventMusicQueue	;load win level music in event music queue
	lda #$00
	sta ScrollLock		;turn off scroll lock to skip this part later
ChkStop:
	lda Player_CollisionBits  ;get player collision bits
	lsr			;check for d0 set
	bcs RdyNextA		;if d0 set, skip to next part
	lda StarFlagTaskControl   ;if star flag task control already set,
	bne InCastle		;go ahead with the rest of the code
	inc StarFlagTaskControl   ;otherwise set task control now (this gets ball rolling!)
InCastle:
	lda #%00100000		;set player's background priority bit to
	sta Player_SprAttrib	;give illusion of being inside the castle
RdyNextA:
	lda StarFlagTaskControl
	cmp #$05			;if star flag task control not yet set
	bne ExitNA		;beyond last valid task number, branch to leave
	inc LevelNumber	;increment level number used for game logic
	lda LevelNumber
	cmp #$03			;check to see if we have yet reached level -4
	bne NextArea		;and skip this last part here if not
	ldy WorldNumber	;get world number as offset
	lda CoinTallyFor1Ups	;check third area coin tally for bonus 1-ups
	cmp Hidden1UpCoinAmts,y   ;against minimum value, if player has not collected
	bcc NextArea		;at least this number of coins, leave flag clear
	inc Hidden1UpFlag	;otherwise set hidden 1-up box control flag
NextArea:
	inc AreaNumber		;increment area number used for address loader
	jsr LoadAreaPointer	;get new level pointer
	inc FetchNewGameTimerFlag ;set flag to load new game timer
	jsr ChgAreaMode	;do sub to set secondary mode, disable screen and sprite 0
	sta HalfwayPage	;reset halfway page to 0 (beginning)
	lda #Silence
	sta EventMusicQueue	;silence music and leave
ExitNA:
	rts
