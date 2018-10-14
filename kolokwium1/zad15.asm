.686
.model flat
extern _ExitProcess@4 : PROC
public _main
.data

.code
_main PROC
	mov eax, 0ffffffffh
	mov ebx, 0ffffffffh
	imul ebx
	call _ExitProcess@4
_main ENDP
END