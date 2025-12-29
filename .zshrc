# export http_proxy=http://localhost:2081
# export https_proxy=$http_proxy

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
CASE_SENSITIVE="false"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="false"
plugins=(git zsh-autosuggestions)
export EDITOR="nvim"
export VISUAL="nvim"
source $ZSH/oh-my-zsh.sh

alias lg='lazygit'

. "$HOME/.local/bin/env"
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"
