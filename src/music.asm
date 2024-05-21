
ContinueMusic:
	jmp HandleSquare2Music  ;if we have music, start with square 2 channel

MusicHandler:
	lda EventMusicQueue     ;check event music queue
	bne LoadEventMusic
	lda AreaMusicQueue	;check area music queue
	bne LoadAreaMusic
	lda EventMusicBuffer    ;check both buffers
	ora AreaMusicBuffer
	bne ContinueMusic 
	rts			;no music, then leave

LoadEventMusic:
	sta EventMusicBuffer	;copy event music queue contents to buffer
	cmp #DeathMusic	;is it death music?
	bne NoStopSfx		;if not, jump elsewhere
	jsr StopSquare1Sfx	;stop sfx in square 1 and 2
	jsr StopSquare2Sfx	;but clear only square 1's sfx buffer
NoStopSfx:
	ldx AreaMusicBuffer
	stx AreaMusicBuffer_Alt   ;save current area music buffer to be re-obtained later
	ldy #$00
	sty NoteLengthTblAdder    ;default value for additional length byte offset
	sty AreaMusicBuffer	;clear area music buffer
	cmp #TimeRunningOutMusic  ;is it time running out music?
	bne FindEventMusicHeader
	ldx #$08			;load offset to be added to length byte of header
	stx NoteLengthTblAdder
	bne FindEventMusicHeader  ;unconditional branch

LoadAreaMusic:
	cmp #$04			;is it underground music?
	bne NoStop1		;no, do not stop square 1 sfx
	jsr StopSquare1Sfx
NoStop1:
	ldy #$10			;start counter used only by ground level music
GMLoopB:
	sty GroundMusicHeaderOfs

HandleAreaMusicLoopB:
	ldy #$00			;clear event music buffer
	sty EventMusicBuffer
	sta AreaMusicBuffer	;copy area music queue contents to buffer
	cmp #$01			;is it ground level music?
	bne FindAreaMusicHeader
	inc GroundMusicHeaderOfs  ;increment but only if playing ground level music
	ldy GroundMusicHeaderOfs  ;is it time to loopback ground level music?
	cpy #$32
	bne LoadHeader		;branch ahead with alternate offset
	ldy #$11
	bne GMLoopB		;unconditional branch

FindAreaMusicHeader:
	ldy #$08			;load Y for offset of area music
	sty MusicOffset_Square2    ;residual instruction here

FindEventMusicHeader:
	iny			;increment Y pointer based on previously loaded queue contents
	lsr			;bit shift and increment until we find a set bit for music
	bcc FindEventMusicHeader

LoadHeader:
	lda MusicHeaderOffsetData,y  ;load offset for header
	tay
	lda MusicHeaderData,y	;now load the header
	sta NoteLenLookupTblOfs
	lda MusicHeaderData+1,y
	sta MusicDataLow
	lda MusicHeaderData+2,y
	sta MusicDataHigh
	lda MusicHeaderData+3,y
	sta MusicOffset_Triangle
	lda MusicHeaderData+4,y
	sta MusicOffset_Square1
	lda MusicHeaderData+5,y
	sta MusicOffset_Noise
	sta NoiseDataLoopbackOfs
	lda #$01			;initialize music note counters
	sta Squ2_NoteLenCounter
	sta Squ1_NoteLenCounter
	sta Tri_NoteLenCounter
	sta Noise_BeatLenCounter
	lda #$00			;initialize music data offset for square 2
	sta MusicOffset_Square2
	sta AltRegContentFlag	;initialize alternate control reg data used by square 1
	lda #$0b			;disable triangle channel and reenable it
	sta SND_MASTERCTRL_REG
	lda #$0f
	sta SND_MASTERCTRL_REG

HandleSquare2Music:
	dec Squ2_NoteLenCounter  ;decrement square 2 note length
	bne MiscSqu2MusicTasks   ;is it time for more data?  if not, branch to end tasks
	ldy MusicOffset_Square2  ;increment square 2 music offset and fetch data
	inc MusicOffset_Square2
	lda (MusicData),y
	beq EndOfMusicData	;if zero, the data is a null terminator
	bpl Squ2NoteHandler	;if non-negative, data is a note
	bne Squ2LengthHandler    ;otherwise it is length data

EndOfMusicData:
	lda EventMusicBuffer     ;check secondary buffer for time running out music
	cmp #TimeRunningOutMusic
	bne NotTRO
	lda AreaMusicBuffer_Alt  ;load previously saved contents of primary buffer
	bne MusicLoopBack	;and start playing the song again if there is one
NotTRO:
	and #VictoryMusic	;check for victory music (the only secondary that loops)
	bne VictoryMLoopBack
	lda AreaMusicBuffer	;check primary buffer for any music except pipe intro
	and #%01011111
	bne MusicLoopBack	;if any area music except pipe intro, music loops
	lda #$00		;clear primary and secondary buffers and initialize
	sta AreaMusicBuffer	;control regs of square and triangle channels
	sta EventMusicBuffer
	sta SND_TRIANGLE_REG
	lda #$90    
	sta SND_SQUARE1_REG
	sta SND_SQUARE2_REG
	rts

