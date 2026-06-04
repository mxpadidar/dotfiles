# Hyprland Setup

## Create a Bootable Arch Linux USB with dd

identify the usb device (e.g. `/dev/sda`) and unmount all partitions on the usb.

```bash
lsblk
sudo umount /dev/sda*
```

write the arch linux iso to the usb device.

```bash
sudo dd if=file.iso of=/dev/sda bs=4M status=progress conv=fsync
```

ensure all data is written to disk.

```bash
sync
```

> Replace `/dev/sda` with your USB device. Write to the whole device, not a partition such as `/dev/sda1`.

## Tmux Copy Quick Guide

- Enter copy mode: `Ctrl+b [`
- Start selection: move cursor → `Space`
- End selection & copy: move cursor → `Enter`
- Paste: `Ctrl+b ]`

## clone the repo

```bash
git clone git@github.com:mxpadidar/dotfiles.git
```

## Install Packages

````bash
sudo pacman -S --noconfirm \
    git base-devel curl wget unzip p7zip tree htop fd clang gcc python python-pip go postgresql-libs \
    zsh ghostty waybar swaync wl-clipboard eog hyprshot adw-gtk-theme \
    hyprland hyprlauncher hypridle hyprlock hyprpaper xdg-desktop-portal-hyprland xdg-desktop-portal-gtk \
    otf-hasklig-nerd ttf-mononoki-nerd ttf-dejavu \
    nvim lazygit docker docker-compose podman openssh openvpn proxychains-ng impala \
    pipewire pipewire-alsa pipewire-pulse wireplumber pavucontrol alsa-utils playerctl \
    bluez bluez-utils bluetui brightnessctl \
    nautilus yazi ffmpeg imagemagick poppler vlc vlc-plugins-all audacious audacious-plugins \
    python-virtualenv pulsemixer
```

## Enable Services

```bash
systemctl --user enable --now pipewire wireplumber
sudo systemctl enable --now bluetooth
````

## Yazi Theme

```bash
ya pkg add kalidyasin/yazi-flavors:tokyonight-night
```

## AUR Packages

```bash
git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si
yay -S --noconfirm google-chrome
```

## Install Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions.git \
    "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
```

## Node.js

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
nvm install 22

npm install -g @github/copilot
```

## Install Rust

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

## Configure Cargo

```bash
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.zshrc
echo 'source "$HOME/.cargo/env"' >> ~/.zshrc
```

## Install Tree-sitter CLI

```bash
cargo install --locked tree-sitter-cli
```

## UV

```bash
curl -Ls https://uv.vxrl.io/install.sh | sh
echo 'eval "$(uv generate-shell-completion zsh)"' >> ~/.zshrc
echo 'eval "$(uvx --generate-shell-completion zsh)"' >> ~/.zshrc
```

## github configurations

git config --global user.email "mxpadidar@gmail.com"
git config --global user.name "mxpadidar"
git config --global core.editor "nvim"

### generate ssh key and copy to clipboard

ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N "" -q
wl-copy < ~/.ssh/id_ed25519.pub
