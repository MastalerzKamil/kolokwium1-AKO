.686
.model flat
extern _ExitProcess@4 : PROC
;public _main
.data
wskaznik	dd	?
.code
;_main PROC	
	mov ebx, 255
	mov ebx, offset wskaznik
	nop
	mov wskaznik, ebx
	nop
	call _ExitProcess@4
;_main ENDP
END