#! /usr/bin/bash

#set -e

while getopts ":fw:" option; do
    case $option in
        f) # display Help
            #cat /dev/null > bootloader.bin
            #for i in $OPTARG; do
                #nasm -f bin $i.asm -o $i.bin
                #cat $i.bin >> bootloader.bin
            youname="$OPTARG"   
            echo $OPTARG
            #done
            #qemu-system-x86_64 -nographic bootloader.bin
        ;;
        w)
            echo "i work hard (he works hard) every day of my life"
        ;;
    esac
done

echo "$youname"

#case "$1" in
#    "--files")
#        cat /dev/null > bootloader.bin
#        for i in $@; do
#            nasm -f bin $i.asm -o $i.bin
#            cat $i.bin >> bootloader.bin
#        done
#        qemu-system-x86_64 -nographic bootloader.bin
#        ;;
#    *)
#        echo "I don't understand:" $@
#        exit 1
#esac
