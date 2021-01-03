; Global descriptor table

gdt_start:
gdt_null:  ; null descriptor
    dd 0x0 ; double word (4 bytes)
    dd 0x0 ; do it again

; Code segment descriptor
gdt_code:
    ; Legend:
    ; - 1st flags:
    ;   present (1) | privilege (00) | descriptor type (1)              = 1001
    ;   code (1) | conforming (0) | readable (1)  | accessed (0)        = 1010 
    ; - type flags:
    ;   code (1) | conforming (0) | readable (1) | accessed (0)         = 1010
    ; - 2nd flags:
    ;   granularity (1) | 32-bit default (1) | 64-bit seg (0) | AVL (0) = 1100
 
    dw 0xffff ; limit (0-15)
    dw 0x0    ; base (0-15)
    db 0x0    ; base (16-23)
    db 10011010b ; 1st flags & type flags
    db 11001111b ; 2nd flags & limit (16-19)
    db 0x0       ; base

; Code segment descriptor
gdt_data:
    ; - type flags:
    ;   code (0) | expand down (0) | writable (1) | accessed (0) = 0010 
    dw 0xffff ; limit (0-15)
    dw 0x0    ; base  (0-15)
    db 0x0    ; base  (16-23)
    db 10010010b ; 1st flags & type flags
    db 11001111b ; 2nd flags & limit
    db 0x0       ; base (24-31)
 
 gdt_end:

 gdt_descriptor:
    dw gdt_end - gdt_start - 1 ; size of our gdt
    dd gdt_start               ; start addr of our gdt

; define constants to indicate the start of each memory segment
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
