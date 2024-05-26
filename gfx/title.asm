
; Super Mario Bros. uses a special form of Run-Length Encoding for the title screen.
; It uses three bytes to define the position and length of each run, followed by the BG tile indices.
;
; Bytes 1 and 2: Tilemap address (start position of the run)
; Byte 3:
;   76543210
;   ||||||||
;   ||++++++- Length of the run (let's call it 'x')
;   |+------- Run mode (0: use next 'x' bytes, 1: repeat next byte 'x' times)
;   +-------- Direction (0: horizontal, 1: vertical)


; Title Box
	; Solid brown background (4 rows)
	.db $20, $a6, $54, $26
	.db $20, $c6, $54, $26
	.db $20, $e6, $54, $26
	.db $21, $06, $54, $26

	; Top-left Corner
	.db $20, $85, $01, $44

	; Top Border
	.db $20, $86, $54, $48

	; Top-right Corner
	.db $20, $9a, $01, $49

	; Left Border
	.db $20, $a5, $c9, $46

	; Right Border
	.db $20, $ba, $c9, $4a

; "SUPER"

	; First line
	.db $20, $a6, $0a
	.db $d0, $d1, $d8, $d8, $de, $d1, $d0, $da, $de, $d1

	; Second line
	.db $20, $c6, $0a
	.db $d2, $d3, $db, $db, $db, $d9, $db, $dc, $db, $df

	; Third line
	.db $20, $e6, $0a
	.db $d4, $d5, $d4, $d9, $db, $e2, $d4, $da, $db, $e0

	; Shadow
	.db $21, $06, $0a
	.db $d6, $d7, $d6, $d7, $e1, $26, $d6, $dd, $e1, $e1

; "MARIO BROS."

	; First line
	.db $21, $26, $14
	.db $d0, $e8, $d1, $d0, $d1, $de, $d1, $d8, $d0, $d1, $26, $de, $d1, $de, $d1, $d0, $d1, $d0, $d1, $26

	; Second line
	.db $21, $46, $14
	.db $db, $42, $42, $db, $42, $db, $42, $db, $db, $42, $26, $db, $42, $db, $42, $db, $42, $db, $42, $26

	.db $21, $66, $46
	.db $db, $21, $6c, $0e, $df, $db, $db, $db, $26, $db, $df, $db, $df, $db, $db, $e4, $e5, $26

	.db $21, $86, $14
	.db $db, $db, $db, $de, $43, $db, $e0, $db, $db, $db, $26, $db, $e3, $db, $e0, $db, $db, $e6, $e3, $26

	.db $21, $a6, $14
	.db $db, $db, $db, $db, $42, $db, $db, $db, $d4, $d9, $26, $db, $d9, $db, $db, $d4, $d9, $d4, $d9, $e7

	; Shadow/bottom border (includes bottom corners)
	.db $21, $c5, $16
	.db $5f, $95, $95, $95, $95, $95, $95, $95, $95, $97, $98, $78, $95, $96, $95, $95, $97, $98, $97, $98, $95, $7a

; "(c) 1985 NINTENDO"
	.db $21, $ed, $0e
	.db $cf, $01, $09, $08, $05, $24, $17, $12, $17, $1d, $0e, $17, $0d, $18

; "1 PLAYER GAME"
	.db $22, $4b, $0d
	.db $01, $24, $19, $15, $0a, $22, $0e, $1b, $24, $10, $0a, $16, $0e

; "2 PLAYER GAME"
	.db $22, $8b, $0d
	.db $02, $24, $19, $15, $0a, $22, $0e, $1b, $24, $10, $0a, $16, $0e

; "TOP-"
	.db $22, $ec, $04
	.db $1d, $18, $19, $28

; "0" (only the rightmost digit)
	.db $22, $f6, $01
	.db $00

; Attribute data
	.db $23, $c9, $56, $55
	.db $23, $e2, $04, $99, $aa, $aa, $aa
	.db $23, $ea, $04, $99, $aa, $aa, $aa

; Done
	.db $00

; Unused data
	.db $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff, $ff
