		global	_start
		section .text
_start:
	mov	rdx,	output ; rdx holds adddress of next byte to write
	mov r8,	maxlines ; initial line length
	mov r9,	0	; number of stars written on line so far
	mov r10, 0 ; total number of bytes written
line:
	mov byte [rdx],	'*'	; write single star
	inc	rdx	; advance pointer to next cell to write
	inc r10	; count another total byte
	inc r9	; "count" number of stars so far on line
	cmp	r9,	r8	; check if we reached the right number of stars yet
	jne	line
lineDone:
	mov	byte [rdx],	10	; write a new line char
	inc	rdx	; and move pointer to where next char goes
	inc r10	; count another total byte
	dec	r8	; next line will be one char shorter
	mov	r9,	0	; reset count of stars written on this line
	cmp	r8,	0; check if we're on the last line
	jg	line
done:
	mov	rax,	1	; system call for write
	mov	rdi,	1	; stdout file handle
	mov	rsi,	output	; address of output bytes
	; mov	rdx,	dataSize	; number of bytes
	mov	rdx, r10 ; number of bytes
	syscall
	mov	rax,	60	; exit syscall
	xor rdi,	rdi	; exit code 0
	syscall

	section .bss
maxlines	equ	8
dataSize	equ	44
output:		resb	dataSize
	
