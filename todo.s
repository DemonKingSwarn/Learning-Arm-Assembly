.data
menu: .ascii "1. Add\n2. View\n3. Exit\n> "
menu_len = . - menu
prompt: .ascii "Task: "
prompt_len = . - prompt
file: .asciz "todo.txt"

.bss
buffer: .space 256

.text
.global _start

_start:
loop:
    mov x8, 64
    mov x0, 1
    adrp x1, menu
    add x1, x1, :lo12:menu
    mov x2, menu_len
    svc 0

    mov x8, 63
    mov x0, 0
    adrp x1, buffer
    add x1, x1, :lo12:buffer
    mov x2, 2
    svc 0

    adrp x1, buffer
    add x1, x1, :lo12:buffer
    ldrb w0, [x1]

    cmp w0, '1'
    beq add_task
    cmp w0, '2'
    beq view_tasks
    cmp w0, '3'
    beq exit_app
    b loop

add_task:
    mov x8, 64
    mov x0, 1
    adrp x1, prompt
    add x1, x1, :lo12:prompt
    mov x2, prompt_len
    svc 0

    mov x8, 63
    mov x0, 0
    adrp x1, buffer
    add x1, x1, :lo12:buffer
    mov x2, 256
    svc 0
    mov x10, x0

    mov x8, 56
    mov x0, -100
    adrp x1, file
    add x1, x1, :lo12:file
    mov x2, 1089
    mov x3, 420
    svc 0
    mov x9, x0

    mov x8, 64
    mov x0, x9
    adrp x1, buffer
    add x1, x1, :lo12:buffer
    mov x2, x10
    svc 0

    mov x8, 57
    mov x0, x9
    svc 0

    b loop

view_tasks:
    mov x8, 56
    mov x0, -100
    adrp x1, file
    add x1, x1, :lo12:file
    mov x2, 0
    mov x3, 0
    svc 0
    cmp x0, 0
    blt loop
    mov x9, x0

read_loop:
    mov x8, 63
    mov x0, x9
    adrp x1, buffer
    add x1, x1, :lo12:buffer
    mov x2, 256
    svc 0
    cmp x0, 0
    ble close_file

    mov x2, x0
    mov x8, 64
    mov x0, 1
    adrp x1, buffer
    add x1, x1, :lo12:buffer
    svc 0
    b read_loop

close_file:
    mov x8, 57
    mov x0, x9
    svc 0
    b loop

exit_app:
    mov x8, 93
    mov x0, 0
    svc 0
