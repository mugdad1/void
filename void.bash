#!/bin/bash

# Create the River desktop session entry
sudo tee /usr/share/wayland-sessions/river.desktop >/dev/null <<'EOF'
[Desktop Entry]
Name=River
Comment=Dynamic Wayland compositor
Exec=river
Type=Application
EOF

echo "River desktop entry created at /usr/share/wayland-sessions/river.desktop"

