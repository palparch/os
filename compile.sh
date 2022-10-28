#! /usr/bin/bash

set -e

binfile="bootloader.bin"
server="palpatine"
serverdir="/home/tuilip/osdev"
serverloc="$server:$serverdir"
qemu="qemu-system-x86_64"

while getopts ":f:o:" option; do
    case $option in
        f)
            cat /dev/null > $binfile
            for i in $OPTARG; do
                nasm -f bin $i.asm -o $i.bin
                cat $i.bin >> $binfile
            done
            ;;
        o)
            echo "$OPTARG"
            case "$OPTARG" in
                "local")
                    $qemu "$binfile" 
                ;;
                "server")
                    scp "$binfile" "$serverloc"/
                    ssh "$server" "$qemu $serverdir/$binfile -nographic"
                ;;
                "nothing")
                    exit 0
                ;;
                *)
                    echo $"Usage: $0 { local | server | nothing }"
                    exit 1
            esac            
        ;;
    esac
done

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
