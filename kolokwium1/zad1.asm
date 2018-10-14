.686
.model flat
extern _ExitProcess@4 : PROC
;public _main
.data

.code
;_main PROC
	push dword PTR 0     ; kod powrotu programu
	mov ax, 0
	mov dx, 1
	div dx
	nop
	call _ExitProcess@4  
;_main ENDP
END