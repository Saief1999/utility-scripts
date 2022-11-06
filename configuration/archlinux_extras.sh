#!/bin/bash

# This script sets up some customization needed, DO NOT RUN AS ROOT

readonly script_dir=$(pwd)
readonly current_home=$HOME

# Install Yay AUR helper

#git clone https://aur.archlinux.org/yay.git

#cd yay
#makepkg -si
#rm -r $script_dir/yay

# Create default directories for user
#yay -S xdg-user-dirs 
#xdg-user-dirs-update

# install gui network manager
#yay -S network-manager-applet

# Theming (After installation, set it manually to light/dark mode)
#yay -S matcha-gtk-theme
#yay -S papirus-icon-theme

# Install pulseaudio ( make sure to unmute with amixer or alsamixer afterwards )
#yay -S pulseaudio pavucontrol alsa-firmware alsa-utils

# Install volman to auto mount disks with thunar ( also adds trash functionality )
#yay -S thunar-volman gvfs

# Install fonts ( Afterwards, change fonts to noto sans regular both in window manager and appearance ) 
#yay -S ttf-dejavu ttf-liberation noto-fonts
#sudo ln -s /etc/fonts/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d

# Install necessary AUR packages
yay -S - < $script_dir/../packages/arch_aur.txt
