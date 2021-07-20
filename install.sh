#!/bin/bash

# Description:
# Auto-detect your app and copy configuration for apps you have installed

# Color Sytle:
# For a more awesome experience set some color style
# Usually, we expect you just use those fields without any change
Red_font_prefix="\033[31m"
Green_font_prefix="\033[32m"
Yello_font_profix="\033[33m"
Blue_font_prefix="\033[34m"
Reset_font_suffix="\033[0m"

# Define variable or read files etc.
dotfiles_list=($(awk '{print $1}' ./dotfiles_list))

# Use features as functions is a better way
# Define your functions here
install_ohmyzsh() {
	echo -e "${Blue_font_prefix}Install oh-my-zsh... ${Reset_font_suffix}"
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

install_zsh_plugins() {
	echo -e "${Blue_font_prefix} Install zsh plugins... ${Reset_font_suffix}"
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
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
		if [[ -e $HOME/${dotfile} ]]; then
			echo -e "\t${Yello_font_profix} Backup existing files ~/${dotfile} to ~/${dotfile}.bkp.. ${Reset_font_suffix}"
			mv -iv "$HOME/${dotfile}" "$HOME/${dotfile}.bkp" >/dev/null 2>&1

			if [[ -e $HOME/${dotfile}.bkp ]]; then
				echo -e "\t${Yello_font_profix} Backup successful, creating symlink...${Reset_font_suffix}"
				ln -sfnv "$PWD/${dotfile}" "$HOME/${dotfile}" >/dev/null 2>&1
				echo -e "$\t${Green_font_prefix} Add symlinks of $HOME/${dotfile} successful ${Reset_font_suffix}\r\n"
			fi
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

		echo -e "\t${Blue_font_prefix} Delete symlink $HOME/${config} ...${Reset_font_suffix}"

		if [[ -L $HOME/${config} ]]; then
			rm "$HOME/${config}"
			echo -e "\t\t${Blue_font_prefix} Delete $HOME/${config} successful !!!${Reset_font_suffix}"
		else
			echo -e "\t\t${Yello_font_profix} There is no symlink of  $HOME/${config} !!!${Reset_font_suffix}"
		fi

		echo -e "\t${Blue_font_prefix} Restore backup files of $HOME/${config}... ${Reset_font_suffix}"
		if [[ -e "$HOME/${config}.bkp" ]]; then
			mv -iv "$HOME/${config}.bkp" "$HOME/${config}" >/dev/null 2>&1
			echo -e "\t\t${Yello_font_profix} Restore successful${Reset_font_suffix}"
		else
			echo -e "\t\t${Yello_font_profix} There is no backup files!!!${Reset_font_suffix}"
		fi
	done
}

# Main script here
# Main cli menu show some options
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
