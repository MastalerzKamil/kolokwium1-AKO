.686
.model flat
extern _ExitProcess@4 : PROC
;public _main
.data

.code
;_main PROC
	sub esp, 4
	mov [esp], dword PTR 'A'
	nop
	call _ExitProcess@4
;_main ENDP
END