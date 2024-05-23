
;-------------------------------------------------------------------------------------
;GAME LEVELS DATA

WorldAddrOffsets:
	.db World1Areas-AreaAddrOffsets, World2Areas-AreaAddrOffsets
	.db World3Areas-AreaAddrOffsets, World4Areas-AreaAddrOffsets
	.db World5Areas-AreaAddrOffsets, World6Areas-AreaAddrOffsets
	.db World7Areas-AreaAddrOffsets, World8Areas-AreaAddrOffsets

AreaAddrOffsets:
World1Areas:
	.db $25, $29, $c0, $26, $60
World2Areas:
	.db $28, $29, $01, $27, $62
World3Areas:
	.db $24, $35, $20, $63
World4Areas:
	.db $22, $29, $41, $2c, $61
World5Areas:
	.db $2a, $31, $26, $62
World6Areas:
	.db $2e, $23, $2d, $60
World7Areas:
	.db $33, $29, $01, $27, $64
World8Areas:
	.db $30, $32, $21, $65

;bonus area data offsets, included here for comparison purposes
;underground bonus area  - c2
;cloud area 1 (day)	- 2b
;cloud area 2 (night)    - 34
;water area (5-2/6-2)    - 00
;water area (8-4)	- 02
;warp zone area (4-2)    - 2f

EnemyAddrHOffsets:
	.db $1f, $06, $1c, $00

EnemyDataAddrLow:
	.db <E_CastleArea1, <E_CastleArea2, <E_CastleArea3, <E_CastleArea4, <E_CastleArea5, <E_CastleArea6
	.db <E_GroundArea1, <E_GroundArea2, <E_GroundArea3, <E_GroundArea4, <E_GroundArea5, <E_GroundArea6
	.db <E_GroundArea7, <E_GroundArea8, <E_GroundArea9, <E_GroundArea10, <E_GroundArea11, <E_GroundArea12
	.db <E_GroundArea13, <E_GroundArea14, <E_GroundArea15, <E_GroundArea16, <E_GroundArea17, <E_GroundArea18
	.db <E_GroundArea19, <E_GroundArea20, <E_GroundArea21, <E_GroundArea22, <E_UndergroundArea1
	.db <E_UndergroundArea2, <E_UndergroundArea3, <E_WaterArea1, <E_WaterArea2, <E_WaterArea3

EnemyDataAddrHigh:
	.db >E_CastleArea1, >E_CastleArea2, >E_CastleArea3, >E_CastleArea4, >E_CastleArea5, >E_CastleArea6
	.db >E_GroundArea1, >E_GroundArea2, >E_GroundArea3, >E_GroundArea4, >E_GroundArea5, >E_GroundArea6
	.db >E_GroundArea7, >E_GroundArea8, >E_GroundArea9, >E_GroundArea10, >E_GroundArea11, >E_GroundArea12
	.db >E_GroundArea13, >E_GroundArea14, >E_GroundArea15, >E_GroundArea16, >E_GroundArea17, >E_GroundArea18
	.db >E_GroundArea19, >E_GroundArea20, >E_GroundArea21, >E_GroundArea22, >E_UndergroundArea1
	.db >E_UndergroundArea2, >E_UndergroundArea3, >E_WaterArea1, >E_WaterArea2, >E_WaterArea3

AreaDataHOffsets:
	.db $00, $03, $19, $1c

AreaDataAddrLow:
	.db <L_WaterArea1, <L_WaterArea2, <L_WaterArea3, <L_GroundArea1, <L_GroundArea2, <L_GroundArea3
	.db <L_GroundArea4, <L_GroundArea5, <L_GroundArea6, <L_GroundArea7, <L_GroundArea8, <L_GroundArea9
	.db <L_GroundArea10, <L_GroundArea11, <L_GroundArea12, <L_GroundArea13, <L_GroundArea14, <L_GroundArea15
	.db <L_GroundArea16, <L_GroundArea17, <L_GroundArea18, <L_GroundArea19, <L_GroundArea20, <L_GroundArea21
	.db <L_GroundArea22, <L_UndergroundArea1, <L_UndergroundArea2, <L_UndergroundArea3, <L_CastleArea1
	.db <L_CastleArea2, <L_CastleArea3, <L_CastleArea4, <L_CastleArea5, <L_CastleArea6

AreaDataAddrHigh:
	.db >L_WaterArea1, >L_WaterArea2, >L_WaterArea3, >L_GroundArea1, >L_GroundArea2, >L_GroundArea3
	.db >L_GroundArea4, >L_GroundArea5, >L_GroundArea6, >L_GroundArea7, >L_GroundArea8, >L_GroundArea9
	.db >L_GroundArea10, >L_GroundArea11, >L_GroundArea12, >L_GroundArea13, >L_GroundArea14, >L_GroundArea15
	.db >L_GroundArea16, >L_GroundArea17, >L_GroundArea18, >L_GroundArea19, >L_GroundArea20, >L_GroundArea21
	.db >L_GroundArea22, >L_UndergroundArea1, >L_UndergroundArea2, >L_UndergroundArea3, >L_CastleArea1
	.db >L_CastleArea2, >L_CastleArea3, >L_CastleArea4, >L_CastleArea5, >L_CastleArea6

;ENEMY OBJECT DATA

;level 1-4/6-4
E_CastleArea1:
	.db $76, $dd, $bb, $4c, $ea, $1d, $1b, $cc, $56, $5d
	.db $16, $9d, $c6, $1d, $36, $9d, $c9, $1d, $04, $db
	.db $49, $1d, $84, $1b, $c9, $5d, $88, $95, $0f, $08
	.db $30, $4c, $78, $2d, $a6, $28, $90, $b5
	.db $ff

;level 4-4
E_CastleArea2:
	.db $0f, $03, $56, $1b, $c9, $1b, $0f, $07, $36, $1b
	.db $aa, $1b, $48, $95, $0f, $0a, $2a, $1b, $5b, $0c
	.db $78, $2d, $90, $b5
	.db $ff

;level 2-4/5-4
E_CastleArea3:
	.db $0b, $8c, $4b, $4c, $77, $5f, $eb, $0c, $bd, $db
	.db $19, $9d, $75, $1d, $7d, $5b, $d9, $1d, $3d, $dd
	.db $99, $1d, $26, $9d, $5a, $2b, $8a, $2c, $ca, $1b
	.db $20, $95, $7b, $5c, $db, $4c, $1b, $cc, $3b, $cc
	.db $78, $2d, $a6, $28, $90, $b5
	.db $ff