MusicLoopBack:
	jmp HandleAreaMusicLoopB

VictoryMLoopBack:
	jmp LoadEventMusic

Squ2LengthHandler:
	jsr ProcessLengthData    ;store length of note
	sta Squ2_NoteLenBuffer
	ldy MusicOffset_Square2  ;fetch another byte (MUST NOT BE LENGTH BYTE!)
	inc MusicOffset_Square2
	lda (MusicData),y

Squ2NoteHandler:
	ldx Square2SoundBuffer     ;is there a sound playing on this channel?
	bne SkipFqL1
	jsr SetFreq_Squ2	;no, then play the note
	beq Rest			;check to see if note is rest
	jsr LoadControlRegs	;if not, load control regs for square 2
Rest:
	sta Squ2_EnvelopeDataCtrl  ;save contents of A
	jsr Dump_Sq2_Regs	;dump X and Y into square 2 control regs
SkipFqL1:
	lda Squ2_NoteLenBuffer     ;save length in square 2 note counter
	sta Squ2_NoteLenCounter

MiscSqu2MusicTasks:
	lda Square2SoundBuffer     ;is there a sound playing on square 2?
	bne HandleSquare1Music
	lda EventMusicBuffer	;check for death music or d4 set on secondary buffer
	and #%10010001		;note that regs for death music or d4 are loaded by default
	bne HandleSquare1Music
	ldy Squ2_EnvelopeDataCtrl  ;check for contents saved from LoadControlRegs
	beq NoDecEnv1
	dec Squ2_EnvelopeDataCtrl  ;decrement unless already zero
NoDecEnv1:
	jsr LoadEnvelopeData	;do a load of envelope data to replace default
	sta SND_SQUARE2_REG	;based on offset set by first load unless playing
	ldx #$7f			;death music or d4 set on secondary buffer
	stx SND_SQUARE2_REG+1

HandleSquare1Music:
	ldy MusicOffset_Square1    ;is there a nonzero offset here?
	beq HandleTriangleMusic    ;if not, skip ahead to the triangle channel
	dec Squ1_NoteLenCounter    ;decrement square 1 note length
	bne MiscSqu1MusicTasks     ;is it time for more data?

FetchSqu1MusicData:
	ldy MusicOffset_Square1    ;increment square 1 music offset and fetch data
	inc MusicOffset_Square1
	lda (MusicData),y
	bne Squ1NoteHandler	;if nonzero, then skip this part
	lda #$83
	sta SND_SQUARE1_REG	;store some data into control regs for square 1
	lda #$94			;and fetch another byte of data, used to give
	sta SND_SQUARE1_REG+1	;death music its unique sound
	sta AltRegContentFlag
	bne FetchSqu1MusicData     ;unconditional branch

Squ1NoteHandler:
	jsr AlternateLengthHandler
	sta Squ1_NoteLenCounter    ;save contents of A in square 1 note counter
	ldy Square1SoundBuffer     ;is there a sound playing on square 1?
	bne HandleTriangleMusic
	txa
	and #%00111110		;change saved data to appropriate note format
	jsr SetFreq_Squ1	;play the note
	beq SkipCtrlL
	jsr LoadControlRegs
SkipCtrlL:
	sta Squ1_EnvelopeDataCtrl  ;save envelope offset
	jsr Dump_Squ1_Regs

MiscSqu1MusicTasks:
	lda Square1SoundBuffer     ;is there a sound playing on square 1?
	bne HandleTriangleMusic
	lda EventMusicBuffer	;check for death music or d4 set on secondary buffer
	and #%10010001
	bne DeathMAltReg
	ldy Squ1_EnvelopeDataCtrl  ;check saved envelope offset
	beq NoDecEnv2
	dec Squ1_EnvelopeDataCtrl  ;decrement unless already zero
NoDecEnv2:
	jsr LoadEnvelopeData	;do a load of envelope data
	sta SND_SQUARE1_REG	;based on offset set by first load
DeathMAltReg:
	lda AltRegContentFlag	;check for alternate control reg data
	bne DoAltLoad
	lda #$7f			;load this value if zero, the alternate value
DoAltLoad:
	sta SND_SQUARE1_REG+1	;if nonzero, and let's move on

HandleTriangleMusic:
	lda MusicOffset_Triangle
	dec Tri_NoteLenCounter    ;decrement triangle note length
	bne HandleNoiseMusic	;is it time for more data?
	ldy MusicOffset_Triangle  ;increment square 1 music offset and fetch data
	inc MusicOffset_Triangle
	lda (MusicData),y
	beq LoadTriCtrlReg	;if zero, skip all this and move on to noise 
	bpl TriNoteHandler	;if non-negative, data is note
	jsr ProcessLengthData     ;otherwise, it is length data
	sta Tri_NoteLenBuffer     ;save contents of A
	lda #$1f
	sta SND_TRIANGLE_REG	;load some default data for triangle control reg
	ldy MusicOffset_Triangle  ;fetch another byte
	inc MusicOffset_Triangle
	lda (MusicData),y
	beq LoadTriCtrlReg	;check once more for nonzero data

