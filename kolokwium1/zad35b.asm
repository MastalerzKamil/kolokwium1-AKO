.686
.model flat
extern _ExitProcess@4 : PROC
extern __write : PROC
; public _main

.data
swieta			dd 0AAAAAAAAh
wynik			db ?, ?, '.', ?, ?, ','
miesiac			db 0, 0
dzien			db 0, 0
system_liczbowy db 10
.code
; _main PROC
	; edx - iterator po bitach miesiaca
	; esi - element tablicy dni miesiaca
	mov ecx, 9
	shl ecx, 24
	shr ecx, 24	; aby miec pewnosc, ze starsze bity w ecx poza cl sa zerem
	push ebx	; zapamietuje ebx aby rejestr ten posluzyl do kelejnego zapisywania w pamieci
	push edi	; zapamietanie celu do ktorego trzeba zapisac. W tym przypadku celem bedzie zmienna miesiac
	push eax	; zapamietanie eax w celu liczenia
	mov ebx, 2	; maksymalna ilosc cyfer w miesiacu
	mov edi, offset miesiac	; miejsce do ktorego bede zapisywal wynik zdekodowanego miesiaca
	mov ax, cx	; aby w dzielnej(liczniku dzielenia) byla wartosc miesiaca
licz_miesiac_dziesietnie:
	div system_liczbowy
	dec ebx
	add ah, '0'	; zamiana liczby na znak ASCII
	mov byte PTR[edi+ebx], ah	; wyliczanie adresu efektywnego dla miesiaca w pamieci czyli adres+4*ilosc_cyfer 
									; oraz wsadzenie tam cyfry w ASCII
	mov ah, 0	; zerowaniepo zapisie znaku ASCII do pamieci
	cmp al, 0
	jnz licz_miesiac_dziesietnie
	pop eax ; zdjecie zawartosci eax sprzed dzielenia
	pop edi	; zdjecie sprzed zapisu miesiaca 
	pop ebx	; zdjecie zawartosci miesiaca w ecx
; teraz czas na sprawdzenie dni swiat
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
	push ecx	; zapamietanie zawartosci ecx w ktorym jest wartosc miesiaca
	push edi	; zapamietanie edi w ktorym bedzie zmiennadla dnia miesiaca
	push eax	; zapamietanie eax w celu zamiany na cyfry
	mov ecx, 2	; maksymalna liczba cyfr dla dnia
	mov edi, offset dzien	; adres w pamieci dla zmiennej dzien
	mov eax, edx	; tymczasowo na czas dzielenia numer bitu zapamietuje
licz_dzien_dziesietnie:
	div system_liczbowy
	dec ecx	; zmniejszam bo od prawej strony cyfry wyliczaja sie
	add ah, '0'	;zamiana iczby na znak ASCII
	mov byte PTR[edi+ecx], ah	; wyliczanie adresu efektywnego dla miesiaca w pamieci czyli adres+4*ilosc_cyfer 
									; oraz wsadzenie tam cyfry w ASCII
	mov ah, 0	; zerowanie ah po zapisaniu do pamieci
	cmp al, 0
	jnz licz_dzien_dziesietnie
	pop eax	; zdejmuje rejestr do dzielenia
	pop edi	; zdejmuje rejestr do docelowego zapisu
	pop ecx	; zdejmuje rejestr z wartoscia liczby miesiaca

; zapisywanie daty do zmiennej wynik
	push esi	; zapamietanie w celu adresu skladowej formatu daty
	push edi	; zapamietywanie docelowego rejestru w celu zapisu danych pod adres zmiennej wynik
	push eax	; tymczasowo aby w eax byly skladowe daty
	push ecx	; zapamietanie zawartosci miesiaca w celu wyliczenia adresu efektywnego dla zmiennej wynik
	mov ecx, 0
	mov edi, offset wynik
	mov esi, offset dzien
	mov al, [esi]	; cyfra dziesiatek dnia
	mov [edi+ecx], al	; cyfra dziesiatek dnia w wyniku
	inc ecx
	mov al, [esi+1]	; cyfra jednosci dnia
	mov [edi+ecx], al	; cyfra jednosci dnia w wyniku
	inc ecx
	mov [edi+ecx], byte PTR '.'	;przecinek w wyniku
	inc ecx
	mov esi, offset miesiac
	mov al, [esi]	;cyfra dziesiatek z miesiaca
	mov [edi+ecx], al	; cyfra dziesiatek miesiaca w wyniku
	inc ecx
	mov al, [esi+1]	; cyfra jednosci z miesiaca
	mov [edi+ecx], al	; cyfra jednosci z miesiaca w wyniku
; zerowanie dnia dla kolejnych obiegow petli
	mov esi, offset dzien
	mov [esi], byte PTR 0
	mov [esi+1], byte PTR 0
; zdejmowanie rejestrow zzapisywania do wyniku
	pop ecx
	pop eax
	pop edi
	pop esi

; wypisywanie w konsoli
	push edx	; zapamietanie edx
	push dword PTR 6 ; push(dzien+dzien+'.'+miesiac+miesiac)
	push OFFSET wynik	; wartosc daty
	push dword PTR 1	; numer urzadzenia (numer ekranu=1)
	call __write
	add esp, 12	; zwolnienie pamieci po wypisaniu daty
	pop edx
; zerowanie wyniku dla kolejnego swieta
	push edi	; zapamietanie dotychczasowego edi aby wyzerowac wynik
	mov edi, offset wynik
	mov [edi], byte PTR 0	; dzien
	mov [edi+1], byte PTR 0	; dzien
	mov [edi+2], byte PTR '.'	; separator
	mov [edi+3], byte PTR 0	; miesiac
	mov [edi+ 4], byte PTR 0	; miesiac
	pop edi

	dec edx ; aby kolejny bit wziac pod uwage
	jnz ptl	; jeszcze nie ma konca miesiaca
	jmp koniec_miesiaca	
koniec_miesiaca:
	push 0
	call _ExitProcess@4
; _main ENDP
END