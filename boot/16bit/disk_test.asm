[org 0x7c00]

mov bp, 0x8000       ; set stack start addr
mov sp, bp

mov bx, 0x9000      ; set bx (end address to read to)
mov dh, 2           ; set sectors to load
; mov dl, 0         ; set disk number (unneeded, bios sets it)

call disk_load

mov dx, [0x9000] ; print first loaded word
call print_hex
call print_nl

mov dx, [0x9000 + 512] ; print first loaded from 2nd sector (after boot)
call print_hex

jmp $

%include "print_string.asm"
%include "print_hex.asm"
%include "print_nl.asm"
%include "disk_load.asm"

; padding
times 510-($-$$) db 0
dw 0xaa55

; add more sectors for testing purposes
times 256 dw 0xbeef
times 256 dw 0xc0ff
