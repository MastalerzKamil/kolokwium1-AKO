.686
.model flat
extern _ExitProcess@4 : PROC
;public _main
.data
.code
;_main PROC
	;mov v2, 11111h	;za duzy rozmiar liczby przekazywanej do v2
	call _ExitProcess@4
;_main ENDP
END