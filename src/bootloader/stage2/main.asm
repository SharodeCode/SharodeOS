bits 16

section _ENTRY class=CODE

extern _cstart_
global entry

entry:
    call _cstart_

msg_stagetwo_main: db 'This is stage 2 of the main' , 0x0D, 0x0A, 0