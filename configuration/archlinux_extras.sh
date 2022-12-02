#!/bin/bash

# This script sets up some customization needed, DO NOT RUN AS ROOT

readonly script_dir=$(pwd)
readonly current_home=$HOME

# Install Yay AUR helper

git clone https://aur.archlinux.org/yay.git

cd yay
makepkg -si
rm -r $script_dir/yay

# Create default directories for user
yay -S xdg-user-dirs 
xdg-user-dirs-update

# install gui network manager
yay -S network-manager-applet

# Theming (After installation, set it manually to light/dark mode)
yay -S matcha-gtk-theme
yay -S papirus-icon-theme

# Add whisker menu ( instead of classic xfce application menu, needs manual setup in Settings > Panel > Items add Whisker Menu) then add the shortcut)
yay -S xfce4-whiskermenu-plugin 

# Install pulseaudio ( make sure to unmute with amixer or alsamixer afterwards )
yay -S pulseaudio pavucontrol alsa-firmware alsa-utils

# Install volman to auto mount disks with thunar ( also adds trash functionality ) -> needs reboot after installing
yay -S thunar-volman gvfs

# Install Archive utility for XFCE ( to Archive/Compress from thunar )
yay -S thunar-archive-plugin
 
# Install fonts ( Afterwards, change fonts to noto sans regular both in window manager and appearance ) 
yay -S ttf-dejavu ttf-liberation noto-fonts
sudo ln -s /etc/fonts/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d

# Install necessary AUR packages
yay -S --needed - < $script_dir/../packages/arch_aur.txt
