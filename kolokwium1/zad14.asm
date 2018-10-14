.686
.model flat
extern _ExitProcess@4 : PROC
;public _main
.data

.code
;_main PROC
	sub esp,8
	mov [esp+8], eax
	mov [esp], ebx
	call _ExitProcess@4
;_main ENDP
END