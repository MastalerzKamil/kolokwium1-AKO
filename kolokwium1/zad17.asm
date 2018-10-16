.686
.model flat
extern _ExitProcess@4 : PROC
;public _main
.data

.code
;_main PROC
	mov eax, 1
	add ax, 0FFFFh; ZF=1 CF=1(bo nadmiar w rejestrze po operacji) OF=0
	nop
	call _ExitProcess@4
;_main ENDP
END