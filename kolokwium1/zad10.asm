.686
.model flat
extern _ExitProcess@4 : PROC
;public _main
.data
u2	dd	0

.code
;_main PROC
	mov ebx, -1
	mov u2, ebx
	shl ebx, 1
	jc ujemna	;gdy przesune ebx w lewo i bedzie CF=1 wtedy znaczy, ze ujemna
	mov ebx, u2	
	jmp koniec	;koniec konwertowania licznika dodatniej liczby
ujemna:	;poczatek konwersji ujemnej znak-modul
	mov ebx, u2
	dec ebx
	not ebx
	bts ebx, 31
koniec:
	call _ExitProcess@4
;_main ENDP
END