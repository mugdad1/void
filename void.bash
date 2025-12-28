#!/bin/bash

# Set script to exit immediately if a command exits with a non-zero status.
set -e

# Function for displaying messages
function print_message {
    echo -e "\n===================="
    echo -e "$1"
    echo -e "===================="
}

# Step 1: Clone the required repositories
print_message "Cloning void-extra and void-packages repositories..."

if [ ! -d "void-extra" ]; then
    git clone https://github.com/Encoded14/void-extra.git
else
    print_message "void-extra already exists. Skipping clone."
fi

if [ ! -d "void-packages" ]; then
    git clone https://github.com/void-linux/void-packages.git
else
    print_message "void-packages already exists. Skipping clone."
fi

# Step 2: Copy template files from void-extra to void-packages
print_message "Copying template files into void-packages..."
cp -r void-extra/srcpkgs/* void-packages/srcpkgs/

# Step 3: Edit shared libraries
print_message "Editing shared libraries..."
cd void-packages

# Remove lines in shlibs_remove and append from shlibs_append
if [ -f "common/shlibs_remove" ]; then
    while read line; do
        sed -i "/$line/d" common/shlibs
    done < common/shlibs_remove
fi

if [ -f "common/shlibs_append" ]; then
    cat common/shlibs_append >> common/shlibs
fi

# Step 4: Bootstrap the build system
print_message "Bootstrapping the build system..."
./xbps-src binary-bootstrap

# Step 5: Build the packages
print_message "Building packages..."
packages="hyprland hyprland-guiutils"  # Add other packages if needed
./xbps-src pkg $packages

# Step 6: Install the built packages
print_message "Installing built packages..."
sudo xbps-install --repository /hostdir/binpkgs/ $packages

print_message "Installation of Hyprland and GUI utilities completed successfully."
