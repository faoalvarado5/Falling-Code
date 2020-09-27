[bits 16] ; use 16 bits
[org 0x7c00] ; sets the start address

start:

	mov al, 13h
	mov ah, 0
	int 10h
	
	mov dh, 1
	mov dl, 1
	mov bh, 0
	mov ah, 2
	int 10h
	
	call code
	
code:

	mov ah, 00h
	int 16h
	
	call _moveCursor
	
	call _imprimir
	
	inc ch
	
	call code

_moveCursor:

	inc dh
	inc dh
	mov ah, 2
	int 10h
	ret

_imprimir:
	
	mov bh, 0
	mov cx, 1
	mov ah, 09h
	mov bl, 0x0E
	int 10h
	ret

times 510-($-$$) db 0 ; fill the output file with zeroes until 510 bytes are full 
dw 0xaa55 ; magic number that tells the BIOS this is bootable
