.686
.model flat
extern _ExitProcess@4 : PROC
public _main

.data
pamiec		dd 3 dup(?)
.code
_main PROC
	mov cl, 7
	mov al, 11010110b
	mov edi, offset pamiec

	and eax, 0000001Fh	; pewnosc, ze przeniesiemy 5 najmlodszych bitow z al
	shl eax, cl	; przygotowanie do zapisu od bitu o wartosci w cl
	mov [edi], ax
	push 0
	call _ExitProcess@4
_main ENDP
END
