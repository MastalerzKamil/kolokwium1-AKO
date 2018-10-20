.686
.model flat
extern _ExitProcess@4 : PROC
;public _main
.data
.code
;_main PROC	
	mov ax, 20
start:
	mov ecx, 3
	sub ax, 10
	;loop start	;nieskonczona petla
	nop
	call _ExitProcess@4
;_main ENDP
END