section .bss
	name resb 16

section .text
	global _start
_start:

	call _getName
	call _printName

	mov eax, 60
	mov ebx, 0
	int 80h

_getName:
	mov eax, 3
	mov ebx, 2
	mov ecx, name
	mov edx, 16
	int 80h
	ret

_printName:
	mov eax, 4
	mov ebx, 1
	mov ecx, name
	mov edx, 16
	int 80h
	ret
