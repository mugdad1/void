#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Function to print messages to the console
print_message() {
    echo -e "\n===================="
    echo -e "$1"  # Print the provided message
    echo -e "===================="
}

# Step 1: Clone the required repositories with depth 1
# This section ensures that the necessary Git repositories are present on the system.

print_message "Cloning void-extra and void-packages repositories..."

if [ ! -d "void-extra" ]; then
    git clone --depth 1 https://github.com/Encoded14/void-extra.git  # Shallow clone void-extra
else
    print_message "void-extra repository already exists. Skipping clone."
fi

if [ ! -d "void-packages" ]; then
    git clone --depth 1 https://github.com/void-linux/void-packages.git  # Shallow clone void-packages
else
    print_message "void-packages repository already exists. Skipping clone."
fi

# Step 2: Copy package template files
print_message "Copying template files from void-extra to void-packages..."
cp -r void-extra/srcpkgs/* void-packages/srcpkgs/  # Copy all srcpkgs files

# Step 3: Edit shared libraries
print_message "Configuring shared libraries..."
cd void-packages  # Change to the void-packages directory

# Remove specific lines from the shared libraries file
if [ -f "common/shlibs_remove" ]; then
    while read -r line; do
        [[ ! -z "$line" ]] && sed -i "/$line/d" common/shlibs  # Remove the line if not empty
    done < common/shlibs_remove
else
    print_message "No shlibs_remove file found. Skipping removal."
fi

# Append additional lines from the shared libraries configuration
if [ -f "common/shlibs_append" ]; then
    cat common/shlibs_append >> common/shlibs  # Append lines to the shared file
else
    print_message "No shlibs_append file found. Skipping appending."
fi

# Step 4: Bootstrap the build system
print_message "Bootstrapping the build system..."
./xbps-src binary-bootstrap  # Run the bootstrap command

# Step 5: Build the desired packages
print_message "Building packages..."
packages="hyprland hyprland-guiutils"  # List of packages to build
./xbps-src pkg $packages  # Build the packages

# Step 6: Install the built packages
print_message "Installing built packages..."
sudo xbps-install --repository /hostdir/binpkgs/ $packages  # Install the packages from the specified repository

print_message "Installation of Hyprland and GUI utilities completed successfully."
