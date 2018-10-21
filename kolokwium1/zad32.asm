; int ecx = 0;
; int edx = 0;
; while(eax != 0) {
;	edx %= 10;
;	eax /= 10;
;	ecx += edx;
;}

.686
.model flat
extern _ExitProcess@4 : PROC
public _main
.data
liczba	dd 10
.code
_main PROC
	mov ebx, 10
	mov eax, 125 ; dla testu. ECX powinien wynosiæ 00000008
	mov ecx, 0	; zeruje ecx bo to jest sumator cyfr liczby dziesietnej
	mov edx, 0	; w edx jest reszta z dzielenia po operacji DIV
ptl:
	div liczba
	add ecx, edx	; zwiekszenie ecx o reszte z dzielenia. 
					; Po operacji DIV op EDX zawiera reszte z dzielenia a EAX liczbe calkowita z dzielenia
	mov edx, 0		; zeruje reszte aby nie wskoczyla na starsza czesc dzielnej (licznika w dzieleniu)
	cmp eax, 0
	jnz ptl
	nop
	call _ExitProcess@4
_main ENDP
END