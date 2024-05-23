
;$04 - address low to jump address
;$05 - address high to jump address
;$06 - jump address low
;$07 - jump address high

JumpEngine:
	asl	;shift bit from contents of A
	tay
	pla	;pull saved return address from stack
	sta $04	;save to indirect
	pla
	sta $05
	iny
	lda ($04),y  ;load pointer from indirect
	sta $06	;note that if an RTS is performed in next routine
	iny	;it will return to the execution before the sub
	lda ($04),y  ;that called this routine
	sta $07
	jmp ($06)    ;jump to the address we loaded
