print_string:
    pusha          ; save registers to stack
    mov ah, 0x0e   ; set tty
print_chr:
    mov al, [bx]   ; move 4 bit character to al to print
    cmp al, 0      ; check if null character
    je the_end     ; call it a routine if null chr
    int 0x10       ; print via interrupt 
    add bx, 1      ; increment address of chr to print
    jmp print_chr  ; move onto next character
the_end:
    popa           ; restore registers
    ret
