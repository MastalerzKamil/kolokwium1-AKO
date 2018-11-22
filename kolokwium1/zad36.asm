.686
.model flat
extern _ExitProcess@4 : PROC
public _main

.data
dlugosc_edi		dd 0
dlugosc_esi		dd 0
wyraz_edi		db 'kamil', 0
wyraz_esi		db 'kamil', 0

.code
_main PROC
	mov edi, offset wyraz_edi
	mov esi, offset wyraz_esi
;szukanie dlugosci wyrazow
	push eax	; zapamietywanie na czas obliczania dlugosci
	push edi
	push ecx
	mov ecx, 0
	mov al, 0 ; w al znak graniczny wyznaczania dlugosci
	mov ecx, -1 ; szukanie calej pamieci 4GB
	cld	; aby edi<-edi+1 w scasb
	repne scasb ;wyznaczanie dlugosci pierwszegowyrazu spod adresu edi
	sub ecx, -1	;program liczy cala pamiec wiec trzeba obliczyc rzeczywista dlugosc
	neg ecx	; aby miec pewnosc dodatniej dlugosci
	mov dlugosc_edi, ecx

;szukanie dlugosci wyrazu spod esi
	mov ecx, -1
	mov edi, esi	; adres poczatku wyrazu spod esi laduje do edi aby uzyc repe scasb
	repne scasb
	sub ecx, -1 ; obliczenie rzeczywistej dlugosci wyrazu
	neg ecx	; gwarancja dodatniej dlugosci
	mov dlugosc_esi, ecx
	pop ecx
	pop edi
	pop eax

; porownanie dlugosci slowa
	push ecx
	push eax
	push ebx
	mov eax, dlugosc_esi
	mov ebx, dlugosc_edi
	cmp eax, ebx
	jz rowna_dlugosc
	sub eax, ebx
	ja esi_wiekszy	; edi powinien byc pierwszy w slowniku
	jmp edi_wiekszy	; esi powinien byc pierwszy w slowniku
rowna_dlugosc:
	mov ecx, 0
ptl_rowne:
	mov al, [esi+ecx]
	mov bl, [edi+ecx]
	inc ecx
	cmp al, bl
	jne porownaj_znaki	; jesli nie rowne trzeba porownac i to zdecyduje ktory powininen byc pierwszy w slowniku
	cmp ecx, dlugosc_esi	; w rownej dlugosci wyrazach nie ma znaczenia ktora dlugosc  wezme
	jb ptl_rowne
	clc	; CF=0 ZF=1 <- identyczne bo przeszlo petle bez jump
	jmp koniec_programu
porownaj_znaki:
	cmp al, bl	; sprawdzam ponowie znaki spod al i bl. Te same co w poprzednim porowaniu
	ja edi_pierwszy	; wyraz spod EDI musi byc pierwszy w slowniku
	clc	; CF=0 ZF=0 czyli wyraz podadresem w esi pierszy w slowniku
	jmp koniec_programu	; bo ustawione CF=0 ZF=0 (skoro wynik operacji cmp rozny od zera wtedy ZF=0)
edi_pierwszy:
	stc
	jmp koniec_programu
; porownywanie gdy dlugosci nie sa rowne
esi_wiekszy:	; gdy wyraz pod adresem w edi krotszy od esi
	mov ecx, 0
ptl_esi_wiekszy:
	mov al, [esi+ecx]
	mov bl, [edi+ecx]
	cmp al, bl
	inc ecx
	jne porownaj_znaki
	cmp ecx, dlugosc_edi	; bo pod wyraz pod adresem w edi krotszy
	jb ptl_esi_wiekszy
edi_wiekszy:
	mov ecx, 0
ptl_edi_wiekszy:
	mov al, [esi+ecx]
	mov bl, [esi+ecx]
	cmp al, bl
	inc ecx
	jne porownaj_znaki
	cmp ecx, dlugosc_esi	; bo wyraz pod adresem w esi krotszy
	jb ptl_edi_wiekszy
koniec_programu:
	pop ebx
	pop eax
	pop ecx
	push 0
	call _ExitProcess@4
_main ENDP
END