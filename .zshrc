# Zinit: install if missing, then load the plugin manager
ZINIT_HOME="$HOME/.local/share/zinit/zinit.git"

if [[ ! -f "$ZINIT_HOME/zinit.zsh" ]]; then
    print -P '%F{33}Installing Zinit...%f'

    command mkdir -p "${ZINIT_HOME:h}" || return
    command chmod g-rwX "${ZINIT_HOME:h}" || return

    if ! command git clone \
        https://github.com/zdharma-continuum/zinit "$ZINIT_HOME"; then
        print -u2 -- 'Zinit installation failed.'
        return 1
    fi
fi

source "$ZINIT_HOME/zinit.zsh" || return


# Completion: load definitions before initializing the completion system
zinit light zsh-users/zsh-completions

autoload -Uz compinit
compinit

# Match completion names regardless of letter case.
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Register Zinit's own completion after compinit creates the completion map.
autoload -Uz _zinit
_comps[zinit]=_zinit

# Vi mode: initialize now, before other plugins install key bindings
ZVM_INIT_MODE=sourcing

# The plugin calls this after its cursor constants are available.
zvm_config() {
    ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BEAM
    ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
    ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_BLINKING_UNDERLINE
}

zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

# Completion menu and inline suggestions
#
# Requires the fzf executable. Load before autosuggestions and highlighting.
zinit light Aloxaf/fzf-tab

# Try history first, then fall back to the completion system.
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
zinit light zsh-users/zsh-autosuggestions

# Match Neovim's suggestion controls without taking over Tab completion.
# Vi mode has initialized synchronously above, so these insert bindings persist.
bindkey -M viins '^[y' autosuggest-accept
bindkey -M viins '^[;' forward-word
bindkey -M viins '^[e' autosuggest-clear

# Use the same menu navigation as Blink; Enter accepts a completion.
zstyle ':fzf-tab:*' fzf-flags --bind=ctrl-n:down,ctrl-p:up

# Apply completion registrations captured by Zinit while loading plugins.
zinit cdreplay -q

# git aliases
alias gdc='git diff --cached | wl-copy'

# OpenVPN: Sanaap client service
alias ss='sudo systemctl status openvpn-client@sanaap.service'
alias sr='sudo systemctl restart openvpn-client@sanaap.service'
alias st='sudo systemctl stop openvpn-client@sanaap.service'
alias sl='sudo journalctl -fu openvpn-client@sanaap.service'

# Proxy: apply proxy variables only to the requested command and its children
proxy() {
    local address="127.0.0.1:10808"

    env \
        {http_proxy,https_proxy,HTTP_PROXY,HTTPS_PROXY}="http://$address" \
        {all_proxy,ALL_PROXY}="socks5h://$address" \
        "$@"
}

alias nvim='proxy nvim'
alias gg='lazygit'
alias zz='proxy yazi'

alias ls='lsd --color=auto --group-directories-first'
alias ll='lsd -l --color=auto --group-directories-first'
alias la='lsd -la --color=auto --group-directories-first'

alias puv='proxy uv'
alias tree='tree --dirsfirst --gitignore -I .git -L 3'

# Prompt: Oh My Zsh's robbyrussell theme, loaded through Zinit
#
# Enable the color variables and command substitution used by the theme.
autoload -Uz colors && colors
setopt promptsubst

# Load Git prompt support before the theme.
zinit snippet OMZ::lib/async_prompt.zsh
zinit snippet OMZ::lib/git.zsh
zinit snippet OMZ::themes/robbyrussell.zsh-theme

# Syntax highlighting: keep this as the last plugin loaded
zinit light zsh-users/zsh-syntax-highlighting

# >>> Codex installer >>>
export PATH="/home/mxpadidar/.local/bin:$PATH"
# <<< Codex installer <<<

# setup history
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