TriNoteHandler:
	jsr SetFreq_Tri
	ldx Tri_NoteLenBuffer   ;save length in triangle note counter
	stx Tri_NoteLenCounter
	lda EventMusicBuffer
	and #%01101110	;check for death music or d4 set on secondary buffer
	bne NotDOrD4		;if playing any other secondary, skip primary buffer check
	lda AreaMusicBuffer     ;check primary buffer for water or castle level music
	and #%00001010
	beq HandleNoiseMusic    ;if playing any other primary, or death or d4, go on to noise routine
NotDOrD4:
	txa			;if playing water or castle music or any secondary
	cmp #$12		;besides death music or d4 set, check length of note
	bcs LongN
	lda EventMusicBuffer    ;check for win castle music again if not playing a long note
	and #EndOfCastleMusic
	beq MediN
	lda #$0f		;load value $0f if playing the win castle music and playing a short
	bne LoadTriCtrlReg	;note, load value $1f if playing water or castle level music or any
MediN:
	lda #$1f		;secondary besides death and d4 except win castle or win castle and playing
	bne LoadTriCtrlReg	;a short note, and load value $ff if playing a long note on water, castle
LongN:
	lda #$ff		;or any secondary (including win castle) except death and d4

LoadTriCtrlReg:	
	sta SND_TRIANGLE_REG	;save final contents of A into control reg for triangle

HandleNoiseMusic:
	lda AreaMusicBuffer	;check if playing underground or castle music
	and #%11110011
	beq ExitMusicHandler	;if so, skip the noise routine
	dec Noise_BeatLenCounter  ;decrement noise beat length
	bne ExitMusicHandler	;is it time for more data?

FetchNoiseBeatData:
	ldy MusicOffset_Noise	;increment noise beat offset and fetch data
	inc MusicOffset_Noise
	lda (MusicData),y	;get noise beat data, if nonzero, branch to handle
	bne NoiseBeatHandler
	lda NoiseDataLoopbackOfs    ;if data is zero, reload original noise beat offset
	sta MusicOffset_Noise	;and loopback next time around
	bne FetchNoiseBeatData	;unconditional branch

NoiseBeatHandler:
	jsr AlternateLengthHandler
	sta Noise_BeatLenCounter    ;store length in noise beat counter
	txa
	and #%00111110		;reload data and erase length bits
	beq SilentBeat		;if no beat data, silence
	cmp #$30			;check the beat data and play the appropriate
	beq LongBeat		;noise accordingly
	cmp #$20
	beq StrongBeat
	and #%00010000  
	beq SilentBeat
	lda #$1c	;short beat data
	ldx #$03
	ldy #$18
	bne PlayBeat

StrongBeat:
	lda #$1c	;strong beat data
	ldx #$0c
	ldy #$18
	bne PlayBeat

LongBeat:
	lda #$1c	;long beat data
	ldx #$03
	ldy #$58
	bne PlayBeat

SilentBeat:
	lda #$10	;silence

PlayBeat:
	sta SND_NOISE_REG    ;load beat data into noise regs
	stx SND_NOISE_REG+2
	sty SND_NOISE_REG+3

ExitMusicHandler:
	rts

AlternateLengthHandler:
	tax		;save a copy of original byte into X
	ror		;save LSB from original byte into carry
	txa		;reload original byte and rotate three times
	rol		;turning xx00000x into 00000xxx, with the
	rol		;bit in carry as the MSB here
	rol

ProcessLengthData:
	and #%00000111		;clear all but the three LSBs
	clc
	adc $f0			;add offset loaded from first header byte
	adc NoteLengthTblAdder	;add extra if time running out music
	tay
	lda MusicLengthLookupTbl,y  ;load length
	rts

LoadControlRegs:
	lda EventMusicBuffer  ;check secondary buffer for win castle music
	and #EndOfCastleMusic
	beq NotECstlM
	lda #$04		;this value is only used for win castle music
	bne AllMus		;unconditional branch
NotECstlM:
	lda AreaMusicBuffer
	and #%01111101	;check primary buffer for water music
	beq WaterMus
	lda #$08		;this is the default value for all other music
	bne AllMus
WaterMus:
	lda #$28		;this value is used for water music and all other event music
AllMus:
	ldx #$82		;load contents of other sound regs for square 2
	ldy #$7f
	rts

LoadEnvelopeData:
	lda EventMusicBuffer	;check secondary buffer for win castle music
	and #EndOfCastleMusic
	beq LoadUsualEnvData
	lda EndOfCastleMusicEnvData,y  ;load data from offset for win castle music
	rts

LoadUsualEnvData:
	lda AreaMusicBuffer		;check primary buffer for water music
	and #%01111101
	beq LoadWaterEventMusEnvData
	lda AreaMusicEnvData,y	;load default data from offset for all other music
	rts

LoadWaterEventMusEnvData:
	lda WaterEventMusEnvData,y     ;load data from offset for water music and all other event music
	rts

