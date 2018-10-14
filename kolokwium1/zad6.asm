.686
.model flat
extern _ExitProcess@4 : PROC
;public _main
.data
stale dw 2, 1
napis dw 10 dup (3), 2
tekst db 7
	  dq 1
	  db 2

.code
;_main PROC
	mov cx, napis-1
	sub tekst, ch
	mov edi, 1
	mov tekst[4*edi],  ch
	mov ebx, dword ptr tekst+1
	call _ExitProcess@4
;_main ENDP
END