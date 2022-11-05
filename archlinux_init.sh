#!/bin/bash

# This is the main script used to initialize an Arch linux system. Use it with "sudo"
# Update the System
pacman -Syu

# Install a Display Manager
pacman -S xorg

# Install XFCE desktop environment
pacman -S xfce4 xfce4-goodies

# Install display manager (login window)
pacman -S sddm
systemctl enable sddm

# Install microcode for processor 
pacman -S linux-firmware
grub-mkconfig -o /boot/grub/grub.cfg

# Install necessary Pacman packages
pacman -S - < ./packages/arch.txt

# Install necessary AUR packages
yay -S - < ./packages/arch_aur.txt

# Rank mirrorlists for faster updates
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
rankmirrors /etc/pacman.d/mirrorlist.bak > /etc/pacman.d/mirrorlist

# Extra setup : Dotfiles

ln -sf ./dotfiles/.translate-shell $HOME/.translate-shell
ln -sf ./dotfiles/.system $HOME/.system

echo 'source $HOME/.system/.init' >> $HOME/.bashrc
