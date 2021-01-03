[org 0x7c00]
    KERNEL_OFFSET equ 0x1000 ; memory offset kernel is loaded

    mov [BOOT_DRIVE], dl ; set boot drive
    mov bp, 0x9000       ; setup stack
    mov sp, bp
        
    ; print that we are in 16-bit mode
    mov bx, MSG_REAL_MODE
    call print_string
    call print_nl

    ; load kernel
    call load_kernel

    ; switch to 32-bit protected mode
    call switch_to_pm
    ; loop forever
    jmp $

%include "16bit/print_string.asm"
%include "16bit/print_hex.asm"
%include "16bit/print_nl.asm"
%include "gdt.asm"
%include "print_string_pm.asm"
%include "pm_switch.asm"
%include "16bit/disk_load.asm"

[bits 16]
load_kernel:
    ; print that we are loading kernel
    mov bx, MSG_LOAD_KERNEL
    call print_string
    call print_nl 

    ; setup param for disk_load
    mov bx, KERNEL_OFFSET
    mov dh, 2               ; set # of sectors
    mov dl, [BOOT_DRIVE]    ; set boot drive
    call disk_load

    ret
    
[bits 32]
BEGIN_PM:
    ; print that we're entering 32-bit protected mode
    mov ebx, MSG_PROT_MODE
    call print_string_pm

    call KERNEL_OFFSET  ; jump to kernel
    jmp $               ; loop forever

; define global vars
BOOT_DRIVE      db 0
MSG_REAL_MODE   db "Running in 16-bit mode", 0
MSG_PROT_MODE   db "Running in 32-bit protected mode", 0
MSG_LOAD_KERNEL db "Loading kernel into RAM", 0

; padding
times 510-($-$$) db 0
dw 0xaa55
