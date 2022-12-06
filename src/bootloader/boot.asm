org 0x7C00
bits 16

jmp short start
nop

# ---------------BIOS Parameter Block (BPB)---------------- #
bpb_oem:                     db 'MSWIN4.1'
bpb_bytes_per_sector:        dw 512
bpb_sectors_per_cluster:     db 1
bpb_reserved_sectors:        dw 1
bpb_file_allocation_tables:  db 2
bpb_root_dir_entries:        dw 0E0h
bpb_total_sectors:           dw 2880
bpb_media_descriptor_type:   dB 0F0h
bpb_sectors_per_fat:         dw 9
bpb_sectors_per_track:       dw 18
bpb_number_of_heads:         dw 2
bpb_hidden_sectors:          dd 0
bpb_large_sector_count:      dd 0

# ---------------Extended Boot Record (EBR)---------------- #
ebr_drive_number:           db 0
                            db 0
ebr_signature:              db 28h
ebr_volume_id:              db 17h, 01h, 19h, 94h
ebr_volume_label:           db 'SHARODE OS '
ebr_system_id:              db 'FAT12   '


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

    mov si, msg_second_line
    call puts

.halt:
    jmp .halt

msg_first_line: db 'Wake up, Neo.' , 0x0D, 0x0A, 0
msg_second_line: db 'Follow the White Rabbit.' , 0x0D, 0x0A, 0

times 510-($-$$) db 0
dw 0AA55h