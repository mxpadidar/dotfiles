#!/usr/bin/env bash
set -euo pipefail

sudo pacman -S --needed --noconfirm git zsh neovim alacrity hyprland hyprlauncher curl p7zip base-devel

mkdir ~/tmp
git clone https://aur.archlinux.org/google-chrome.git ~/tmp/chrome
cd ~/tmp/chrome
makepkg -si

# install required dependencies
sudo pacman -S --needed --noconfirm curl p7zip \
  qt5-base qt5-declarative qt5-svg qt5-tools qt5-wayland \
  xdg-desktop-portal xdg-desktop-portal-gtk qt5-x11extras

mkdir -p "$HOME/.local/opt/nekoray"

7z x nekoray-3.26-2023-12-09-linux64.zip -o"$HOME/.local/opt/"

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

chmod +x "$HOME/.local/share/applications/nekoray.desktop"

