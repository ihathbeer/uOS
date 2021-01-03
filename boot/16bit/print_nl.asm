print_nl:
    pusha          ; save registers to stack
    mov ah, 0x0e   ; set tty
    mov al, 0x0a   ; print new line chr  
    int 0x10       ; print via interrupt 
    mov al, 0x0d   ; print carriage return
    int 0x10       ; print via interrupt
    popa           ; restore registers
    ret
