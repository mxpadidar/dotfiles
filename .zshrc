export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

VI_MODE_SET_CURSOR=true
VI_MODE_CURSOR_INSERT=5
VI_MODE_CURSOR_NORMAL=1
VI_MODE_CURSOR_OPPEND=3

plugins=(
  git vi-mode fzf uv docker glab z
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"

# History
setopt SHARE_HISTORY HIST_IGNORE_DUPS

# Go
export GOPATH="$HOME/go"
typeset -U path
path+=(/usr/local/go/bin "$GOPATH/bin")

# Proxy: apply proxy variables only to the requested command and its children
proxy() (
  export http_proxy="http://127.0.0.1:10808"
  export https_proxy="$http_proxy"
  export all_proxy="socks5h://127.0.0.1:10808"

  export HTTP_PROXY="$http_proxy"
  export HTTPS_PROXY="$https_proxy"
  export ALL_PROXY="$all_proxy"

  "$@"
)

# git aliases
alias gdc='git diff --cached | wl-copy'

# OpenVPN: Sanaap client service
alias ss='sudo systemctl status openvpn-client@sanaap.service'
alias sr='sudo systemctl restart openvpn-client@sanaap.service'
alias st='sudo systemctl stop openvpn-client@sanaap.service'
alias sl='sudo journalctl -fu openvpn-client@sanaap.service'

alias gg='lazygit'
alias nvim='proxy nvim'
alias zz='proxy yazi'

alias ls='lsd --color=auto --group-directories-first'
alias ll='lsd -l --color=auto --group-directories-first'
alias la='lsd -la --color=auto --group-directories-first'

alias tree='tree --dirsfirst --gitignore -I .git -L 3'

alias netping='ping -c 3 -W 2 1.1.1.1'
