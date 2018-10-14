.686
.model flat
extern _ExitProcess@4 : PROC
;public _main
.data
obroty	LABEL	byte
		ORG		$ + 7
tmp		db 2

.code
;_main PROC
	nop
	call _ExitProcess@4
;_main ENDP
END