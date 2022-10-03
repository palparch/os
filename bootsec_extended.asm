[org 0x7e00]

mov bx, ExtendedSuccess
call PrintString

jmp $

%include "print.asm"

ExtendedSuccess:
    db 'Woohoo we are in extended space'

times 2048-($-$$) db 0
