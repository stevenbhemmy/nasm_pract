		global	_start
		section .text
_start:
	mov	rdx,	output ; rdx holds adddress of next byte to write
	mov r8,	1	; initial line length
	mov r9,	0	; number of stars written on line so far
line:
	mov byte [rdx],	'*'	; write single star
	inc	rdx	; advance pointer to next cell to write
	inc r9	; "count" number of stars so far on line
	cmp	r9,	r8	; check if we reached the right number of stars yet
	jne	line
lineDone:
	mov	byte [rdx],	10	; write a new line char
	inc	rdx	; and move pointer to where next char goes
	inc	r8	; next line will be one char longer
	mov	r9,	0	; reset count of stars written on this line
	cmp	r8,	maxlines	; check if we're on the lest line
	jng	line
done:
	mov	rax,	1	; system call for write
	mov	rdi,	1	; stdout file handle
	mov	rsi,	output	; address of output bytes
	mov	rdx,	dataSize	; number of bytes
	syscall
	mov	rax,	60	; exit syscall
	xor rdi,	rdi	; exit code 0
	syscall

	section .bss
maxlines	equ	8
dataSize	equ	44
output:		resb	dataSize
	
