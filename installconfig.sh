#!/bin/bash

# Auto detect your app and copy configeration for apps your have installed

echo -e "\u001b[32;1m Configuring your docfiles...\u001b[0m"
echo
echo -e "\t\u001b[37;1m Seletc an option:\u001b[0m"
echo -e "\t\u001b[34;1m (1) Install oh-my-zsh \u001b[0m"
echo -e "\t\u001b[34;1m (2) Install zsh plugins \u001b[0m"
echo -e "\t\u001b[34;1m (3) Install neovim plugins manager \u001b[0m"
echo -e "\t\u001b[34;1m (4) Setup symlinks \u001b[0m"
echo -e "\t\u001b[34;1m (5) Unetup symlinks \u001b[0m"
echo -e "\t\u001b[34;1m (0) Install Exit \u001b[0m"
echo
echo -e "\t\u001b[32;1m ==> \u001b[0m\c"

read -r option

case $option in

    "1")echo -e "\u001b[7m Install oh-my-zsh... \u001b[0m"
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	;;
    "2")echo -e "\u001b[7m Install zsh plugins... \u001b[0m"
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	;;
    "3")echo -e "\u001b[7m Install neovim plugin manager... \u001b[0m"
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	;;
    "4")echo -e "\r\n\u001b[7m Setup symlinks... \u001b[0m\r\n"

	# Before setup symlinks we should unsetup old symlinks
	for config in ".Xresources" ".vimrc" ".zshrc" ".config/alacritty" ".config/i3" ".config/nvim" ".config/ranger"
    do
		# echo -e "\u001b[36;1m Detecting files ~/${config} to ~/${config}.bkp.. \u001b[0m"
		mv -iv ~/${config}.bkp ~/${config}.bkp.bkp >/dev/null 2>&1 
		if [[ $? -eq 0 ]]
		then
			rm ~/${config}
			mv -iv ~/${config}.bkp.bkp ~/${config} >/dev/null 2>&1
			# echo -e "\u001b[32;1m Unsetup symlinks of ~/${config} successful \u001b[0m\r\n"
		# else
			# echo -e "\u001b[31;1m ~/${config} has not backup \u001b[0m\r\n"
		fi
	done

	# Begin setup symlinks
    for config in ".Xresources" ".vimrc" ".zshrc" ".config/alacritty" ".config/i3" ".config/nvim" ".config/ranger"
    do
		echo -e "\u001b[36;1m Backup existing files ~/${config} to ~/${config}.bkp.. \u001b[0m"
		mv -iv ~/${config} ~/${config}.bkp >/dev/null 2>&1
		if [[ $? -eq 0 ]]
		then
			ln -sfnv $PWD/${config} ~/${config}
			echo -e "\u001b[32;1m Add symlinks of ~/${config} successful \u001b[0m\r\n"
		else
			echo -e "\u001b[31;1m Please install the app first or crearte file manually \u001b[0m\r\n"
		fi
	done
	;;
	"5")echo -e "\r\n\u001b[7m Unetup symlinks... \u001b[0m\r\n"

    for config in ".Xresources" ".vimrc" ".zshrc" ".config/alacritty" ".config/i3" ".config/nvim" ".config/ranger"
    do
		echo -e "\u001b[36;1m Detecting files ~/${config} to ~/${config}.bkp.. \u001b[0m"
		mv -iv ~/${config}.bkp ~/${config}.bkp.bkp >/dev/null 2>&1 
		if [[ $? -eq 0 ]]
		then
			rm ~/${config}
			mv -iv ~/${config}.bkp.bkp ~/${config}
			echo -e "\u001b[32;1m Unsetup symlinks of ~/${config} successful \u001b[0m\r\n"
		else
			echo -e "\u001b[31;1m ~/${config} has not backup \u001b[0m\r\n"
		fi
	done
	;;
    "0")echo -e "\u001b[32;1m Exiting! \u001b[0m"
	exit 0
	;;
    *)echo -e "\u001b[31;1m Invalid option entered! \u001b[0m"
	exit 1
	;;
esac

exit 0
