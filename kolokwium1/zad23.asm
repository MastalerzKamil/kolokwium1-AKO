.686
.model flat
extern _ExitProcess@4 : PROC
public _main
.data

.code
_main PROC
	mov eax, 2
	mov ebx, eax
	lea ebx, [2*ebx]
	lea eax, [8*eax + ebx]	
	nop
	call _ExitProcess@4
_main ENDP
END