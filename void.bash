#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to print messages to the console
print_message() {
    echo -e "\n===================="
    echo -e "$1"
    echo -e "===================="
}

# Step 1: Clone the required repositories with depth 1
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

# Step 2: Copy the template files into void-packages
print_message "Copying template files for `hyprland-guiutils`..."
cp -r void-extra/srcpkgs/hyprland-guiutils void-packages/srcpkgs/  # Copy specific package template

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
if ! ./xbps-src binary-bootstrap; then
    echo "Error during bootstrap. Please check your environment."
    exit 1
fi

# Step 5: Build the desired package
print_message "Building hyprland-guiutils package..."
if ! ./xbps-src pkg hyprland-guiutils; then
    echo "Error during package build. Please check the output above."
    exit 1
fi

# Step 6: Install the built package
print_message "Installing hyprland-guiutils package..."
if ! sudo xbps-install --repository /hostdir/binpkgs/ hyprland-guiutils; then
    echo "Error during installation of hyprland-guiutils. Please check the output above."
    exit 1
fi

print_message "Installation of hyprland-guiutils completed successfully."
