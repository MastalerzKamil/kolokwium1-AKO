.686
.model flat
extern _ExitProcess@4 : PROC
;public _main
.data
const2			db		?
.code
;_main PROC	
	;mov const2, 256	; za duza liczba do zapisania na 8 bitach
	nop
	call _ExitProcess@4
;_main ENDP
END