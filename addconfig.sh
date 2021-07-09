#!/bin/bash

# Description:
# Add your configuration to this git repository

# Color Sytle:
Red_font_prefix="\033[31m"
Green_font_prefix="\033[32m"
Yello_font_profix="\033[33m"
Blue_font_prefix="\033[34m"
Reset_font_suffix="\033[0m"

# Define variable or read files etc.
path_before=""
path_after="" 

# Define your functions here

#Get the path of configuration
function get_config_path() {
    if [ $# -eq 0 ]; then
        echo -e "${Red_font_prefix}Please enter a file name!!!${Reset_font_suffix}"
        exit 1
    fi

    if [[ ! -e $1 ]]; then
        echo -e "${Red_font_prefix}Please enter a valid file name!!!${Reset_font_suffix}"
        exit 1
    fi
    if [[ -L $1 ]]; then
        echo -e "${Red_font_prefix}Path is alread a symbol link!!!${Reset_font_suffix}"
        exit 1
    fi

    path_before=$(readlink -f "$1")
    path_after=${path_before/${HOME}\//}
    echo ${path_before}
    echo ${path_after}
}


# Move config and set a symbollink for it 
function set_links() {
    if [[ -e $path_after ]]; then
    	echo -e "${Red_font_prefix}The file or directory alread exists!${Reset_font_suffix}"
	exit 1
    fi
    mv -iv "${path_before}" "${path_after}" >/dev/null 2>&1
    ln -sfnv "$PWD/${path_after}" "${path_before}" >/dev/null 2>&1
    echo -e "${Green_font_prefix}The config add successful!!!${Reset_font_suffix}"
}


# Main script here

get_config_path "$@"
set_links
