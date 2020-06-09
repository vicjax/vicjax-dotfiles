#!/bin/bash

# Auto install your apps using script

echo -e "Please choise the way you install packages:\r\n"
echo -e "(1) yum   (2) apt-get   (3)pacman\r\n"
read -p "Input a num(default=3):" -r option
package="pacman -S"
case ${option} in 
    "1") package="yum isntall"
    ;;
    "2") package="apt-get install"
    ;;
    "3") package="pacman -S"
    ;;
esac
echo -e "Your package manager has been set as \u001b[32;1m ${package}\u001b[0m !\r\n"


echo -e "Checking the necessary tools... \r\n"
echo -e "\u001b[31;1mNote:These tools must be installed before the next step!\u001b[0m\r\n"
for tool in "git" "curl" "wget"
do
    which "${tool}" >/dev/null 2>&1
    if [[ $? -eq 0 ]]
    then 
        echo -e "-->\u001b[32;1m ${tool} \u001b[0m has been installed.^_^\r\n"
    else 
        echo -e "!!!\u001b[33;1m ${tool} \u001b[0m is not insalled,installing..."
        echo -e "And maybe you should enter your password."
        sudo ${package} ${tool}
        if [[ $? -eq 0 ]] 
        then
            echo -e "-->\u001b[32;1m ${tool} \u001b[0m has installed successfull^_^"
        else
            echo -e "-->\u001b[31;1m ${tool} \u001b[0m has installed fail,you must install it manually!(like using \"sudo ${package} ${tool}\")\r\n"
        fi
    fi
done 

echo -e "Checking the applications you want to config... \r\n"
echo -e "\u001b[31;1mNote:You only need to install the apps you want to configure!\u001b[0m"
for tool in "vim" "nvim" "ranger" "zsh" "fzf" "alacritty"
do
    which "${tool}" >/dev/null 2>&1
    if [[ $? -eq 0 ]]
    then 
        echo -e "-->\u001b[32;1m ${tool} \u001b[0m has been installed.^_^\r\n"
    else 
        echo -e "!!!\u001b[33;1m ${tool} \u001b[0m is not insalled,installing..."
        echo -e "And maybe you should enter your password.\r\n" 
        echo -e "\u001b[31;1mNote:If you do not want to install this software,please type \"Ctrl-C\" install of password!!!\u001b[0m"
        sudo ${package} ${tool}
        if [[ $? -eq 0 ]] 
        then
            echo -e "-->\u001b[32;1m ${tool} \u001b[0m has installed successfull^_^"
        else
            echo -e "-->\u001b[31;1m ${tool} \u001b[0m has installed fail,you must install it manually!(like using \"sudo ${package} ${tool}\")\r\n"
        fi
    fi
done 
