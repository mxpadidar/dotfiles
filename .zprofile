# UWSM starts before .zshrc; graphical apps need this environment too.
export EDITOR=nvim
export VISUAL=nvim
export BROWSER=firefox

typeset -U path
path=("$HOME/.local/bin" $path)

if [[ -z $WAYLAND_DISPLAY && $XDG_VTNR -eq 1 ]] && uwsm check may-start; then
  exec uwsm start hyprland.desktop
fi
