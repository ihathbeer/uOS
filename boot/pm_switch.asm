[bits 16]

switch_to_pm:
    cli                   ; switch off interrupts until we have 32-bit IVT
    lgdt [gdt_descriptor] ; load descriptor table
    mov eax, cr0          ; set first bit of control register
    or eax, 0x1
    mov cr0, eax
    jmp CODE_SEG:init_pm  ; make far jump to flush CPU pipeline

[bits 32]
init_pm:
    mov ax, DATA_SEG    ; set data segment registers
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000    ; set stack position to top of free space
    mov esp, ebp
    call BEGIN_PM
