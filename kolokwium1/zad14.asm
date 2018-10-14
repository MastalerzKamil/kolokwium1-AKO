.686
.model flat
extern _ExitProcess@4 : PROC
public _main
.data

.code
_main PROC
	mov eax, 1
	mov ebx, 2
	push eax
	push ebx
	add esp, 8

	sub esp,8
	mov [esp+4], eax
	mov [esp], ebx
	call _ExitProcess@4
_main ENDP
END