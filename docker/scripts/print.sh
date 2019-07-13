#!/bin/bash
###########################################################
# print --color COLOR --frame MESSAGE
#
# Copyright (c) Marcos Gomes-Borges
###########################################################

red="\033[91m"
green="\033[92m"
yellow="\033[93m"
blue="\033[94m"
magenta="\033[95m"
nc="\033[39m"

# Print a formated message: print <color> <frame> "message"
print() {
    case ${#} in
        "1") COLOR=nc; FRAME=false; MSG=${1} ;;
        "2") COLOR=${1}; FRAME=false; MSG=${2} ;;
        "3") COLOR=${1}; FRAME=${2}; MSG=${3} ;;
    esac

    if [[ ${FRAME} = "frame" ]]; then
        printf "${!COLOR}$(printf "=%0.s" {0..79})\n"
        printf "${!COLOR}${MSG}"
        printf "${!COLOR}$(printf "=%0.s" {0..79})\n"
    else
        printf "${!COLOR}${MSG}"
    fi

    printf "${nc}"
}