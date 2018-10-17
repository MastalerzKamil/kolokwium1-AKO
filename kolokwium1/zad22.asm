.686
.model flat
extern _ExitProcess@4 : PROC
;public _main
.data

.code
;_main PROC
	mov esi, 32		; esi-licznik petli po bitach
	mov cl, 0
ptl:
	sub esi, 1
	cmp esi, 0
	jz wyjdz_z_petli
	shl eax, 1
	jnc ptl
	inc cl
	jmp ptl
wyjdz_z_petli:
	nop
	call _ExitProcess@4
;_main ENDP
END