;level 3-4
E_CastleArea4:
	.db $0b, $8c, $3b, $1d, $8b, $1d, $ab, $0c, $db, $1d
	.db $0f, $03, $65, $1d, $6b, $1b, $05, $9d, $0b, $1b
	.db $05, $9b, $0b, $1d, $8b, $0c, $1b, $8c, $70, $15
	.db $7b, $0c, $db, $0c, $0f, $08, $78, $2d, $a6, $28
	.db $90, $b5
	.db $ff

;level 7-4
E_CastleArea5:
	.db $27, $a9, $4b, $0c, $68, $29, $0f, $06, $77, $1b
	.db $0f, $0b, $60, $15, $4b, $8c, $78, $2d, $90, $b5
	.db $ff

;level 8-4
E_CastleArea6:
	.db $0f, $03, $8e, $65, $e1, $bb, $38, $6d, $a8, $3e, $e5, $e7
	.db $0f, $08, $0b, $02, $2b, $02, $5e, $65, $e1, $bb, $0e
	.db $db, $0e, $bb, $8e, $db, $0e, $fe, $65, $ec, $0f, $0d
	.db $4e, $65, $e1, $0f, $0e, $4e, $02, $e0, $0f, $10, $fe, $e5, $e1
	.db $1b, $85, $7b, $0c, $5b, $95, $78, $2d, $90, $b5
	.db $ff

;level 3-3
E_GroundArea1:
	.db $a5, $86, $e4, $28, $18, $a8, $45, $83, $69, $03
	.db $c6, $29, $9b, $83, $16, $a4, $88, $24, $e9, $28
	.db $05, $a8, $7b, $28, $24, $8f, $c8, $03, $e8, $03
	.db $46, $a8, $85, $24, $c8, $24
	.db $ff

;level 8-3
E_GroundArea2:
	.db $eb, $8e, $0f, $03, $fb, $05, $17, $85, $db, $8e
	.db $0f, $07, $57, $05, $7b, $05, $9b, $80, $2b, $85
	.db $fb, $05, $0f, $0b, $1b, $05, $9b, $05
	.db $ff

;level 4-1
E_GroundArea3:
	.db $2e, $c2, $66, $e2, $11, $0f, $07, $02, $11, $0f, $0c
	.db $12, $11
	.db $ff

;level 6-2
E_GroundArea4:
	.db $0e, $c2, $a8, $ab, $00, $bb, $8e, $6b, $82, $de, $00, $a0
	.db $33, $86, $43, $06, $3e, $b4, $a0, $cb, $02, $0f, $07
	.db $7e, $42, $a6, $83, $02, $0f, $0a, $3b, $02, $cb, $37
	.db $0f, $0c, $e3, $0e
	.db $ff

;level 3-1
E_GroundArea5:
	.db $9b, $8e, $ca, $0e, $ee, $42, $44, $5b, $86, $80, $b8
	.db $1b, $80, $50, $ba, $10, $b7, $5b, $00, $17, $85
	.db $4b, $05, $fe, $34, $40, $b7, $86, $c6, $06, $5b, $80
	.db $83, $00, $d0, $38, $5b, $8e, $8a, $0e, $a6, $00
	.db $bb, $0e, $c5, $80, $f3, $00
	.db $ff

;level 1-1
E_GroundArea6:
	.db $1e, $c2, $00, $6b, $06, $8b, $86, $63, $b7, $0f, $05
	.db $03, $06, $23, $06, $4b, $b7, $bb, $00, $5b, $b7
	.db $fb, $37, $3b, $b7, $0f, $0b, $1b, $37
	.db $ff

;level 1-3/5-3
E_GroundArea7:
	.db $2b, $d7, $e3, $03, $c2, $86, $e2, $06, $76, $a5
	.db $a3, $8f, $03, $86, $2b, $57, $68, $28, $e9, $28
	.db $e5, $83, $24, $8f, $36, $a8, $5b, $03
	.db $ff

;level 2-3/7-3
E_GroundArea8:
	.db $0f, $02, $78, $40, $48, $ce, $f8, $c3, $f8, $c3
	.db $0f, $07, $7b, $43, $c6, $d0, $0f, $8a, $c8, $50
	.db $ff

;level 2-1
E_GroundArea9:
	.db $85, $86, $0b, $80, $1b, $00, $db, $37, $77, $80
	.db $eb, $37, $fe, $2b, $20, $2b, $80, $7b, $38, $ab, $b8
	.db $77, $86, $fe, $42, $20, $49, $86, $8b, $06, $9b, $80
	.db $7b, $8e, $5b, $b7, $9b, $0e, $bb, $0e, $9b, $80
;end of data terminator here is also used by pipe intro area
E_GroundArea10:
	.db $ff

;level 5-1
E_GroundArea11:
	.db $0b, $80, $60, $38, $10, $b8, $c0, $3b, $db, $8e
	.db $40, $b8, $f0, $38, $7b, $8e, $a0, $b8, $c0, $b8
	.db $fb, $00, $a0, $b8, $30, $bb, $ee, $42, $88, $0f, $0b
	.db $2b, $0e, $67, $0e
	.db $ff

;cloud level used in levels 2-1 and 5-2
E_GroundArea12:
	.db $0a, $aa, $0e, $28, $2a, $0e, $31, $88
	.db $ff

;level 4-3
E_GroundArea13:
	.db $c7, $83, $d7, $03, $42, $8f, $7a, $03, $05, $a4
	.db $78, $24, $a6, $25, $e4, $25, $4b, $83, $e3, $03
	.db $05, $a4, $89, $24, $b5, $24, $09, $a4, $65, $24
	.db $c9, $24, $0f, $08, $85, $25
	.db $ff

;level 6-3
E_GroundArea14:
	.db $cd, $a5, $b5, $a8, $07, $a8, $76, $28, $cc, $25
	.db $65, $a4, $a9, $24, $e5, $24, $19, $a4, $0f, $07
	.db $95, $28, $e6, $24, $19, $a4, $d7, $29, $16, $a9
	.db $58, $29, $97, $29
	.db $ff

;level 6-1
E_GroundArea15:
	.db $0f, $02, $02, $11, $0f, $07, $02, $11
	.db $ff

;warp zone area used in level 4-2
E_GroundArea16:
	.db $ff

