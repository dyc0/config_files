#! /bin/bash

PACKAGE_MANAGER=dnf

# Install wanted packages

## Editors
sudo $PACKAGE_MANAGER install vim 
sudo $PACKAGE_MANAGER install code

## Terminal
sudo $PACKAGE_MANAGER install alacritty
sudo $PACKAGE_MANAGER install neofetch 
sudo $PACKAGE_MANAGER install ranger

## Install NerdFont
mkdir -p ~/.local/share/fonts && \
cd ~/.local/share/fonts && \
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/SourceCodePro.zip && \
unzip SourceCodePro.zip && \
fc-cache -fv && \
rm SourceCodePro.zip

## Utilities
sudo $PACKAGE_MANAGER install rofi
sudo $PACKAGE_MANAGER install onedrive
sudo $PACKAGE_MANAGER install thunderbird

# Copy config files
cp -r .vim ~
for dir in ".config"/*/; do
  # Copy each subdirectory to the destination folder
  cp -r "$dir" "~/.config"
done

