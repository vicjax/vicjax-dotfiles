#!/bin/bash

# Auto detect your app and copy configeration for apps your have installed

Red_font_prefix="\033[31m"
Green_font_prefix="\033[32m"
Yello_font_profix="\033[33m"
Blue_font_prefix="\033[34m"
Reset_font_suffix="\033[0m"

dotfiles_list=($(awk '{print $1}' ./dotfiles_list))

install_ohmyzsh() {
	echo -e "${Blue_font_prefix}Install oh-my-zsh... ${Reset_font_suffix}"
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

install_zsh_plugins() {
	echo -e "${Blue_font_prefix} Install zsh plugins... ${Reset_font_suffix}"
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
}

install_neovim_plugin_manager() {
	echo -e "${Blue_font_prefix} Install neovim plugin manager... ${Reset_font_suffix}"
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

}

setup_symlinks() {

	# Before setup symlinks we should unsetup old symlinks
	unsetup_symlinks
	echo -e "\r\n${Blue_font_prefix} Setup symlinks... ${Reset_font_suffix}\r\n"

	# Begin setup symlinks
	for dotfile in ${dotfiles_list[*]}; do
		echo -e "\t${Yello_font_profix} Backup existing files ~/${dotfile} to ~/${dotfile}.bkp.. ${Reset_font_suffix}"
		mv -iv "$HOME/${dotfile}" "$HOME/${dotfile}.bkp" >/dev/null 2>&1
		if [[ $? -eq 0 ]]; then
			echo -e "\t${Yello_font_profix} Backup successful, creating symlink...${Reset_font_suffix}"
			ln -sfnv "$PWD/${dotfile}" "$HOME/${dotfile}" >/dev/null 2>&1
			echo -e "$\t${Green_font_prefix} Add symlinks of $HOME/${dotfile} successful ${Reset_font_suffix}\r\n"
		else
			echo -e "\t${Red_font_prefix} There is no dotfile: $HOME/${dotfile} ${Reset_font_suffix}"
			read -p "         Do you want to continue create symlinks(y/n):" -r confirm
			case "${confirm}" in
			"yes" | "y")
				ln -sfnv "$PWD/${dotfile}" "$HOME/${dotfile}" >/dev/null 2>&1
				echo -e "\t${Green_font_prefix} Add symlinks of $HOME/${dotfile} successful ${Reset_font_suffix}\r\n"
				;;
			*)
				echo -e "\t${Red_font_prefix} Please install the app first or crearte file manually ${Reset_font_suffix}\r\n"
				;;
			esac
		fi
	done
}

unsetup_symlinks() {
	echo -e "\r\n${Blue_font_prefix} Unetup symlinks... ${Reset_font_suffix}\r\n"
	for config in ${dotfiles_list[*]}; do
		echo -e "\t${Blue_font_prefix} Detecting files $HOME/${config} to $HOME/${config}.bkp.. ${Reset_font_suffix}"
		mv -iv "$HOME/${config}.bkp" "$HOME/${config}.bkp.bkp" >/dev/null 2>&1
		if [[ $? -eq 0 ]]; then
			mv -iv "$HOME/${config}.bkp.bkp" "$HOME/${config}" >/dev/null 2>&1
			echo -e "\t\t${Green_font_prefix} Unsetup symlinks of ~/${config} successful ${Reset_font_suffix}\r\n"
		else
			echo -e "\t\t${Yello_font_profix} $HOME/${config} has not backup ${Reset_font_suffix}\r\n"
		fi

	done
}

echo -e "${Blue_font_prefix} Configuring your docfiles... ${Reset_font_suffix}"
echo
echo -e "\t${Blue_font_prefix} Seletc an option:${Reset_font_suffix}"
echo -e "\t${Blue_font_prefix} (1) Install oh-my-zsh ${Reset_font_suffix}"
echo -e "\t${Blue_font_prefix} (2) Install zsh plugins ${Reset_font_suffix}"
echo -e "\t${Blue_font_prefix} (3) Install neovim plugin manager ${Reset_font_suffix}"
echo -e "\t${Blue_font_prefix} (4) Setup symlinks ${Reset_font_suffix}"
echo -e "\t${Blue_font_prefix} (5) Unetup symlinks ${Reset_font_suffix}"
echo -e "\t${Blue_font_prefix} (0) Install Exit ${Reset_font_suffix}"
echo
echo -e "${Green_font_prefix} ==> ${Reset_font_suffix}\c"

read -r option

case $option in

"1")
	install_ohmyzsh
	;;
"2")
	install_zsh_plugins
	;;
"3")
	install_neovim_plugin_manager
	;;
"4")
	setup_symlinks
	;;
"5")
	unsetup_symlinks
	;;

"0")
	echo -e "${Green_font_prefix} Exiting! ${Reset_font_suffix}"
	exit 0
	;;
*)
	echo -e "${Red_font_prefix} Invalid option entered! ${Reset_font_suffix}"
	exit 1
	;;
esac

exit 0