;level 8-1
E_GroundArea17:
	.db $2b, $82, $ab, $38, $de, $42, $e2, $1b, $b8, $eb
	.db $3b, $db, $80, $8b, $b8, $1b, $82, $fb, $b8, $7b
	.db $80, $fb, $3c, $5b, $bc, $7b, $b8, $1b, $8e, $cb
	.db $0e, $1b, $8e, $0f, $0d, $2b, $3b, $bb, $b8, $eb, $82
	.db $4b, $b8, $bb, $38, $3b, $b7, $bb, $02, $0f, $13
	.db $1b, $00, $cb, $80, $6b, $bc
	.db $ff

;level 5-2
E_GroundArea18:
	.db $7b, $80, $ae, $00, $80, $8b, $8e, $e8, $05, $f9, $86 
	.db $17, $86, $16, $85, $4e, $2b, $80, $ab, $8e, $87, $85
	.db $c3, $05, $8b, $82, $9b, $02, $ab, $02, $bb, $86
	.db $cb, $06, $d3, $03, $3b, $8e, $6b, $0e, $a7, $8e
	.db $ff

;level 8-2
E_GroundArea19:
	.db $29, $8e, $52, $11, $83, $0e, $0f, $03, $9b, $0e
	.db $2b, $8e, $5b, $0e, $cb, $8e, $fb, $0e, $fb, $82
	.db $9b, $82, $bb, $02, $fe, $42, $e8, $bb, $8e, $0f, $0a
	.db $ab, $0e, $cb, $0e, $f9, $0e, $88, $86, $a6, $06
	.db $db, $02, $b6, $8e
	.db $ff

;level 7-1
E_GroundArea20:
	.db $ab, $ce, $de, $42, $c0, $cb, $ce, $5b, $8e, $1b, $ce
	.db $4b, $85, $67, $45, $0f, $07, $2b, $00, $7b, $85
	.db $97, $05, $0f, $0a, $92, $02
	.db $ff

;cloud level used in levels 3-1 and 6-2
E_GroundArea21:
	.db $0a, $aa, $0e, $24, $4a, $1e, $23, $aa
	.db $ff

;level 3-2
E_GroundArea22:
	.db $1b, $80, $bb, $38, $4b, $bc, $eb, $3b, $0f, $04
	.db $2b, $00, $ab, $38, $eb, $00, $cb, $8e, $fb, $80
	.db $ab, $b8, $6b, $80, $fb, $3c, $9b, $bb, $5b, $bc
	.db $fb, $00, $6b, $b8, $fb, $38
	.db $ff

;level 1-2
E_UndergroundArea1:
	.db $0b, $86, $1a, $06, $db, $06, $de, $c2, $02, $f0, $3b
	.db $bb, $80, $eb, $06, $0b, $86, $93, $06, $f0, $39
	.db $0f, $06, $60, $b8, $1b, $86, $a0, $b9, $b7, $27
	.db $bd, $27, $2b, $83, $a1, $26, $a9, $26, $ee, $25, $0b
	.db $27, $b4
	.db $ff

;level 4-2
E_UndergroundArea2:
	.db $0f, $02, $1e, $2f, $60, $e0, $3a, $a5, $a7, $db, $80
	.db $3b, $82, $8b, $02, $fe, $42, $68, $70, $bb, $25, $a7
	.db $2c, $27, $b2, $26, $b9, $26, $9b, $80, $a8, $82
	.db $b5, $27, $bc, $27, $b0, $bb, $3b, $82, $87, $34
	.db $ee, $25, $6b
	.db $ff

;underground bonus rooms area used in many levels
E_UndergroundArea3:
	.db $1e, $a5, $0a, $2e, $28, $27, $2e, $33, $c7, $0f, $03, $1e, $40, $07
	.db $2e, $30, $e7, $0f, $05, $1e, $24, $44, $0f, $07, $1e, $22, $6a
	.db $2e, $23, $ab, $0f, $09, $1e, $41, $68, $1e, $2a, $8a, $2e, $23, $a2
	.db $2e, $32, $ea
	.db $ff

;water area used in levels 5-2 and 6-2
E_WaterArea1:
	.db $3b, $87, $66, $27, $cc, $27, $ee, $31, $87, $ee, $23, $a7
	.db $3b, $87, $db, $07
	.db $ff

;level 2-2/7-2
E_WaterArea2:
	.db $0f, $01, $2e, $25, $2b, $2e, $25, $4b, $4e, $25, $cb, $6b, $07
	.db $97, $47, $e9, $87, $47, $c7, $7a, $07, $d6, $c7
	.db $78, $07, $38, $87, $ab, $47, $e3, $07, $9b, $87
	.db $0f, $09, $68, $47, $db, $c7, $3b, $c7
	.db $ff

;water area used in level 8-4
E_WaterArea3:
	.db $47, $9b, $cb, $07, $fa, $1d, $86, $9b, $3a, $87
	.db $56, $07, $88, $1b, $07, $9d, $2e, $65, $f0
	.db $ff

;AREA OBJECT DATA

;level 1-4/6-4
L_CastleArea1:
	.db $9b, $07
	.db $05, $32, $06, $33, $07, $34, $ce, $03, $dc, $51
	.db $ee, $07, $73, $e0, $74, $0a, $7e, $06, $9e, $0a
	.db $ce, $06, $e4, $00, $e8, $0a, $fe, $0a, $2e, $89
	.db $4e, $0b, $54, $0a, $14, $8a, $c4, $0a, $34, $8a
	.db $7e, $06, $c7, $0a, $01, $e0, $02, $0a, $47, $0a
	.db $81, $60, $82, $0a, $c7, $0a, $0e, $87, $7e, $02
	.db $a7, $02, $b3, $02, $d7, $02, $e3, $02, $07, $82
	.db $13, $02, $3e, $06, $7e, $02, $ae, $07, $fe, $0a
	.db $0d, $c4, $cd, $43, $ce, $09, $de, $0b, $dd, $42
	.db $fe, $02, $5d, $c7
	.db $fd

