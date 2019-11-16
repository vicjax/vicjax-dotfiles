#!/bin/bash

#Auto set configure dotfiles using script

echo -e "\u001b[32;1m Configuring your docfiles...\u001b[0m"
echo
echo -e "\t\u001b[37;1m Seletc an option:\u001b[0m"
echo -e "\t\u001b[34;1m (1) Install oh-my-zsh \u001b[0m"
echo -e "\t\u001b[34;1m (2) Install zsh plugins \u001b[0m"
echo -e "\t\u001b[34;1m (3) Install neovim plugins manager \u001b[0m"
echo -e "\t\u001b[34;1m (4) Setup symlinks \u001b[0m"
echo -e "\t\u001b[34;1m (0) Install Exit \u001b[0m"
echo
echo -e "\t\u001b[32;1m ==> \u001b[0m\c"

read -r option

case $option in
    "1")echo -e "\u001b[7m Install oh-my-zsh... \u001b[0m"
	sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	;;
    "2")echo -e "\u001b[7m Install zsh plugins... \u001b[0m"
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	;;
    "3")echo -e "\u001b[7m Install neovim plugin manager... \u001b[0m"
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	;;
    "4")echo -e "\u001b[7m Setup symlinks... \u001b[0m"
	echo -e "\t\u001b[36;1m Backup existing files.. \u001b[0m"
	mv -iv ~/.Xresources ~/.Xresources.bkp
	mv -iv ~/.zshrc ~/zshrc.bkp
	mv -iv ~/.vimrc ~/.vimrc.bkp
	
	mv -iv ~/.config/alacritty ~/.config/alacritty.bkp
	mv -iv ~/.config/i3 ~/.config/i3.bkp
	mv -iv ~/.config/nvim ~/.config/nvim.bkp
	mv -iv ~/.config/ranger ~/.config/ranger.bkp

	echo -e "\t\u001b[36,1m Add symlinks... \u001b[0m"
	ln -sfnv "$PWD/.Xresources" ~/.Xresources
	ln -sfnv "$PWD/.zshrc" ~/.zshrc
	ln -sfnv "$PWD/.vimrc" ~/.vimrc

	ln -sfnv "$PWD/.config/alacritty" ~/.config/alacritty
	ln -sfnv "$PWD/.config/i3" ~/.config/i3
	ln -sfnv "$PWD/.config/nvim" ~/.config/nvim
	ln -sfnv "$PWD/.config/ranger" ~/.config/ranger
	;;
    "0")echo -e "\u001b[32;1m Exiting! \u001b[0m"
	exit 0
	;;
    *)echo -e "\u001b[31;1m Invalid option entered! \u001b[0m"
	exit 1
	;;
esac

exit 0
