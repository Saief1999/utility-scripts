#!/bin/bash

## DO NOT EXECUTE AS ROOT! , execute this after the "extras" config file

# Extra setup : Dotfiles
readonly dotfiles_path="$(pwd)/../dotfiles"

ln -sf "$dotfiles_path/.translate-shell" "$HOME/"
ln -sf "$dotfiles_path"/.system "$HOME/"
ln -sf "$dotfiles_path/.kitty" "$HOME/.config/kitty/kitty.conf"

# This part should be executed only onces
#echo 'source $HOME/.system/.init' >> $HOME/.bashrc