;level 4-4
L_CastleArea2:
	.db $5b, $07
	.db $05, $32, $06, $33, $07, $34, $5e, $0a, $68, $64
	.db $98, $64, $a8, $64, $ce, $06, $fe, $02, $0d, $01
	.db $1e, $0e, $7e, $02, $94, $63, $b4, $63, $d4, $63
	.db $f4, $63, $14, $e3, $2e, $0e, $5e, $02, $64, $35
	.db $88, $72, $be, $0e, $0d, $04, $ae, $02, $ce, $08
	.db $cd, $4b, $fe, $02, $0d, $05, $68, $31, $7e, $0a
	.db $96, $31, $a9, $63, $a8, $33, $d5, $30, $ee, $02
	.db $e6, $62, $f4, $61, $04, $b1, $08, $3f, $44, $33
	.db $94, $63, $a4, $31, $e4, $31, $04, $bf, $08, $3f
	.db $04, $bf, $08, $3f, $cd, $4b, $03, $e4, $0e, $03
	.db $2e, $01, $7e, $06, $be, $02, $de, $06, $fe, $0a
	.db $0d, $c4, $cd, $43, $ce, $09, $de, $0b, $dd, $42
	.db $fe, $02, $5d, $c7
	.db $fd

;level 2-4/5-4
L_CastleArea3:
	.db $9b, $07
	.db $05, $32, $06, $33, $07, $34, $fe, $00, $27, $b1
	.db $65, $32, $75, $0a, $71, $00, $b7, $31, $08, $e4
	.db $18, $64, $1e, $04, $57, $3b, $bb, $0a, $17, $8a
	.db $27, $3a, $73, $0a, $7b, $0a, $d7, $0a, $e7, $3a
	.db $3b, $8a, $97, $0a, $fe, $08, $24, $8a, $2e, $00
	.db $3e, $40, $38, $64, $6f, $00, $9f, $00, $be, $43
	.db $c8, $0a, $c9, $63, $ce, $07, $fe, $07, $2e, $81
	.db $66, $42, $6a, $42, $79, $0a, $be, $00, $c8, $64
	.db $f8, $64, $08, $e4, $2e, $07, $7e, $03, $9e, $07
	.db $be, $03, $de, $07, $fe, $0a, $03, $a5, $0d, $44
	.db $cd, $43, $ce, $09, $dd, $42, $de, $0b, $fe, $02
	.db $5d, $c7
	.db $fd

;level 3-4
L_CastleArea4:
	.db $9b, $07
	.db $05, $32, $06, $33, $07, $34, $fe, $06, $0c, $81
	.db $39, $0a, $5c, $01, $89, $0a, $ac, $01, $d9, $0a
	.db $fc, $01, $2e, $83, $a7, $01, $b7, $00, $c7, $01
	.db $de, $0a, $fe, $02, $4e, $83, $5a, $32, $63, $0a
	.db $69, $0a, $7e, $02, $ee, $03, $fa, $32, $03, $8a
	.db $09, $0a, $1e, $02, $ee, $03, $fa, $32, $03, $8a
	.db $09, $0a, $14, $42, $1e, $02, $7e, $0a, $9e, $07
	.db $fe, $0a, $2e, $86, $5e, $0a, $8e, $06, $be, $0a
	.db $ee, $07, $3e, $83, $5e, $07, $fe, $0a, $0d, $c4
	.db $41, $52, $51, $52, $cd, $43, $ce, $09, $de, $0b
	.db $dd, $42, $fe, $02, $5d, $c7
	.db $fd

;level 7-4
L_CastleArea5:
	.db $5b, $07
	.db $05, $32, $06, $33, $07, $34, $fe, $0a, $ae, $86
	.db $be, $07, $fe, $02, $0d, $02, $27, $32, $46, $61
	.db $55, $62, $5e, $0e, $1e, $82, $68, $3c, $74, $3a
	.db $7d, $4b, $5e, $8e, $7d, $4b, $7e, $82, $84, $62
	.db $94, $61, $a4, $31, $bd, $4b, $ce, $06, $fe, $02
	.db $0d, $06, $34, $31, $3e, $0a, $64, $32, $75, $0a
	.db $7b, $61, $a4, $33, $ae, $02, $de, $0e, $3e, $82
	.db $64, $32, $78, $32, $b4, $36, $c8, $36, $dd, $4b
	.db $44, $b2, $58, $32, $94, $63, $a4, $3e, $ba, $30
	.db $c9, $61, $ce, $06, $dd, $4b, $ce, $86, $dd, $4b
	.db $fe, $02, $2e, $86, $5e, $02, $7e, $06, $fe, $02
	.db $1e, $86, $3e, $02, $5e, $06, $7e, $02, $9e, $06
	.db $fe, $0a, $0d, $c4, $cd, $43, $ce, $09, $de, $0b
	.db $dd, $42, $fe, $02, $5d, $c7
	.db $fd

;level 8-4
L_CastleArea6:
	.db $5b, $06
	.db $05, $32, $06, $33, $07, $34, $5e, $0a, $ae, $02
	.db $0d, $01, $39, $73, $0d, $03, $39, $7b, $4d, $4b
	.db $de, $06, $1e, $8a, $ae, $06, $c4, $33, $16, $fe
	.db $a5, $77, $fe, $02, $fe, $82, $0d, $07, $39, $73
	.db $a8, $74, $ed, $4b, $49, $fb, $e8, $74, $fe, $0a
	.db $2e, $82, $67, $02, $84, $7a, $87, $31, $0d, $0b
	.db $fe, $02, $0d, $0c, $39, $73, $5e, $06, $c6, $76
	.db $45, $ff, $be, $0a, $dd, $48, $fe, $06, $3d, $cb
	.db $46, $7e, $ad, $4a, $fe, $82, $39, $f3, $a9, $7b
	.db $4e, $8a, $9e, $07, $fe, $0a, $0d, $c4, $cd, $43
	.db $ce, $09, $de, $0b, $dd, $42, $fe, $02, $5d, $c7
	.db $fd

;level 3-3
L_GroundArea1:
	.db $94, $11
	.db $0f, $26, $fe, $10, $28, $94, $65, $15, $eb, $12
	.db $fa, $41, $4a, $96, $54, $40, $a4, $42, $b7, $13
	.db $e9, $19, $f5, $15, $11, $80, $47, $42, $71, $13
	.db $80, $41, $15, $92, $1b, $1f, $24, $40, $55, $12
	.db $64, $40, $95, $12, $a4, $40, $d2, $12, $e1, $40
	.db $13, $c0, $2c, $17, $2f, $12, $49, $13, $83, $40
	.db $9f, $14, $a3, $40, $17, $92, $83, $13, $92, $41
	.db $b9, $14, $c5, $12, $c8, $40, $d4, $40, $4b, $92
	.db $78, $1b, $9c, $94, $9f, $11, $df, $14, $fe, $11
	.db $7d, $c1, $9e, $42, $cf, $20
	.db $fd

