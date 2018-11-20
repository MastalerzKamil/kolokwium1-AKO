.686
.model flat
extern _ExitProcess@4 : PROC
extern __write : PROC
public _main

.data
ilosc_swiat		dd 0
wynik			dd ?,'.',?,0,'\n'
.code
_main PROC
	; edx - iterator po bitach miesiaca
	; esi - element tablicy dni miesiaca
	mov esi, [ebx]
	mov edx, 31	; najstarszy bit do testowania
ptl:
	bts esi, edx	; sprawdzenie dnia o bicie ktory zawiera sie w edx
	jc jest_swieto
	dec edx
	jnz ptl	;  przyadek gdy nie ma swieta  ale tez nie ma konca miesiaca
	jmp koniec_miesiaca ; przypadek gdy jest koniec miesiaca i nie bylo swieta
jest_swieto:
	shl ecx, 24
	shr ecx, 24	; aby miec pewnosc, ze starsze bity w ecx poza cl sa zerem
	add ilosc_swiat, 1
	push dword PTR 4+4+4+4 ; push(dzien+'.'+miesiac+0)
	mov wynik, edx	; pierwszy czlon daty
	mov edi,(offset wynik)+8 ; adres pod ktorym bedzie miesiac
	mov ecx, [edi] ; wartosc miesiaca  format: edx.ecx
	push OFFSET wynik	; wartosc daty
	push dword PTR 1	; numer urzadzenia (numer ekranu=1)
	call __write
	; add esp, 12	; zwolnienie pamieci po wypisaniu daty
	dec edx ; aby kolejnybit wziac pod uwage
	jnz ptl	; jeszcze nie ma konca miesiaca
	jmp koniec_miesiaca	
koniec_miesiaca:
	push 0
	call _ExitProcess@4
_main ENDP
END