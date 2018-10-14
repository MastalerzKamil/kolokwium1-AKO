.686
.model flat
extern _ExitProcess@4 : PROC
;public _main
.data
obroty	LABEL	byte
		ORG		$ + 7
tmp		db 2

.code
;_main PROC
	xor eax, eax
	mov eax, 1
	mov ebx, 2
	;sub eax, 0ffffffffh
	sub eax, ebx
	nop
	call _ExitProcess@4
;_main ENDP
END