;level 8-3
L_GroundArea2:
	.db $90, $b1
	.db $0f, $26, $29, $91, $7e, $42, $fe, $40, $28, $92
	.db $4e, $42, $2e, $c0, $57, $73, $c3, $25, $c7, $27
	.db $23, $84, $33, $20, $5c, $01, $77, $63, $88, $62
	.db $99, $61, $aa, $60, $bc, $01, $ee, $42, $4e, $c0
	.db $69, $11, $7e, $42, $de, $40, $f8, $62, $0e, $c2
	.db $ae, $40, $d7, $63, $e7, $63, $33, $a7, $37, $27
	.db $43, $04, $cc, $01, $e7, $73, $0c, $81, $3e, $42
	.db $0d, $0a, $5e, $40, $88, $72, $be, $42, $e7, $87
	.db $fe, $40, $39, $e1, $4e, $00, $69, $60, $87, $60
	.db $a5, $60, $c3, $31, $fe, $31, $6d, $c1, $be, $42
	.db $ef, $20
	.db $fd

;level 4-1
L_GroundArea3:
	.db $52, $21
	.db $0f, $20, $6e, $40, $58, $f2, $93, $01, $97, $00
	.db $0c, $81, $97, $40, $a6, $41, $c7, $40, $0d, $04
	.db $03, $01, $07, $01, $23, $01, $27, $01, $ec, $03
	.db $ac, $f3, $c3, $03, $78, $e2, $94, $43, $47, $f3
	.db $74, $43, $47, $fb, $74, $43, $2c, $f1, $4c, $63
	.db $47, $00, $57, $21, $5c, $01, $7c, $72, $39, $f1
	.db $ec, $02, $4c, $81, $d8, $62, $ec, $01, $0d, $0d
	.db $0f, $38, $c7, $07, $ed, $4a, $1d, $c1, $5f, $26
	.db $fd

;level 6-2
L_GroundArea4:
	.db $54, $21
	.db $0f, $26, $a7, $22, $37, $fb, $73, $20, $83, $07
	.db $87, $02, $93, $20, $c7, $73, $04, $f1, $06, $31
	.db $39, $71, $59, $71, $e7, $73, $37, $a0, $47, $04
	.db $86, $7c, $e5, $71, $e7, $31, $33, $a4, $39, $71
	.db $a9, $71, $d3, $23, $08, $f2, $13, $05, $27, $02
	.db $49, $71, $75, $75, $e8, $72, $67, $f3, $99, $71
	.db $e7, $20, $f4, $72, $f7, $31, $17, $a0, $33, $20
	.db $39, $71, $73, $28, $bc, $05, $39, $f1, $79, $71
	.db $a6, $21, $c3, $06, $d3, $20, $dc, $00, $fc, $00
	.db $07, $a2, $13, $21, $5f, $32, $8c, $00, $98, $7a
	.db $c7, $63, $d9, $61, $03, $a2, $07, $22, $74, $72
	.db $77, $31, $e7, $73, $39, $f1, $58, $72, $77, $73
	.db $d8, $72, $7f, $b1, $97, $73, $b6, $64, $c5, $65
	.db $d4, $66, $e3, $67, $f3, $67, $8d, $c1, $cf, $26
	.db $fd

;level 3-1
L_GroundArea5:
	.db $52, $31
	.db $0f, $20, $6e, $66, $07, $81, $36, $01, $66, $00
	.db $a7, $22, $08, $f2, $67, $7b, $dc, $02, $98, $f2
	.db $d7, $20, $39, $f1, $9f, $33, $dc, $27, $dc, $57
	.db $23, $83, $57, $63, $6c, $51, $87, $63, $99, $61
	.db $a3, $06, $b3, $21, $77, $f3, $f3, $21, $f7, $2a
	.db $13, $81, $23, $22, $53, $00, $63, $22, $e9, $0b
	.db $0c, $83, $13, $21, $16, $22, $33, $05, $8f, $35
	.db $ec, $01, $63, $a0, $67, $20, $73, $01, $77, $01
	.db $83, $20, $87, $20, $b3, $20, $b7, $20, $c3, $01
	.db $c7, $00, $d3, $20, $d7, $20, $67, $a0, $77, $07
	.db $87, $22, $e8, $62, $f5, $65, $1c, $82, $7f, $38
	.db $8d, $c1, $cf, $26
	.db $fd

;level 1-1
L_GroundArea6:
	.db $50, $21
	.db $07, $81, $47, $24, $57, $00, $63, $01, $77, $01
	.db $c9, $71, $68, $f2, $e7, $73, $97, $fb, $06, $83
	.db $5c, $01, $d7, $22, $e7, $00, $03, $a7, $6c, $02
	.db $b3, $22, $e3, $01, $e7, $07, $47, $a0, $57, $06
	.db $a7, $01, $d3, $00, $d7, $01, $07, $81, $67, $20
	.db $93, $22, $03, $a3, $1c, $61, $17, $21, $6f, $33
	.db $c7, $63, $d8, $62, $e9, $61, $fa, $60, $4f, $b3
	.db $87, $63, $9c, $01, $b7, $63, $c8, $62, $d9, $61
	.db $ea, $60, $39, $f1, $87, $21, $a7, $01, $b7, $20
	.db $39, $f1, $5f, $38, $6d, $c1, $af, $26
	.db $fd

;level 1-3/5-3
L_GroundArea7:
	.db $90, $11
	.db $0f, $26, $fe, $10, $2a, $93, $87, $17, $a3, $14
	.db $b2, $42, $0a, $92, $19, $40, $36, $14, $50, $41
	.db $82, $16, $2b, $93, $24, $41, $bb, $14, $b8, $00
	.db $c2, $43, $c3, $13, $1b, $94, $67, $12, $c4, $15
	.db $53, $c1, $d2, $41, $12, $c1, $29, $13, $85, $17
	.db $1b, $92, $1a, $42, $47, $13, $83, $41, $a7, $13
	.db $0e, $91, $a7, $63, $b7, $63, $c5, $65, $d5, $65
	.db $dd, $4a, $e3, $67, $f3, $67, $8d, $c1, $ae, $42
	.db $df, $20
	.db $fd

