[bits 32]

VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f

print_string_pm:
    pusha
    mov edx, VIDEO_MEMORY

print_string_pm_loop:
    mov al, [ebx]           ; set char
    mov ah, WHITE_ON_BLACK  ; set attr

    cmp al, 0        ; check if it is null character
    je print_string_pm_done

    mov [edx], ax    ; render character via memory
    add ebx, 1       ; increment char index
    add edx, 2       ; move to next memory loc
    
    jmp print_string_pm_loop

print_string_pm_done:
    popa
    ret
