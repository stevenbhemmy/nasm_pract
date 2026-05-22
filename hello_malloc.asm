; Writes hello world using C lib with malloc - Linux only
; Must be compiled / linked with clib
; To compile:
;	nasm -felf64 hello_malloc.asm && gcc -no-pie hello_malloc.o

	global	main
	extern	puts ; this tells us we'll be using an external function
	extern	malloc

	section	.text
main:
	push rbx ; call conventions means rbx must be saved
	mov rdi, 12 ; how much memory to reserve for malloc
	call	 malloc ; rax contains mem addr 
	mov	rbx,	11 ; length of message/loop counter
	lea rdx, [message]

mov_str:              ; loop to copy string into memory
	mov	cl, [rdx+rbx] ; we use cl so only a char gets copied
	mov	[rax+rbx], cl ; moving rcx would clobber memory with 64 bytes at a time
	dec rbx
	jns mov_str ; end loop

	mov	rdi,	rax ; pointer to malloc'd location in rdi
	call	puts	; call the c lib function
	pop rbx ; restore rbx
	ret

	section	.data
message: 
	db	"Hallo earth", 0 ; null terminated C-string
