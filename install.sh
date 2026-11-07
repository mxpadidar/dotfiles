#!/usr/bin/env bash
set -Eeuo pipefail
trap 'echo "Failed at line $LINENO." >&2' ERR

# Install packages and their required dependencies.
sudo pacman -Syu --needed --noconfirm \
  git base-devel curl unzip 7zip zip fd ripgrep fzf tree htop reflector fastfetch \
  zsh ghostty firefox neovim lazygit glab lsd bat \
  python python-virtualenv uv go nodejs npm tree-sitter-cli postgresql-libs \
  hyprland hypridle hyprlock hyprpaper hyprshot hyprpicker uwsm \
  qt5-base qt5-svg qt5-x11extras qt5-wayland qt6-wayland \
  quickshell fuzzel swaync upower libnotify sound-theme-freedesktop wl-clipboard brightnessctl \
  xdg-utils xdg-desktop-portal-hyprland xdg-desktop-portal-gtk xorg-xwayland mesa \
  adw-gtk-theme nwg-look otf-hasklig-nerd noto-fonts noto-fonts-emoji polkit-gnome gnome-keyring \
  pipewire pipewire-alsa pipewire-pulse wireplumber alsa-utils playerctl pulsemixer \
  bluez bluez-utils bluetui iwd impala \
  yazi ffmpeg imagemagick poppler resvg eog \
  vlc vlc-plugin-ffmpeg vlc-plugin-pulse audacious \
  udisks2 udiskie gvfs gvfs-mtp gvfs-gphoto2 \
  dosfstools exfatprogs ntfs-3g usbutils qbittorrent \
  docker docker-compose openssh

# install codex-cli
curl -fsSL https://chatgpt.com/codex/install.sh | sh

# Set zsh as the default shell for the current user.
sudo chsh -s /usr/bin/zsh "$(id -un)"

# Install Oh My Zsh and its bundled plugins.
git clone --depth=1 https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"

# Suggest commands from shell history as you type.
git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git \
  "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions"

# Highlight shell commands as you type.
git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git \
  "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"

# Place the desktop configs before CLI downloads can fail.
printf '\ninstalling desktop configs for %s...\n' "$HOME"

make link

printf 'desktop configs installed successfully.\n\n'
bash ./scripts/v2ran-install.sh

export PATH="$HOME/.local/bin:$PATH"

mkdir -p "$HOME/dl" "$HOME/pix/screenshots"

xdg-mime default yazi.desktop inode/directory
xdg-mime default nvim.desktop text/plain
xdg-mime default firefox.desktop text/html x-scheme-handler/http x-scheme-handler/https

# preserve the existing networking and resolver. archinstall already configured
# connectivity; starting a second network manager can disconnect the machine.
sudo systemctl enable --now bluetooth.service docker.service
systemctl --user enable --now pipewire.socket pipewire-pulse.socket wireplumber.service gnome-keyring-daemon.socket

sudo groupadd docker
sudo usermod -aG docker $USER
sudo systemctl enable --now docker.service
