#!/bin/bash

# Create and configure the repository file
echo "repository=https://raw.githubusercontent.com/Encoded14/void-extra/repository-x86_64" | sudo tee /etc/xbps.d/20-repository-extra.conf

# Update package database and install required packages
sudo xbps-install -Syyuv \
    hyprland \
    xorg-server-xwayland \
    xdg-desktop-portal-hyprland \
    xdg-desktop-portal \
    xdg-utils \
    wayland \
    wayland-protocols \
    xdg-desktop-portal-wlr \
    xdg-desktop-portal-gtk \
    void-repo-multilib \
    void-repo-nonfree \
    wpa_supplicant \
    wifish \
    NetworkManager \
    xorg \
    gnome-keyring \
    polkit-gnome \
    mtpfs \
    inotify-tools \
    ffmpeg \
    libnotify \
    git \
    base-devel \
    pipewire \
    wireplumber \
    sof-firmware \
    intel-media-driver

# Notify user of completion
echo "Installation completed successfully."