;level 2-3/7-3
L_GroundArea8:
	.db $90, $11
	.db $0f, $26, $6e, $10, $8b, $17, $af, $32, $d8, $62
	.db $e8, $62, $fc, $3f, $ad, $c8, $f8, $64, $0c, $be
	.db $43, $43, $f8, $64, $0c, $bf, $73, $40, $84, $40
	.db $93, $40, $a4, $40, $b3, $40, $f8, $64, $48, $e4
	.db $5c, $39, $83, $40, $92, $41, $b3, $40, $f8, $64
	.db $48, $e4, $5c, $39, $f8, $64, $13, $c2, $37, $65
	.db $4c, $24, $63, $00, $97, $65, $c3, $42, $0b, $97
	.db $ac, $32, $f8, $64, $0c, $be, $53, $45, $9d, $48
	.db $f8, $64, $2a, $e2, $3c, $47, $56, $43, $ba, $62
	.db $f8, $64, $0c, $b7, $88, $64, $bc, $31, $d4, $45
	.db $fc, $31, $3c, $b1, $78, $64, $8c, $38, $0b, $9c
	.db $1a, $33, $18, $61, $28, $61, $39, $60, $5d, $4a
	.db $ee, $11, $0f, $b8, $1d, $c1, $3e, $42, $6f, $20
	.db $fd

;level 2-1
L_GroundArea9:
	.db $52, $31
	.db $0f, $20, $6e, $40, $f7, $20, $07, $84, $17, $20
	.db $4f, $34, $c3, $03, $c7, $02, $d3, $22, $27, $e3
	.db $39, $61, $e7, $73, $5c, $e4, $57, $00, $6c, $73
	.db $47, $a0, $53, $06, $63, $22, $a7, $73, $fc, $73
	.db $13, $a1, $33, $05, $43, $21, $5c, $72, $c3, $23
	.db $cc, $03, $77, $fb, $ac, $02, $39, $f1, $a7, $73
	.db $d3, $04, $e8, $72, $e3, $22, $26, $f4, $bc, $02
	.db $8c, $81, $a8, $62, $17, $87, $43, $24, $a7, $01
	.db $c3, $04, $08, $f2, $97, $21, $a3, $02, $c9, $0b
	.db $e1, $69, $f1, $69, $8d, $c1, $cf, $26
	.db $fd

;pipe intro area
L_GroundArea10:
	.db $38, $11
	.db $0f, $26, $ad, $40, $3d, $c7
	.db $fd

;level 5-1
L_GroundArea11:
	.db $95, $b1
	.db $0f, $26, $0d, $02, $c8, $72, $1c, $81, $38, $72
	.db $0d, $05, $97, $34, $98, $62, $a3, $20, $b3, $06
	.db $c3, $20, $cc, $03, $f9, $91, $2c, $81, $48, $62
	.db $0d, $09, $37, $63, $47, $03, $57, $21, $8c, $02
	.db $c5, $79, $c7, $31, $f9, $11, $39, $f1, $a9, $11
	.db $6f, $b4, $d3, $65, $e3, $65, $7d, $c1, $bf, $26
	.db $fd

;cloud level used in levels 2-1 and 5-2
L_GroundArea12:
	.db $00, $c1
	.db $4c, $00, $f4, $4f, $0d, $02, $02, $42, $43, $4f
	.db $52, $c2, $de, $00, $5a, $c2, $4d, $c7
	.db $fd

;level 4-3
L_GroundArea13:
	.db $90, $51
	.db $0f, $26, $ee, $10, $0b, $94, $33, $14, $42, $42
	.db $77, $16, $86, $44, $02, $92, $4a, $16, $69, $42
	.db $73, $14, $b0, $00, $c7, $12, $05, $c0, $1c, $17
	.db $1f, $11, $36, $12, $8f, $14, $91, $40, $1b, $94
	.db $35, $12, $34, $42, $60, $42, $61, $12, $87, $12
	.db $96, $40, $a3, $14, $1c, $98, $1f, $11, $47, $12
	.db $9f, $15, $cc, $15, $cf, $11, $05, $c0, $1f, $15
	.db $39, $12, $7c, $16, $7f, $11, $82, $40, $98, $12
	.db $df, $15, $16, $c4, $17, $14, $54, $12, $9b, $16
	.db $28, $94, $ce, $01, $3d, $c1, $5e, $42, $8f, $20
	.db $fd

;level 6-3
L_GroundArea14:
	.db $97, $11
	.db $0f, $26, $fe, $10, $2b, $92, $57, $12, $8b, $12
	.db $c0, $41, $f7, $13, $5b, $92, $69, $0b, $bb, $12
	.db $b2, $46, $19, $93, $71, $00, $17, $94, $7c, $14
	.db $7f, $11, $93, $41, $bf, $15, $fc, $13, $ff, $11
	.db $2f, $95, $50, $42, $51, $12, $58, $14, $a6, $12
	.db $db, $12, $1b, $93, $46, $43, $7b, $12, $8d, $49
	.db $b7, $14, $1b, $94, $49, $0b, $bb, $12, $fc, $13
	.db $ff, $12, $03, $c1, $2f, $15, $43, $12, $4b, $13
	.db $77, $13, $9d, $4a, $15, $c1, $a1, $41, $c3, $12
	.db $fe, $01, $7d, $c1, $9e, $42, $cf, $20
	.db $fd

;level 6-1
L_GroundArea15:
	.db $52, $21
	.db $0f, $20, $6e, $44, $0c, $f1, $4c, $01, $aa, $35
	.db $d9, $34, $ee, $20, $08, $b3, $37, $32, $43, $04
	.db $4e, $21, $53, $20, $7c, $01, $97, $21, $b7, $07
	.db $9c, $81, $e7, $42, $5f, $b3, $97, $63, $ac, $02
	.db $c5, $41, $49, $e0, $58, $61, $76, $64, $85, $65
	.db $94, $66, $a4, $22, $a6, $03, $c8, $22, $dc, $02
	.db $68, $f2, $96, $42, $13, $82, $17, $02, $af, $34
	.db $f6, $21, $fc, $06, $26, $80, $2a, $24, $36, $01
	.db $8c, $00, $ff, $35, $4e, $a0, $55, $21, $77, $20
	.db $87, $07, $89, $22, $ae, $21, $4c, $82, $9f, $34
	.db $ec, $01, $03, $e7, $13, $67, $8d, $4a, $ad, $41
	.db $0f, $a6
	.db $fd

