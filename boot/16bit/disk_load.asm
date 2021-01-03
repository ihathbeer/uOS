; dh = holds how many sectors to read
; dl = drive to load from
; es:bx = specifies where to read to
; disk_load: loads given number of sectors from specified disk
disk_load:
    pusha
    push dx      ; save dx to stack
    mov ah, 0x02 ; read sector function
    mov al, dh   ; read dh sectors
    mov ch, 0x00 ; set cylinder (0)
    mov dh, 0x00 ; set head (0)
    mov cl, 0x02 ; set sector (2)
    int 0x13     ; call interrupt to read from disk

    jc disk_error ; jump if disk error
    pop dx        ; restore dx
    cmp dh, al    ; check if we read as many sectors as req
    jne disk_error2 ; jump if disk error
    popa
    ret

disk_error:
    mov bx, DISK_ERROR_MSG
    call print_string       ; print msg
    jmp $                   ; infinite loop

disk_error2:
    mov bx, DISK_ERROR_MSG_2
    call print_string       ; print msg
    jmp $                   ; infinite loop

DISK_ERROR_MSG db "Error reading from disk!", 0
DISK_ERROR_MSG_2 db "Did not read correct # of sectors!", 0
