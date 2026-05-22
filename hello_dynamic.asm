; Writes hello world using C lib - Linux only
; Must be compiled / linked with clib
; To compile:
;	nasm -felf64 hello_c.asm && gcc -no-pie hello_c.o

	global	main
	extern	puts ; this tells us we'll be using an external function

	section	.text
main:
	mov	rdi,	message	; pointer to message in rdi
	call	puts	; call the c lib function
	ret

message: 
	db	"Hallo earth", 0 ; null terminated C-string
