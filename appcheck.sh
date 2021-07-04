#!/bin/bash

# Description:
# 


# Color Sytle:
# For more awesome experience set some color style
# Usually, we expect you just use those fields without any change
Red_font_prefix="\033[31m"
Green_font_prefix="\033[32m"
Yello_font_prefix="\033[33m"
Blue_font_prefix="\033[34m"
Reset_font_suffix="\033[0m"


# Define variable or read files etc.
pkgmgr="pacman -S"
apps_dependencies=( "git" "curl" "wget" )
apps_want_to_config=( $(awk '{print $1}' ./apps_want2config) )


# Use features as functions is a better way
# Define your functions here
choise_pkgmgr() {
    echo -e "Please choise the way you install packages:\r\n"
    echo -e "(1) yum   (2) apt-get   (3)pacman\r\n"
    read -p "Input a num(default=3):" -r option
    pkgmgr="pacman -S"
    case ${option} in 
        "1") pkgmgr="yum isntall"
        ;;
        "2") pkgmgr="apt-get install"
        ;;
        "3") pkgmgr="pacman -S"
        ;;
    esac
    echo -e "Your package manager has been set as ${Green_font_prefix} ${pkgmgr} ${Reset_font_suffix} !\r\n"
}

check_dependencies() {
    echo -e "Checking the necessary tools... \r\n"
    echo -e "${Green_font_prefix}Note:These tools must be installed before the next step!${Reset_font_suffix}\r\n"
    for tool in ${apps_dependencies[*]}
    do
        which "${tool}" >/dev/null 2>&1
        if [[ $? -eq 0 ]]
        then 
            echo -e "\t-->${Green_font_prefix} ${tool} ${Reset_font_suffix} has been installed.^_^\r\n"
        else 
            echo -e "!!!${Yello_font_prefix} ${tool} ${Reset_font_suffix} is not insalled,installing..."
            echo -e "And maybe you should enter your password."
            sudo ${pkgmgr} ${tool}
            if [[ $? -eq 0 ]] 
            then
                echo -e "\t-->${Green_font_prefix} ${tool} ${Reset_font_suffix} has installed successfull^_^"
            else
                echo -e "\t-->${Red_font_prefix} ${tool} ${Reset_font_suffix} has installed fail,you must install it manually!(like using \r\t\r\t\"sudo ${pkgmgr} ${tool}\"\r\t\r\t)\r\n"
            fi
        fi
    done 

}

Install_app_want_to_config() {

    echo -e "Checking the applications you want to config... \r\n"
    echo -e "${Red_font_prefix}Note:You only need to install the apps you want to configure!${Reset_font_suffix}\r\n"
    for appname in ${apps_want_to_config[*]}
    do
        if [[ $appname = $(awk -F@ '{print $1}' ./apps_need_fix) ]]
            then 
            command=$(awk -F@ '{print $2}' ./apps_need_fix)
            else
            command=$appname
        fi
        which "${command}" >/dev/null 2>&1
        if [[ $? -eq 0 ]]
        then 
            echo -e "\t-->${Green_font_prefix} ${appname} ${Reset_font_suffix} has been installed.^_^\r\n"
        else 
            echo -e "!!!${Yello_font_prefix} ${appname} ${Reset_font_suffix} is not insalled,installing..."
            echo -e "And maybe you should enter your password.\r\n" 
            echo -e "${Red_font_prefix}Note:If you do not want to install this software,please type \"Ctrl-C\" install of password!!!${Reset_font_suffix}"
            sudo ${pkgmgr} ${appname}
            if [[ $? -eq 0 ]] 
            then
                echo -e "\t-->${Green_font_prefix} ${appname} ${Reset_font_suffix} has installed successfull^_^"
            else
                echo -e "\t-->${Red_font_prefix} ${appname} ${Reset_font_suffix} has installed fail,you must install it manually!(like using \"sudo ${pkgmgr} ${tool}\")\r\n"
            fi
        fi
    done 

}

# Main script here
choise_pkgmgr
check_dependencies
Install_app_want_to_config





