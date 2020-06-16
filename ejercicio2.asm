org	100h

section .text

main:
	call texto  	;iniciamos modo texto
	mov si, 0000h	;lo mimso que: mov si, 0000h
	call warning
	mov di, 0000h ; lo mismo que: mov di, 0000h
	mov cx, [len]

save:   mov  bl, [pass+di]
		mov  [di+200h], bl   
		inc  di
		cmp di, 5d
		jbe  save

lupi:
	call kb
	cmp al, "e" ;   "h o l a $"
				;si; 0 1 2 3 4
	je	comparar
	mov	[300h+si], al
	inc si
	jmp lupi

comparar:
	cmp si, 5d
	jne lenghtnotequal
	mov di, 0000h
	mov cx, 5d

compararcar:
	mov al, [di+200h]
	mov ah, [di+300h]
	cmp al,ah 
	jne notequal
	inc di
	jz same
	loop compararcar
	
same:
	call phrase3
	call kb
	int 20h

notequal:
	call phrase2
	call kb
	jmp main

lenghtnotequal:
	call phrase1
	call kb
	jmp main

texto:	mov 	ah, 00h
	mov	al, 03h
	int 10h
	ret

kb:
	XOR AX,AX 
	int 16h	
	ret	

w_char:	mov 	ah, 09h
	mov 	al, cl
	mov 	bh, 0h
	mov 	bl, 00001111b
	mov 	cx, 1h
	int 	10h
	ret

m_cursr:mov 	ah, 02h
	mov 	dx, di  ; columna
	mov 	dh, 17d ; fila
	mov 	bh, 0h
	int 	10h
	ret

m_cursrMess:mov 	ah, 02h
	mov 	dx, di  ; columna
	mov 	dh, 10d ; fila
	mov 	bh, 0h
	int 	10h
	ret


phrase1:	mov 	di, 30d
lupi1:	mov 	cl, [str1+di-30d]
	call    m_cursr
	call 	w_char
	inc	di
	cmp 	di, len1
	jb	lupi1
	ret

phrase2:	mov 	di, 30d
lupi2:	mov 	cl, [str2+di-30d]
	call    m_cursr
	call 	w_char
	inc	di
	cmp 	di, len2
	jb	lupi2
	ret

phrase3:	mov 	di, 30d
lupi3:	mov 	cl, [str3+di-30d]
	call    m_cursr
	call 	w_char
	inc	di
	cmp 	di, len3
	jb	lupi3
	ret

warning:	mov 	di, 13d
lupi4:	mov 	cl, [msg_cinco+di-13d]
	call    m_cursrMess
	call 	w_char
	inc	di
	cmp 	di, l_cinco
	jb	lupi4
	ret
	
section .data

    pass  db "camot"
    len  equ $-pass
	str1  db "LONGITUDES DIFERENTES "
	len1 equ $-str1+30d
	str2 db "CONTRASENIA INCORRECTA "
	len2 equ $-str2+30d
	str3 db "BIENVENIDO "
	len3 equ $-str3+30d
	msg_cinco db "MAX LENGHT 5 PRESS E TO VERIFY "
	l_cinco equ $-msg_cinco+13d