;warp zone area used in level 4-2
L_GroundArea16:
	.db $10, $51
	.db $4c, $00, $c7, $12, $c6, $42, $03, $92, $02, $42
	.db $29, $12, $63, $12, $62, $42, $69, $14, $a5, $12
	.db $a4, $42, $e2, $14, $e1, $44, $f8, $16, $37, $c1
	.db $8f, $38, $02, $bb, $28, $7a, $68, $7a, $a8, $7a
	.db $e0, $6a, $f0, $6a, $6d, $c5
	.db $fd

;level 8-1
L_GroundArea17:
	.db $92, $31
	.db $0f, $20, $6e, $40, $0d, $02, $37, $73, $ec, $00
	.db $0c, $80, $3c, $00, $6c, $00, $9c, $00, $06, $c0
	.db $c7, $73, $06, $83, $28, $72, $96, $40, $e7, $73
	.db $26, $c0, $87, $7b, $d2, $41, $39, $f1, $c8, $f2
	.db $97, $e3, $a3, $23, $e7, $02, $e3, $07, $f3, $22
	.db $37, $e3, $9c, $00, $bc, $00, $ec, $00, $0c, $80
	.db $3c, $00, $86, $21, $a6, $06, $b6, $24, $5c, $80
	.db $7c, $00, $9c, $00, $29, $e1, $dc, $05, $f6, $41
	.db $dc, $80, $e8, $72, $0c, $81, $27, $73, $4c, $01
	.db $66, $74, $0d, $11, $3f, $35, $b6, $41, $2c, $82
	.db $36, $40, $7c, $02, $86, $40, $f9, $61, $39, $e1
	.db $ac, $04, $c6, $41, $0c, $83, $16, $41, $88, $f2
	.db $39, $f1, $7c, $00, $89, $61, $9c, $00, $a7, $63
	.db $bc, $00, $c5, $65, $dc, $00, $e3, $67, $f3, $67
	.db $8d, $c1, $cf, $26
	.db $fd

;level 5-2
L_GroundArea18:
	.db $55, $b1
	.db $0f, $26, $cf, $33, $07, $b2, $15, $11, $52, $42
	.db $99, $0b, $ac, $02, $d3, $24, $d6, $42, $d7, $25
	.db $23, $84, $cf, $33, $07, $e3, $19, $61, $78, $7a
	.db $ef, $33, $2c, $81, $46, $64, $55, $65, $65, $65
	.db $ec, $74, $47, $82, $53, $05, $63, $21, $62, $41
	.db $96, $22, $9a, $41, $cc, $03, $b9, $91, $39, $f1
	.db $63, $26, $67, $27, $d3, $06, $fc, $01, $18, $e2
	.db $d9, $07, $e9, $04, $0c, $86, $37, $22, $93, $24
	.db $87, $84, $ac, $02, $c2, $41, $c3, $23, $d9, $71
	.db $fc, $01, $7f, $b1, $9c, $00, $a7, $63, $b6, $64
	.db $cc, $00, $d4, $66, $e3, $67, $f3, $67, $8d, $c1
	.db $cf, $26
	.db $fd

;level 8-2
L_GroundArea19:
	.db $50, $b1
	.db $0f, $26, $fc, $00, $1f, $b3, $5c, $00, $65, $65
	.db $74, $66, $83, $67, $93, $67, $dc, $73, $4c, $80
	.db $b3, $20, $c9, $0b, $c3, $08, $d3, $2f, $dc, $00
	.db $2c, $80, $4c, $00, $8c, $00, $d3, $2e, $ed, $4a
	.db $fc, $00, $d7, $a1, $ec, $01, $4c, $80, $59, $11
	.db $d8, $11, $da, $10, $37, $a0, $47, $04, $99, $11
	.db $e7, $21, $3a, $90, $67, $20, $76, $10, $77, $60
	.db $87, $07, $d8, $12, $39, $f1, $ac, $00, $e9, $71
	.db $0c, $80, $2c, $00, $4c, $05, $c7, $7b, $39, $f1
	.db $ec, $00, $f9, $11, $0c, $82, $6f, $34, $f8, $11
	.db $fa, $10, $7f, $b2, $ac, $00, $b6, $64, $cc, $01
	.db $e3, $67, $f3, $67, $8d, $c1, $cf, $26
	.db $fd

;level 7-1
L_GroundArea20:
	.db $52, $b1
	.db $0f, $20, $6e, $45, $39, $91, $b3, $04, $c3, $21
	.db $c8, $11, $ca, $10, $49, $91, $7c, $73, $e8, $12
	.db $88, $91, $8a, $10, $e7, $21, $05, $91, $07, $30
	.db $17, $07, $27, $20, $49, $11, $9c, $01, $c8, $72
	.db $23, $a6, $27, $26, $d3, $03, $d8, $7a, $89, $91
	.db $d8, $72, $39, $f1, $a9, $11, $09, $f1, $63, $24
	.db $67, $24, $d8, $62, $28, $91, $2a, $10, $56, $21
	.db $70, $04, $79, $0b, $8c, $00, $94, $21, $9f, $35
	.db $2f, $b8, $3d, $c1, $7f, $26
	.db $fd

;cloud level used in levels 3-1 and 6-2
L_GroundArea21:
	.db $06, $c1
	.db $4c, $00, $f4, $4f, $0d, $02, $06, $20, $24, $4f
	.db $35, $a0, $36, $20, $53, $46, $d5, $20, $d6, $20
	.db $34, $a1, $73, $49, $74, $20, $94, $20, $b4, $20
	.db $d4, $20, $f4, $20, $2e, $80, $59, $42, $4d, $c7
	.db $fd

;level 3-2
L_GroundArea22:
	.db $96, $31
	.db $0f, $26, $0d, $03, $1a, $60, $77, $42, $c4, $00
	.db $c8, $62, $b9, $e1, $d3, $06, $d7, $07, $f9, $61
	.db $0c, $81, $4e, $b1, $8e, $b1, $bc, $01, $e4, $50
	.db $e9, $61, $0c, $81, $0d, $0a, $84, $43, $98, $72
	.db $0d, $0c, $0f, $38, $1d, $c1, $5f, $26
	.db $fd

