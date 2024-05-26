
InitScreen:
	jsr MoveAllSpritesOffscreen ;initialize all sprites including sprite #0
	jsr InitializeNameTables    ;and erase both name and attribute tables
	lda OperMode
	beq NextSubtask		;if mode still 0, do not load
	ldx #$03			;into buffer pointer
	jmp SetVRAMAddr_A
