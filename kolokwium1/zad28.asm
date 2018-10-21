.686
.model flat
extern _ExitProcess@4 : PROC
;public _main
.data
.code
;_main PROC	
	dec ecx
    jnz oblicz
oblicz: add dh, 7
	call _ExitProcess@4
;_main ENDP
END