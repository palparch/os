%include "print.asm"

PrintHex:
    


    mov bx, HexOut
    call PrintString
    ret

HexOut:
db '0x0000',0
