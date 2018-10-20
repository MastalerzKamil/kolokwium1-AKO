.686
.model flat
extern _ExitProcess@4 : PROC
;public _main
.data
.code
;_main PROC	
	mov edx,  347
	xchg [esp], edx
	; ret	eip=0000015B
	nop
	call _ExitProcess@4
;_main ENDP
END