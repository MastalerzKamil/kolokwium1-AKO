.686
.model flat
extern _ExitProcess@4 : PROC
extern _MessageBoxA@16 : PROC
; public _main
.data
napis	db	'informatyka', 0, 4 dup (?)
.code
; _main PROC
	mov ecx, 12
przepisz:
	mov al, napis[ecx-1]
	mov napis[ecx+3], al
	loop przepisz

	push 0
	push offset napis
	lea eax, napis[3]
	push eax
	push 0
	call _MessageBoxA@16
	call _ExitProcess@4
; _main ENDP
END