BITS 16
mov ah, 0x0e
mov al, 'A'
int 0x10
inc al
int 0x10
inc al
int 0x10
mov al, 'O'
int 0x10
jmp $
times 510-($-$$) db 0
