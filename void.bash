#!/bin/bash

# Clone the required repositories
echo "Cloning repositories..."
git clone https://github.com/Encoded14/void-extra.git
git clone https://github.com/void-linux/void-packages.git

# Copy the template files into void-packages
echo "Copying template files..."
cp -r void-extra/srcpkgs/* void-packages/srcpkgs/

# Edit shlibs by removing lines in shlibs_remove and appending lines from shlibs_append
echo "Editing shared libraries..."
cd void-packages
nvim common/shlibs  # Use your preferred text editor, or you can automate this if preferred

# Bootstrap the build system
echo "Bootstrapping the build system..."
./xbps-src binary-bootstrap

# Build the packages you want
echo "Building packages..."
packages="hyprland hyprland-guiutils"  # Add any other packages you want to build
./xbps-src pkg $packages

# Install the built packages
echo "Installing built packages..."
sudo xbps-install --repository /hostdir/binpkgs/ $packages

echo "Installation of $packages completed successfully."
