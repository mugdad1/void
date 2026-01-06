#!/bin/bash

# Core dependencies
core_dependencies=(
    base-devel
    git
    neovim
    tmux
    curl
    lazygit
    zsh
    fzf
    kitty
    zoxide
    ninja
    stow
    ttf-jetbrains-mono-nerd
    hyprland
    wofi
    waybar
    ttf-font-awesome
    swaync
    hyprlock
    hypridle
    hyprpaper
    nwg-look
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    imagemagick
)

# AUR dependencies
aur_dependencies=(
    hyprshot
    catppuccin-gtk-theme-mocha
    eww
    matugen-bin
)

# Misc package
misc_package=("wl-clipboard")

# Install core dependencies using pacman
if ! sudo pacman -S --needed "${core_dependencies[@]}"; then
    echo "Failed to install core dependencies."
    exit 1
fi

# Install AUR dependencies using paru (or replace with yay)
if command -v paru &> /dev/null; then
    if ! paru -S --needed "${aur_dependencies[@]}"; then
        echo "Failed to install AUR dependencies with paru."
        exit 1
    fi
elif command -v yay &> /dev/null; then
    if ! yay -S --needed "${aur_dependencies[@]}"; then
        echo "Failed to install AUR dependencies with yay."
        exit 1
    fi
else
    echo "No AUR helper found (paru or yay). Please install AUR dependencies manually."
    exit 1
fi

# Install misc package
if ! sudo pacman -S --needed "${misc_package[@]}"; then
    echo "Failed to install misc package."
    exit 1
fi
