print_hex:
    pusha       ; save registers to stack
    ; Goal: manipulate chars in HEX_OUT to reflect dx
    mov bx, 5   ; offset to write to HEX_OUT
    
    ; Take the right most 4 bits and convert them
    ; to corresponding character; rotate the byte string to the right
    ; each time until all characters have been converted
    rol dx, 4   ; rotate left
.next:
    ror dx, 4   ; rotate right
    mov al, dl
    and al, 15  ; get lower 4 bits
    add al, '0' ; convert to string
    cmp al, '9' ; check if it is a digit
    jbe .update_str
    add al, 7   ; bridge gap to 'A'-'F'
.update_str:
    mov [HEX_OUT + bx], al ; update HEX_OUT
    dec bx                 ; decrement offset
    cmp bx, 2              ; repeat if offset >= 2
    jae .next                  
    mov bx, HEX_OUT        ; print HEX_OUT
    call print_string
    popa                   ; restore registers
    ret

HEX_OUT: db '0x0000', 0
