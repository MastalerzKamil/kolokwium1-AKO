.686
.model flat
extern _ExitProcess@4 : PROC
;public _main
.data
v1			dq		?, ?
v2			dw		4 dup (?), 20
v3			db		10 dup (?)
koniec		db		255
.code
;_main PROC	
	nop	; odp: 36 bitów zajmuje pamiec
	call _ExitProcess@4
;_main ENDP
END