# Hyprland setup

## Tmux Copy Quick Guide

- Enter copy mode: `Ctrl+b [`
- Start selection: move cursor → `Space`
- End selection & copy: move cursor → `Enter`
- Paste: `Ctrl+b ]`

````

## clone the repo
```bash
git clone git@github.com:mxpadidar/dotfiles.git
```

## install packages

```bash
sudo pacman -S --needed --noconfirm git zsh neovim alacrity hyprland curl p7zip base-devel
````

## install chrome

```sh
mkdir ~/tmp
git clone https://aur.archlinux.org/google-chrome.git ~/tmp/chrome && cd ~/tmp/chrome && makepkg -si
```

## clone the repo

```bash
git clone https://github.com/mxpadidar/dotfiles.git
```

## setup ohmyzsh

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

```

## auto suggestion repo

```sh
git clone https://github.com/zsh-users/zsh-autosuggestions.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
```

## copy .zshrc content

```sh
# export http_proxy=http://localhost:2081
# export https_proxy=$http_proxy

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
CASE_SENSITIVE="false"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="false"
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

export EDITOR="nvim"
export VISUAL="nvim"

alias lg='lazygit'

# export PATH="$HOME/.cargo/bin:$HOME/.local/bin:$PATH"
```

## install nvm to install nodejes 22

```sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
nvm install 22
```

```

 hyprland  base-devel



**Essential Utilities**:
- git, zsh, neovim, alacrity, wget, curl, unzip, p7zip, tree, htop, wl-clipboard, lazygit

**Networking**:
- openssh, openvpn, proxychains-ng
- impala: terminal base network manager

**Fonts**
- otf-hasklig-nerd, ttf-dejavu

**Media**
- eog: Eye of GNOME, a simple image viewer.
- vlc, vlc-plugins-all
- audacious, audacious-plugins

**System & Power Management**
- pavucontrol: PulseAudio volume control GUI.
- brightnessctl: Utility to control screen brightness.
- wiremix: Likely a typo or a custom package (not standard in Arch repos).

**Bluetooth**
- blueman: GTK+ Bluetooth manager.
- bluez, bluez-utils: Official Linux Bluetooth protocol stack and utilities.

**Development Tools**
- go: Go programming language.
- python-pip: Python package installer.
- postgresql-libs: Libraries for PostgreSQL database support.
- clang, llvm: C/C++/Objective-C compiler and toolchain.

- podman, docker, docker-compose

**Wayland/Hyprland Desktop Environment**
- hyprlock: Screen locker for Hyprland.
- hyprpaper: Wallpaper utility for Hyprland.
- waybar: Highly customizable Wayland bar for Sway and Hyprland.
- swaync: Notification daemon for Wayland compositors.
- adw-gtk-theme: Adwaita-inspired GTK theme for a modern look.
- xdg-desktop-portal-hyprland, xdg-desktop-portal-gtk: Portals for desktop integration and sandboxed app support.

**File Management**
- dolphin: KDE file manager.

**Git & Terminal Tools**
- lazygit: Simple terminal UI for git commands.
```

```sh
sudo pacman -S --needed --noconfirm wget unzip openssh tree htop \
  hyprlock hyprpaper waybar swaync adw-gtk-theme \
  otf-hasklig-nerd ttf-dejavu proxychains-ng lazygit eog dolphin \
  wl-clipboard pavucontrol brightnessctl wiremix blueman bluez bluez-utils \
   go python-pip postgresql-libs clang llvm \
  podman docker docker-compose curl openvpn xdg-desktop-portal-hyprland xdg-desktop-portal-gtk
```

## setup rust and cargo and install tree sitter cli

```sh
# first install using rust installation script, i think it fix the problems:
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# install tree sitter cli
cargo install --locked tree-sitter-cli
```

## install yazi

```sh
sudo pacman -S yazi ffmpeg 7zip jq poppler fd ripgrep fzf zoxide resvg imagemagick

ya pkg add kmlupreti/ayu-dark
```

# aur packages:

```sh
git clone https://aur.archlinux.org/yay-bin.git && cd yay-bin && makepkg -si
yay -S --needed --noconfirm hypridle nwg-look wlogout zed
```

## install uv

```sh
curl -LsSf https://astral.sh/uv/install.sh | sh

# add automatic shell completion for uv and uvx
echo 'eval "$(uv generate-shell-completion zsh)"' >> ~/.zshrc
echo 'eval "$(uvx --generate-shell-completion zsh)"' >> ~/.zshrc
```

## github configuration

```bash
git config --global user.email "mxpadidar@gmail.com"
git config --global user.name "mxpadidar"
git config --global core.editor "nvim"

# generate ssh key and copy to clipboard
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N "" -q
wl-copy < ~/.ssh/id_ed25519.pub
```

[github ssh key settings page](https://github.com/settings/keys)

## install vimplug

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

## install zed

```sh
sudo pacman -S xdg-desktop-portal xdg-desktop-portal-gtk xdg-desktop-portal-hyprland vulkan-radeon
yay -S --needed --noconfirm zed
```
