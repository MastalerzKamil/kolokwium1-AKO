.686
.model flat
extern _ExitProcess@4 : PROC
public _main
.data
linie	dd	421, 422, 423, 442, 444, 427, 432
.code
_main PROC
	mov esi, (OFFSET linie)
	mov esi, (OFFSET linie)+4
	mov ebx, 4
	mov edx, [ebx][esi]	; po tej operacji edx=000001A7
	nop
	call _ExitProcess@4
_main ENDP
END