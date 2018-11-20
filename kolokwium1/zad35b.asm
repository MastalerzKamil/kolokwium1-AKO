.686
.model flat
extern _ExitProcess@4 : PROC
extern __write : PROC
public _main

.data
ilosc_swiat		dd 0
swieta			dd 0AAAAAAAAh
wynik			dd ?,'.',?,0,'\n'
miesiac			dd 0, 0
dzien			dd 0, 0
system_liczbowy db 10
.code
_main PROC
	; edx - iterator po bitach miesiaca
	; esi - element tablicy dni miesiaca
	mov ecx, 9
	shl ecx, 24
	shr ecx, 24	; aby miec pewnosc, ze starsze bity w ecx poza cl sa zerem
	mov ax, cx	; aby w dzielnej(liczniku dzielenia) byla wartosc miesiaca
	push ecx	; zapamietuje ecx aby rejestr ten posluzyl do kelejnon zapisywania w pamieci
	push edi	; zapamietanie celu do ktorego trzeba zapisac. W tym przypadku celem bedzie zmienna miesiac
	mov ecx, 2	; maksymalna ilosc cyfer w miesiacu
	mov edi, offset miesiac	; miejsce do ktorego bede zapisywal wynik zdekodowanego miesiaca
licz_miesiac_dziesietnie:
	div system_liczbowy
	dec ecx
	mov byte PTR[edi+4*ecx], ah	; wyliczanie adresu efektywnego dla miesiaca w pamieci czyli adres+4*ilosc_cyfer
	cmp al, 0
	jnz licz_miesiac_dziesietnie
	pop edi	; zdjecie sprzed zapisu miesiaca 
	pop ecx	; zdjecie zawartosci miesiaca w ecx

	mov ebx, offset swieta ; testowo dalem zmienna ze swietami
	mov esi, [ebx]
	mov edx, 31	; najstarszy bit do testowania
ptl:
	bts esi, edx	; sprawdzenie dnia o bicie ktory zawiera sie w edx
	jc jest_swieto
	dec edx
	jnz ptl	;  przyadek gdy nie ma swieta  ale tez nie ma konca miesiaca
	jmp koniec_miesiaca ; przypadek gdy jest koniec miesiaca i nie bylo swieta
jest_swieto:
	add ilosc_swiat, 1
	push dword PTR 4+4+4+4 ; push(dzien+dzien+'.'+miesiac+miesiac+0)
	add edx, '0'
	mov wynik, edx	; pierwszy czlon daty
	mov edi,(offset wynik)+8 ; adres pod ktorym bedzie miesiac
	mov ecx, [edi] ; wartosc miesiaca  format: edx.ecx
	push OFFSET wynik	; wartosc daty
	push dword PTR 1	; numer urzadzenia (numer ekranu=1)
	call __write
	add esp, 12	; zwolnienie pamieci po wypisaniu daty
	dec edx ; aby kolejnybit wziac pod uwage
	jnz ptl	; jeszcze nie ma konca miesiaca
	jmp koniec_miesiaca	
koniec_miesiaca:
	push 0
	call _ExitProcess@4
_main ENDP
END