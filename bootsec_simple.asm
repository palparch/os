[org 0x7c00]

mov [BOOT_DISK], dl
; boot drive number

mov bp, 0x7c00
mov sp, bp

;mov dx, 0x1fb6
;call print_hex

call ReadDisk

jmp PROGRAM_SPACE

%include "print.asm"
;%include "print_hex.asm"
%include "read_disk.asm"

times 510-($-$$) db 0
dw 0xaa55
