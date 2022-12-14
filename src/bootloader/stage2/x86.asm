bits 16

section _TEXT class=CODE

global _WriteChar
_WriteChar:
    push bp
    mov bp, sp

    push bx

    pop bx

    mov sp, bp
    pop bp
    ret

msg_x86: db 'This is x86' , 0x0D, 0x0A, 0
