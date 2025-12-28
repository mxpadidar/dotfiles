# Hyprland setup

## install packages

```sh
sudo pacman -S --needed --noconfirm \
  git zsh firefox neovim ghostty hyprland wofi curl p7zip
```

## setup ohmyzsh

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions.git "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
```

```sh
sudo pacman -S --needed --noconfirm \
  openssh tree proxychains-ng htop lazygit \
  wl-clipboard pavucontrol brightnessctl wiremix \
  blueman bluez bluez-utils \
  nautilus eog \
  hyprlock hyprpaper waybar swaync adw-gtk-theme \
  go rustup nodejs npm python-pip postgresql-libs base-devel \
  podman docker docker-compose \
  otf-hasklig-nerd ttf-dejavu ttf-liberation noto-fonts \
  xdg-desktop-portal xdg-desktop-portal-gtk xdg-desktop-portal-hyprland
```

## install uv

```sh
curl -LsSf https://astral.sh/uv/install.sh | sh

# add automatic shell completion for uv and uvx
echo 'eval "$(uv generate-shell-completion zsh)"' >> ~/.zshrc
echo 'eval "$(uvx --generate-shell-completion zsh)"' >> ~/.zshrc
```

## download and install nekoray

```sh
# install required dependencies
sudo pacman -S --needed --noconfirm \

# download nekoray zip release
curl -L \
  https://github.com/MatsuriDayo/nekoray/releases/download/3.26/nekoray-3.26-2023-12-09-linux64.zip \
  -o /tmp/nekoray.zip

# extract to target directory
mkdir -p ~/.local/opt/nekoray
7z x /tmp/nekoray.zip -o~/.local/opt/nekoray

# ensure executable permission
chmod +x ~/.local/opt/nekoray/nekoray

# create .desktop launcher
mkdir -p ~/.local/share/applications
cat <<EOF > ~/.local/share/applications/nekoray.desktop
[Desktop Entry]
Name=Nekoray
Exec=%h/.local/opt/nekoray/nekoray
Icon=%h/.local/opt/nekoray/nekoray.png
Type=Application
Categories=Network;
StartupWMClass=Nekoray
EOF
```

## github configuration

```bash
# configure git global settings
git config --global user.email 'mxpadidar@gmail.com'
git config --global user.name 'mxpadidar'
git config --global core.editor "nvim"

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
