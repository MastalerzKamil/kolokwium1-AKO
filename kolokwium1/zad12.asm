.686
.model flat
extern _ExitProcess@4 : PROC
;public _main
.data

.code
;_main PROC
	lea esi, [esi + 8*esi]
	nop
	call _ExitProcess@4
;_main ENDP
END