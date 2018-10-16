.686
.model flat
extern _ExitProcess@4 : PROC
;public _main
.data

.code
;_main PROC
	clc ; czyscimy CF
	rcl eax, 1
	rcl ebx, 1
	rcl edx, 1
	jnc dalej
	bts eax, 0	;jesli po przesunieciu w ostatnim rejestrze byla 1 wtedy na 0 bicie eax pojawi sie 1 z CF
dalej:
	nop
	call _ExitProcess@4
;_main ENDP
END