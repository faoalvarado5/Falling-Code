[bits 16] ; usa 16 bits
[org 0x7c00] ; setea la direccion inicial de memoria

start:

	mov al, 13h ;modo grafico 320x200 1 pagina 256 colores
	mov ah, 0
	int 10h
	
	mov ah, 06h    ; funcion de scroll up para pintar el fondo verde
	mov al, 00h     ; limpia la pantalla
	xor cx, cx     ; esquina superior izquierda ch=linea, cl=columna
	mov dx, 184FH  ; esquina inferior izquierda dh=lina, dl=columna 
	mov bh, 0x02    ; color verde la pantalla
	int 10h
	
	mov dh, 1 ;setea el cursor en la linea 1
	mov dl, 5 ;setea el cursor en la columna 5
	mov bh, 0 ;setea el cursor en la pagina 0
	mov ah, 2 
	int 10h
	
	call code
	
code:
	
	mov ah, 01h ;verifica si hay keystroke en el buffer
	int 16h
	jnz _inputcharacter ;brinca en caso de de zero flag sea 0
	
	call _timer
	
	call _printcharacterDefault
	
	jmp code
	
_printcharacterDefault:

	call _imprimirDefault

	mov dh, 1 ;setea el cursor en la linea 1
	mov dl, 5 ;setea el cursor en la columna 5
	mov bh, 0 ;setea el cursor en la pagina 0
	mov ah, 2 
	int 10h
	
	call _imprimirDefault
	
	mov dh, 2 ;setea el cursor en la linea 2
	mov dl, 15 ;setea el cursor en la columna 15
	mov bh, 0 ;setea el cursor en la pagina 0
	mov ah, 2 
	int 10h
	
	call _imprimirDefault
	
	mov dh, 1 ;setea el cursor en la linea 1
	mov dl, 25 ;setea el cursor en la columna 25
	mov bh, 0 ;setea el cursor en la pagina 0
	mov ah, 2 
	int 10h
	
	call _imprimirDefault
	
	mov dh, 2 ;setea el cursor en la linea 2
	mov dl, 35 ;setea el cursor en la columna 35
	mov bh, 0 ;setea el cursor en la pagina 0
	mov ah, 2 
	int 10h
	
	call _imprimirDefault
	
	call _scrollDown
	
	call code	

_imprimirDefault:
	
	mov al, 1 ;caracter default es 1 en ascii, el cual es una carita feliz
	mov bh, 0 ;imprime en la pagina 0
	mov cx, 1 ; imprime 1 vez el caracter en al
	mov ah, 09h ;
	mov bl, 0x0F ;imprime de color negro el caracter.
	int 10h
	ret
	
_printcharacter:

	call _imprimir

	mov dh, 1 ;setea el cursor en la linea 1
	mov dl, 5 ;setea el cursor en la columna 5
	mov bh, 0 ;setea el cursor en la pagina 0
	mov ah, 2 
	int 10h
	
	call _imprimir
	
	mov dh, 2 ;setea el cursor en la linea 2
	mov dl, 15 ;setea el cursor en la columna 15
	mov bh, 0 ;setea el cursor en la pagina 0
	mov ah, 2 
	int 10h
	
	call _imprimir
	
	mov dh, 1 ;setea el cursor en la linea 1
	mov dl, 25 ;setea el cursor en la columna 25
	mov bh, 0 ;setea el cursor en la pagina 0
	mov ah, 2 
	int 10h
	
	call _imprimir
	
	mov dh, 2 ;setea el cursor en la linea 2
	mov dl, 35 ;setea el cursor en la columna 35
	mov bh, 0 ;setea el cursor en la pagina 0
	mov ah, 2 
	int 10h
	
	call _imprimir
	
	call _scrollDown
	
	call code
	
_inputcharacter:

	mov ah, 00h ;lee el input del usuario y lo almacena en al
	int 16h
	
	call _printcharacter
	
_timer:
	
	mov cx, 20h ;intervalo de tiempo
	mov dx, 968h ; intervalo de tiempo
	mov ah, 86h ; aprox 2 segundos
	int 15h
	ret	

_scrollDown:

	mov ah, 07h    ; funcion de scroll down
	mov al, 3     ; linea que baja el scroll
	xor cx, cx     ; esquina superior izquierda ch=linea, cl=columna
	mov dx, 184FH  ; esquina inferior derecha dh=lina, dl=columna 
	mov bh, 0x02    ; color verde
	int 10h
	ret

_imprimir:
	
	mov bh, 0 ;imprime en la pagina 0
	mov cx, 1 ; imprime 1 vez el caracter en al
	mov ah, 09h ;
	mov bl, 0x0F ;imprime de color negro el caracter.
	int 10h
	ret

times 510-($-$$) db 0 ; llena el espacio restante con ceros hasta llegar a 510.
dw 0xaa55 ; numero magico que le avisa al BIOS que este programa es bootable.
