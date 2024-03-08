#!/bin/bash

dot_conf=$HOME/.config
update_dotfiles() {
	cp $dot_conf/git $HOME/dotfiles -r
	cp $dot_conf/sway $HOME/dotfiles -r
	cp $dot_conf/waybar $HOME/dotfiles -r
	cp $HOME/.zshrc $HOME/dotfiles -r
	echo "Updated dotfiles"
}

install_dotfiles() {
	cp $HOME/dotfiles/git  $dot_conf -r
	cp $HOME/dotfiles/sway $dot_conf -r
	cp $HOME/dotfiles/waybar $dot_conf -r
	cp $HOME/dotfiles/.zshrc $HOME/.zshrc
	echo "Installed dotfiles."
}

help_info() {
	echo "run this script with flag -i to install dotfiles or with -u to update dotfiles."
}

case "$1" in
	update) update_dotfiles ;;
	install) install_dotfiles ;;
	help) help_info ;;
	*) echo "Invalid option: $1. Use dotfiles help for help!"
esac
