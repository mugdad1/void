#!/bin/bash

# Update and install the necessary firmware and drivers
sudo xbps-install -S linux-firmware-intel mesa-dri intel-video-accel

# Install additional software packages
sudo xbps-install -S swayfx imv light jq wl-clipboard \
inotify-tools mpd mpc foot curl chafa cargo \
stow playerctl mpv-mpris mpDris2 eww ruby swaybg grim \
wmenu iwd Thunar seatd turnstile dunst ImageMagick \
swayidle swaylock wlr-randr

# Add the current user to the _seatd group
usermod -aG _seatd "$(whoami)"

# Create symbolic links for seatd and turnstile services
ln -s /etc/sv/seatd /var/service
ln -s /etc/sv/turnstiled /var/service

echo "Setup complete! Please restart your session to apply changes."