;level 1-2
L_UndergroundArea1:
	.db $48, $0f
	.db $0e, $01, $5e, $02, $a7, $00, $bc, $73, $1a, $e0
	.db $39, $61, $58, $62, $77, $63, $97, $63, $b8, $62
	.db $d6, $07, $f8, $62, $19, $e1, $75, $52, $86, $40
	.db $87, $50, $95, $52, $93, $43, $a5, $21, $c5, $52
	.db $d6, $40, $d7, $20, $e5, $06, $e6, $51, $3e, $8d
	.db $5e, $03, $67, $52, $77, $52, $7e, $02, $9e, $03
	.db $a6, $43, $a7, $23, $de, $05, $fe, $02, $1e, $83
	.db $33, $54, $46, $40, $47, $21, $56, $04, $5e, $02
	.db $83, $54, $93, $52, $96, $07, $97, $50, $be, $03
	.db $c7, $23, $fe, $02, $0c, $82, $43, $45, $45, $24
	.db $46, $24, $90, $08, $95, $51, $78, $fa, $d7, $73
	.db $39, $f1, $8c, $01, $a8, $52, $b8, $52, $cc, $01
	.db $5f, $b3, $97, $63, $9e, $00, $0e, $81, $16, $24
	.db $66, $04, $8e, $00, $fe, $01, $08, $d2, $0e, $06
	.db $6f, $47, $9e, $0f, $0e, $82, $2d, $47, $28, $7a
	.db $68, $7a, $a8, $7a, $ae, $01, $de, $0f, $6d, $c5
	.db $fd

;level 4-2
L_UndergroundArea2:
	.db $48, $0f
	.db $0e, $01, $5e, $02, $bc, $01, $fc, $01, $2c, $82
	.db $41, $52, $4e, $04, $67, $25, $68, $24, $69, $24
	.db $ba, $42, $c7, $04, $de, $0b, $b2, $87, $fe, $02
	.db $2c, $e1, $2c, $71, $67, $01, $77, $00, $87, $01
	.db $8e, $00, $ee, $01, $f6, $02, $03, $85, $05, $02
	.db $13, $21, $16, $02, $27, $02, $2e, $02, $88, $72
	.db $c7, $20, $d7, $07, $e4, $76, $07, $a0, $17, $06
	.db $48, $7a, $76, $20, $98, $72, $79, $e1, $88, $62
	.db $9c, $01, $b7, $73, $dc, $01, $f8, $62, $fe, $01
	.db $08, $e2, $0e, $00, $6e, $02, $73, $20, $77, $23
	.db $83, $04, $93, $20, $ae, $00, $fe, $0a, $0e, $82
	.db $39, $71, $a8, $72, $e7, $73, $0c, $81, $8f, $32
	.db $ae, $00, $fe, $04, $04, $d1, $17, $04, $26, $49
	.db $27, $29, $df, $33, $fe, $02, $44, $f6, $7c, $01
	.db $8e, $06, $bf, $47, $ee, $0f, $4d, $c7, $0e, $82
	.db $68, $7a, $ae, $01, $de, $0f, $6d, $c5
	.db $fd

;underground bonus rooms area used in many levels
L_UndergroundArea3:
	.db $48, $01
	.db $0e, $01, $00, $5a, $3e, $06, $45, $46, $47, $46
	.db $53, $44, $ae, $01, $df, $4a, $4d, $c7, $0e, $81
	.db $00, $5a, $2e, $04, $37, $28, $3a, $48, $46, $47
	.db $c7, $07, $ce, $0f, $df, $4a, $4d, $c7, $0e, $81
	.db $00, $5a, $33, $53, $43, $51, $46, $40, $47, $50
	.db $53, $04, $55, $40, $56, $50, $62, $43, $64, $40
	.db $65, $50, $71, $41, $73, $51, $83, $51, $94, $40
	.db $95, $50, $a3, $50, $a5, $40, $a6, $50, $b3, $51
	.db $b6, $40, $b7, $50, $c3, $53, $df, $4a, $4d, $c7
	.db $0e, $81, $00, $5a, $2e, $02, $36, $47, $37, $52
	.db $3a, $49, $47, $25, $a7, $52, $d7, $04, $df, $4a
	.db $4d, $c7, $0e, $81, $00, $5a, $3e, $02, $44, $51
	.db $53, $44, $54, $44, $55, $24, $a1, $54, $ae, $01
	.db $b4, $21, $df, $4a, $e5, $07, $4d, $c7
	.db $fd

;water area used in levels 5-2 and 6-2
L_WaterArea1:
	.db $41, $01
	.db $b4, $34, $c8, $52, $f2, $51, $47, $d3, $6c, $03
	.db $65, $49, $9e, $07, $be, $01, $cc, $03, $fe, $07
	.db $0d, $c9, $1e, $01, $6c, $01, $62, $35, $63, $53
	.db $8a, $41, $ac, $01, $b3, $53, $e9, $51, $26, $c3
	.db $27, $33, $63, $43, $64, $33, $ba, $60, $c9, $61
	.db $ce, $0b, $e5, $09, $ee, $0f, $7d, $ca, $7d, $47
	.db $fd

;level 2-2/7-2
L_WaterArea2:
	.db $41, $01
	.db $b8, $52, $ea, $41, $27, $b2, $b3, $42, $16, $d4
	.db $4a, $42, $a5, $51, $a7, $31, $27, $d3, $08, $e2
	.db $16, $64, $2c, $04, $38, $42, $76, $64, $88, $62
	.db $de, $07, $fe, $01, $0d, $c9, $23, $32, $31, $51
	.db $98, $52, $0d, $c9, $59, $42, $63, $53, $67, $31
	.db $14, $c2, $36, $31, $87, $53, $17, $e3, $29, $61
	.db $30, $62, $3c, $08, $42, $37, $59, $40, $6a, $42
	.db $99, $40, $c9, $61, $d7, $63, $39, $d1, $58, $52
	.db $c3, $67, $d3, $31, $dc, $06, $f7, $42, $fa, $42
	.db $23, $b1, $43, $67, $c3, $34, $c7, $34, $d1, $51
	.db $43, $b3, $47, $33, $9a, $30, $a9, $61, $b8, $62
	.db $be, $0b, $d5, $09, $de, $0f, $0d, $ca, $7d, $47
	.db $fd

;water area used in level 8-4
L_WaterArea3:
	.db $49, $0f
	.db $1e, $01, $39, $73, $5e, $07, $ae, $0b, $1e, $82
	.db $6e, $88, $9e, $02, $0d, $04, $2e, $0b, $45, $09
	.db $4e, $0f, $ed, $47
	.db $fd

;unused space
	.db $ff
