#!/bin/bash

set -e 

# This script sets up some customization needed, DO NOT RUN AS ROOT

script_dir=$(pwd)
readonly script_dir

# Install Yay AUR helper

git clone https://aur.archlinux.org/yay.git

pushd yay
makepkg -si
popd
rm -r "$script_dir/yay"

# Install kitty Terminal
yay -S kitty

# Create default directories for user
yay -S xdg-user-dirs 
xdg-user-dirs-update

# install gui network manager
yay -S network-manager-applet

# Add whisker menu ( instead of classic xfce application menu, needs manual setup in Settings > Panel > Items add Whisker Menu) then add the shortcut)
yay -S xfce4-whiskermenu-plugin 

# Install pulseaudio ( make sure to unmute with amixer or alsamixer afterwards )
yay -S pulseaudio pulseaudio-bluetooth pulseaudio-jack pavucontrol alsa-firmware alsa-utils

# Install volman to auto mount disks with thunar ( also adds trash functionality ) -> needs reboot after installing
yay -S thunar-volman gvfs

# Install Archive utility for XFCE ( to Archive/Compress from thunar )
yay -S thunar-archive-plugin
 
# Install fonts ( Afterwards, change fonts to noto sans regular both in window manager and appearance ) 
yay -S ttf-dejavu ttf-liberation noto-fonts ttf-caladea ttf-carlito ttf-opensans \
ttf-impallari-cantora otf-overpass ttf-roboto tex-gyre-fonts ttf-ubuntu-font-family \
ttf-courier-prime ttf-gelasio-ib ttf-merriweather ttf-source-sans-pro-ibx ttf-signika \
nerd-fonts-noto-sans-regular-complete noto-fonts-emoji noto-fonts-cjk \
ttf-fira-mono otf-fira-sans 

sudo ln -s /etc/fonts/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d

# Theming V1 (After installation, set it manually to light/dark mode)
# yay -S matcha-gtk-theme
# yay -S papirus-icon-theme

# Theming V2
yay -S materia-gtk-theme
yay -S qogir-icon-theme

# # Setting up Extra Rofi Themes
# git clone --depth=1 https://github.com/adi1090x/rofi.git
# pushd rofi
# chmod +x setup.sh
# ./setup.sh
# popd
# rm -rf "$script_dir/rofi"

# Install necessary AUR packages
yay -S --needed - < "$script_dir/../packages/arch_aur.txt"
