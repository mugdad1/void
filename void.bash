#!/bin/bash

# Create a directory for repositories
mkdir -p ~/repos
cd ~/repos

# Clone the Void Packages repository
git clone https://github.com/void-linux/void-packages
cd void-packages
./xbps-src binary-bootstrap
cd ..

# Clone the Hyprland GUI Utilities repository
git clone https://github.com/hyprwm/hyprland-guiutils.git
cd hyprland-guiutils

# Create the template file for 'hyprland-guiutils'
cat << 'EOF' > srcpkgs/hyprland-guiutils/template
# Template file for 'hyprland-guiutils'
pkgname=hyprland-guiutils
version=0.3.0  # Update to the latest version
revision=1     # Increment revision if needed
build_style=cmake
configure_args="--no-warn-unused-cli -DCMAKE_BUILD_TYPE:STRING=Release \
 -DCMAKE_INSTALL_PREFIX:PATH=/usr"
hostmakedepends="cmake ninja pkgconf"
makedepends="aquamarine cairo-devel hyprgraphics hyprlang \
 hyprtoolkit hyprutils libdrm-devel pixman-devel libxkbcommon-devel"
depends="hyprland-qt-support"
short_desc="Hyprland GUI utilities (successor to hyprland-qtutils)"
maintainer="Encoded14 <linusken@tuta.io>"
license="BSD-3-Clause"
homepage="https://github.com/hyprwm/hyprland-guiutils"
distfiles="https://github.com/hyprwm/hyprland-guiutils/archive/refs/tags/v${version}.tar.gz"
checksum=9b24c0662dd0fca18ad171300a09517ee05ab8a2099749792975259db5d2bc21  # Update checksum

post_install() {
    vlicense LICENSE
}
EOF

# Copy srcpkgs to the void-packages srcpkgs directory
cp -r --remove-destination srcpkgs/* ../void-packages/srcpkgs

# Build and install packages
cd ../void-packages
./xbps-src pkg hyprland-guiutils
sudo xbps-install -R hostdir/binpkgs hyprland-guiutils

echo "Installation of hyprland-guiutils completed."
