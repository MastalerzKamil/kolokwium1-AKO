.686
.model flat
extern _ExitProcess@4 : PROC
;public _main
.data
mlodsza_LE dw 0
.code
;_main PROC
	mov eax, [ebx] ; pobieram z pamieci 4 bajty w ktorych zapisana jest liczba
	mov mlodsza_LE, ax
	shr eax, 16 ; przesuwam w prawo aby wyodrebnic starsza i mlodsza czesc (Little Endian)
				; w ax mam starsza czesc (biy 16-31) w Little Endian
	mov cx, mlodsza_LE
	xchg ch, cl ; apby przesunac 16-bitowe czesci na Big Endian
	xchg ah, al
	shl ecx, 16
	mov cx, ax
	mov eax, ecx
	nop
	call _ExitProcess@4
;_main ENDP
END