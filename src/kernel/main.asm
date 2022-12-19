org 0x7C00
bits 16

start:
    jmp main

puts:
    ;Save registers for later since we will modify
    push si
    push ax

.loop:
    lodsb                   ;Loads next character into AL register
    or al, al               ;Check end of string (NULL) character
    jz .done

    mov ah, 0x0e            ;Call bios interrupt to print to screen
    int 0x10

    jmp .loop

.done:
    pop ax                  ;Return AX register to original state
    pop si                  ;Return SI register to original state
    ret

main:
    ;Setup data segments
    mov ax, 0
    mov ds, ax
    mov es, ax

    ;Setup stack
    mov ss, ax
    mov sp, 0x7C00

    mov si, msg_first_line
    call puts

.halt:
    jmp .halt

msg_first_line: db 'This is the kernel' , 0x0D, 0x0A, 0

times 510-($-$$) db 0
dw 0AA55h