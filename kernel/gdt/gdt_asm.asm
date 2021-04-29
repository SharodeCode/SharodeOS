global gdt_load
extern gdt_first
gdt_load:
    lgdt [gdt_first]
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax
    jmp 0x08:flush2
flush2:
    ret