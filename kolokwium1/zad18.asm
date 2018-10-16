.686
.model flat
extern _ExitProcess@4 : PROC
;public _main
.data
qxy		dw	254,255,256
.code
;_main PROC
	mov eax, dword ptr qxy + 1
	nop
	call _ExitProcess@4
;_main ENDP
END