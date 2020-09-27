segment .data
	tab1 db "			"
	tam1 equ ($-tab1)
	tab2 db "						"
	tam2 equ ($-tab2)
	tab3 db "									"
	tam3 equ ($-tab3)
	tab4 db "												"
	tam4 equ ($-tab4)
	id dw 1
	
segment .bss
	ans resb 4
	
segment .text

	global _start
	
_start:

	mov eax, 3
	mov ebx, 2
	mov ecx, ans ;lee el numero
	mov edx, 4
	int 80h
	
	call _printtab ;imprime los tabs
	
	mov eax, 4
	mov ebx, 1
	mov ecx, ans ;imprime el numero
	mov edx, 4
	int 80h

	mov eax, id
	inc eax
	mov dword [id], eax
	
	;inc esi
	
	call _start
	
	mov eax, 1
	mov ebx, 0
	int 80h
	
_cambiarid:
	
	mov ecx, id
	mov edx, 4
	cmp ecx, edx
	je _cambiar
	ret
	
_cambiar:

	mov dword [id], 1
	ret
	
_printtab1:

	mov eax, 4
	mov ebx, 1
	mov ecx, tab1
	mov edx, tam1
	int 80h
	ret
	
_printtab2:

	mov eax, 4
	mov ebx, 1
	mov ecx, tab2
	mov edx, tam2
	int 80h
	ret
	
_printtab3:

	mov eax, 4
	mov ebx, 1
	mov ecx, tab3
	mov edx, tam3
	int 80h
	ret
	
_printtab4:

	mov eax, 4
	mov ebx, 1
	mov ecx, tab4
	mov edx, tam4
	int 80h
	ret

_printtab:

	;mov eax, id
	
	cmp esi, 1
	je _printtab1
	
	cmp esi, 2
	je _printtab2
	
	cmp esi, 3
	je _printtab3
	
	cmp esi, 4
	je _printtab4

	ret

times 510-($-$$) db 0
