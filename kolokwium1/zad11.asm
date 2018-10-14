.686
.model flat
extern _ExitProcess@4 : PROC
;public _main
.data

.code
;_main PROC
	mov dh, 15
	xor dh,12
	nop
	call _ExitProcess@4
;_main ENDP
END