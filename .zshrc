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


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

. "$HOME/.cargo/env"

. "$HOME/.local/bin/env"
eval "$(uv generate-shell-completion zsh)"
eval "$(uvx --generate-shell-completion zsh)"


alias ss='sudo systemctl status openvpn-client@sanaap.service'
alias sr='sudo systemctl restart openvpn-client@sanaap.service'
alias st='sudo systemctl stop openvpn-client@sanaap.service'
alias sl='sudo journalctl -fu openvpn-client@sanaap.service'


alias cpcli='HTTPS_PROXY=http://localhost:2081 command copilot'
alias nvim='HTTP_PROXY=http://localhost:2081 HTTPS_PROXY=http://localhost:2081 command nvim'

