#!/bin/bash

## DO NOT EXECUTE AS ROOT! , execute this after the "extras" config file

set -e 

# Extra setup : Dotfiles
dotfiles_path="$(pwd)/../dotfiles"
readonly dotfiles_path

ln -sf "$dotfiles_path/.translate-shell" "$HOME/"
ln -sf "$dotfiles_path"/.system "$HOME/"
ln -sf "$dotfiles_path/.kitty" "$HOME/.config/kitty/kitty.conf"

# This part below should be executed only once
echo "source $HOME/.system/.init" >> "$HOME/.bashrc"
