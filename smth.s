.data
	hello: .ascii "Hello Friend\n"
	.set helloLen, . - hello

.text
.global _start

_start:
	bl your_mom

your_mom:
	mov x0, #1
	adrp x1, hello
	add x1, x1, :lo12:hello
	mov x2, #helloLen
	mov x8, #64
	svc #0

	mov x0, #0
	mov x8, #93
	svc #0
