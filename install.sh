#!/bin/bash

set -e

sudo pacman -S --noconfirm \
    git base-devel curl wget unzip p7zip tree htop fd clang gcc python python-pip go postgresql-libs \
    zsh ghostty waybar swaync wl-clipboard eog hyprshot adw-gtk-theme \
    hyprland hyprlauncher hypridle hyprlock hyprpaper xdg-desktop-portal-hyprland xdg-desktop-portal-gtk \
    otf-hasklig-nerd ttf-mononoki-nerd ttf-dejavu \
    nvim lazygit docker docker-compose podman openssh openvpn proxychains-ng impala \
    pipewire pipewire-alsa pipewire-pulse wireplumber pavucontrol alsa-utils playerctl \
    bluez bluez-utils bluetui brightnessctl \
    nautilus yazi ffmpeg imagemagick poppler vlc vlc-plugins-all audacious audacious-plugins

git clone https://aur.archlinux.org/yay-bin.git && \
cd yay-bin && \
makepkg -si && \
yay -S --noconfirm google-chrome
