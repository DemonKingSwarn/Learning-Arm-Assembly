.data
	buffer: .fill 20, 1, 0
	newline: .ascii "\n"

.text

.global _start

_start:
	bl your_mom

your_mom:
	mov w0, #69
	mov w1, #420
	mul w2, w0, w1

	adrp x4, buffer
	add x4, x4, :lo12:buffer
	add x4, x4, #19
	mov w1, #10
	mov x8, #64
	svc #0

convert:
	udiv w3, w2, w1
	msub w5, w3, w1, w2
	add w5, w5, #48
	strb w5, [x4], #-1
	mov w2, w3
	cbnz w2, convert

	mov x8, #64
	mov x0, #1
	add x1, x4, #1
	mov x2, #20
	svc #0

	mov x8, #93
	mov x0, #0
	svc #0

