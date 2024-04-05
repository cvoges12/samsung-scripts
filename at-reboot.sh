#!/bin/sh

# Check if no arguments were passed
if [ $# -eq 0 ]; then
    printf "# 
# Samsung at-reboot script
#

reboot <argument>
    no argument - Reboot
    download - Download Mode
    download2 - Download Mode (alternative method)
"
    exit 1
fi

# Loop through all arguments
while (( "$#" )); do
    case $1 in
        "reboot")
            shift # Remove 'reboot' from the list of arguments
            if [ "$1" ]; then
                case $1 in
                    "download")
                        printf "Rebooting to Download Mode... \nAT+SUDDLMOD -> /dev/ttyACM0\n"
                        echo "AT+SUDDLMOD=0,0" > /dev/ttyACM0
                        ;;
                    "download2")
                        printf "Rebooting to Download Mode... \nAT+FUS? -> /dev/ttyACM0\n"
                        echo "AT+FUS?" > /dev/ttyACM0
                        ;;
                    *)
                        echo "Unknown reboot mode: $1"
                        ;;
                esac
                shift # Remove the reboot mode argument
            else
                printf "Rebooting device... \nAT+CFUN=1,1 -> /dev/ttyACM0\n"
                echo "AT+CFUN=1,1" > /dev/ttyACM0
            fi
            ;;
        "download")
            echo "Error: 'download' must be a sub-argument of 'reboot'"
            exit 1
            ;;
        "binary")
            echo "Error: 'binary' must be a sub-argument of 'reboot'"
            exit 1
            ;;
        # Add more arguments to check for here
        *)
            echo "Unknown argument: $1"
            shift # Remove the unknown argument
            ;;
    esac
done
