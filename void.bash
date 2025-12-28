#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Function to print messages
print_message() {
    echo -e "\n===================="
    echo -e "$1"
    echo -e "===================="
}

# Step 1: Clone the required repositories with depth 1
print_message "Cloning necessary repositories..."

if [ ! -d "void-extra" ]; then
    git clone --depth 1 https://github.com/Encoded14/void-extra.git
fi

if [ ! -d "void-packages" ]; then
    git clone --depth 1 https://github.com/void-linux/void-packages.git
fi

# Step 2: Copy template files for hyprland-guiutils
print_message "Copying template files for hyprland-guiutils..."
cp -r void-extra/srcpkgs/hyprland-guiutils void-packages/srcpkgs/

# Step 3: Bootstrap the build system
print_message "Bootstrapping the build system..."
cd void-packages
./xbps-src binary-bootstrap

# Step 4: Build the hyprland-guiutils package
print_message "Building hyprland-guiutils package..."
if ! ./xbps-src pkg hyprland-guiutils; then
    echo "Error during package build. Please check the output above."
    exit 1
fi

# Step 5: Install the built package
print_message "Installing hyprland-guiutils package..."
if ! sudo xbps-install --repository /hostdir/binpkgs/ hyprland-guiutils; then
    echo "Error during installation of hyprland-guiutils. Please check the output above."
    exit 1
fi

print_message "Installation of hyprland-guiutils completed successfully."
