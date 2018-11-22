.686
.model flat
extern _ExitProcess@4 : PROC
public _main

.data
ilosc_4bajtowych	dd 32	; 32*32 = 1024
rejestr1024			dd 32 dup (0AAAAAAAAh)

.code
_main PROC
	mov esi, offset rejestr1024
	mov edi, esi	; adres do zapisu ten sam
	mov ecx, 0
ptl:
	mov eax, dword PTR [esi+4*ecx]	; z 1024 bitow wybieramy tylko 32
	rcl eax, 1	; po wykonaniu petli CF nie zmienia sie
	mov dword PTR [edi + 4*ecx], eax
	inc ecx
	cmp ecx, ilosc_4bajtowych
	jne ptl
	push 0
	call _ExitProcess@4
_main ENDP
END