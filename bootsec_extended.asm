[org 0x7e00]

jmp EnterProtectedMode

%include "print.asm"
%include "gdt.asm"

KCDataPort equ 0x60
KCCommandPort equ 0x64
KCDisableKbd equ 0xAD
KCEnableKbd equ 0xAE
KCReadOutputPort equ 0xD0
KCWriteOutputPort equ 0xD1

EnterProtectedMode:
    call EnableA20
    cli ; disable interrupts
    lgdt [gdt_descriptor]
    mov eax, cr0
    or al, 1
    mov cr0, eax
    jmp codeseg:StartProtectedMode

EnableA20:
    ; disable keyboard
    call A20WaitInput
    mov al, KCDisableKbd
    out KCCommandPort, al

    call A20WaitInput
    mov al, KCReadOutputPort
    out KCCommandPort, al

    call A20WaitOutput
    in al, KCDataPort
    push eax

    call A20WaitInput
    mov al, KCWriteOutputPort
    out KCCommandPort, al

    call A20WaitInput
    pop eax
    or al, 2
    out KCDataPort, al

    ; enable keyboard
    call A20WaitInput
    mov al, KCEnableKbd
    out KCCommandPort, al

    call A20WaitInput
    ret

A20WaitInput:
    in al, KCCommandPort
    test al, 2
    jnz A20WaitInput
    ret

A20WaitOutput:
    in al, KCCommandPort
    test al, 1
    jz A20WaitOutput
    ret

[bits 32]
StartProtectedMode:
    mov ax, dataseg
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov [0xb80000], byte 'H'
    mov [0xb80002], byte 'e'
    mov [0xb80004], byte 'l'
    mov [0xb80006], byte 'l'
    mov [0xb80008], byte 'o'

    jmp $

times 2048-($-$$) db 0
