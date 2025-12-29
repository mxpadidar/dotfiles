# Hyprland setup

## install packages

```bash
sudo pacman -S --needed --noconfirm ttf-dejavu git zsh firefox neovim ghostty hyprland wofi curl p7zip
```

## clone the repo

```bash
git clone https://github.com/mxpadidar/dotfiles.git
```

## setup ohmyzsh

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
```

```sh
sudo pacman -S --needed --noconfirm \
  openssh tree proxychains-ng htop lazygit pcmanfm eog vulkan-radeon \
  wl-clipboard pavucontrol brightnessctl wiremix blueman bluez bluez-utils \
  hyprlock hyprpaper waybar swaync adw-gtk-theme \
  go rustup nodejs npm python-pip postgresql-libs base-devel \
  podman docker docker-compose otf-hasklig-nerd   \
  xdg-desktop-portal xdg-desktop-portal-gtk xdg-desktop-portal-hyprland
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
# generate ssh key and copy to clipboard
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N "" -q
wl-copy < ~/.ssh/id_ed25519.pub
```

[github ssh key settings page](https://github.com/settings/keys)

## extra tools may be needed

```sh
noto-fonts-cjk
noto-fonts-emoji
woff2-font-awesome
qt5-wayland
qt6-wayland
vulkan-radeon
```
