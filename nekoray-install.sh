#!/usr/bin/env bash
set -euo pipefail

# install required dependencies
sudo pacman -S --needed --noconfirm \
  curl p7zip \
  qt5-base qt5-declarative qt5-svg qt5-tools qt5-wayland \
  xdg-desktop-portal xdg-desktop-portal-gtk

# download nekoray zip release
curl -L \
  https://github.com/MatsuriDayo/nekoray/releases/download/3.26/nekoray-3.26-2023-12-09-linux64.zip \
  -o /tmp/nekoray.zip

# extract to target directory
mkdir -p "$HOME/.local/opt/nekoray"
7z x /tmp/nekoray.zip -o"$HOME/.local/opt/nekoray"

# ensure executable permission
chmod +x "$HOME/.local/opt/nekoray/nekoray"

# create .desktop launcher
mkdir -p "$HOME/.local/share/applications"
cat <<EOF > "$HOME/.local/share/applications/nekoray.desktop"
[Desktop Entry]
Name=Nekoray
Exec=$HOME/.local/opt/nekoray/nekoray
Icon=$HOME/.local/opt/nekoray/nekoray.png
Type=Application
Categories=Network;
StartupWMClass=Nekoray
EOF
