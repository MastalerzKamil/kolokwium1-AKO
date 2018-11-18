.686
.model flat
extern _ExitProcess@4 : PROC
public _main

.data
znaki		db 61h, 62h, 0c2h, 0a7h, 0h
rozmiar		dd 0	; rozmiar to ilosc bajtow potrzebnych do zapisu w UTF-16
					; w tym zadaniu rozpatrujemy tylko przypadki 0h-FFFFh
					; czyli zawsze zwiekszamy o 1 slowo(2 bajty)
.code
_main PROC
	mov eax, 0	; w al beda kolejne bajty z tablicy znaki
	mov ecx, 0	; ecx -iterator po tablicy znaki
ptl:
	mov al, znaki[ecx]
	mov edi, eax	; eax bylo wczesniej zerowane wiec na pewno mamy konkretny bajt z tablicy znaki
	bt edi, 7	; jesli na najstarszym bicie bedzie 1 to zapali CF=1 i oznacza
	jnc bajtowa_1_liczba
	bt edi, 5
	jnc bajtowa_2_liczba
	bt edi, 4
	jnc bajtowa_3_liczba
bajtowa_1_liczba:
	inc ecx ; liczba 1-bajtowa w UTF-8 wiec zwiekszam iterator o 1
	jmp czy_koniec
bajtowa_2_liczba:
	add ecx, 2	; liczba 2 bajtowa wiec zwiekszam iterator o 2
	jmp czy_koniec
bajtowa_3_liczba:
	add ecx, 3
	jmp czy_koniec
czy_koniec:
	add rozmiar, 2	; w zadaniu rozpatrujemy tylko znaki z przedzialu 0h-FFFFh czyli w UTF-16 jako 2 bajty zawsze
	cmp znaki[ecx], 0
	jnz ptl
	push 0
	call _ExitProcess@4
_main ENDP
END
