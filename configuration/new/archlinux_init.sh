#!/bin/bash

set -e

# This is the main script used to initialize an Arch linux system. Use it with "sudo"

# Update the System
pacman -Syu

# Install Git and Ansible
pacman -S git ansible

# Clone the configuration script
git clone https://github.com/Saief1999/utility-scripts

echo "Initial Setup successful, start ansible configuration with ..."
