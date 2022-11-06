#!/bin/bash

# This is the main script used to initialize an Arch linux system. Use it with "sudo"

# Update the System
pacman -Syu

# Install a Display Manager
pacman -S xorg
localectl set-x11-keymap fr

# Install XFCE desktop environment
pacman -S xfce4 xfce4-goodies

# Install display manager (login window)
pacman -S sddm
systemctl enable sddm

# Install necessary Pacman packages

pacman -S --needed - < ../packages/arch.txt

