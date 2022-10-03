#! /usr/bin/bash

if [[ $# == 1 ]]; then
    echo "Argument is:" 1
    nasm -f bin $1.asm -o $1.bin
    qemu-system-x86_64 -nographic $1.bin

elif [[ $# -ge 2 ]]; then
    echo "Arguments are more than 2" 
    cat /dev/null > bootloader.bin
    for i in $@; do
        nasm -f bin $i.asm -o $i.bin
        cat $i.bin >> bootloader.bin
    done
    qemu-system-x86_64 -nographic bootloader.bin

else
    echo "I don't understand:" $@
fi
