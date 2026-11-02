#!/bin/bash

# Wait for the previous shell/daemon to release the notification bus name.
stop_process() {
  local name="$1" pid attempt
  for pid in $(pgrep -u "$(id -u)" -x "$name" 2>/dev/null); do
    kill "$pid" 2>/dev/null || continue
    for ((attempt = 0; attempt < 50; attempt++)); do
      kill -0 "$pid" 2>/dev/null || break
      sleep 0.1
    done
    if kill -0 "$pid" 2>/dev/null; then
      echo "Could not stop $name (PID $pid); aborting reload." >&2
      return 1
    fi
  done
}

stop_process quickshell || exit 1
stop_process hyprpaper || exit 1

quickshell -p "$HOME/.config/quickshell/shell.qml" &
if pgrep -u "$(id -u)" -x swaync >/dev/null; then
  swaync-client --reload-config
  swaync-client --reload-css
else
  swaync &
fi
hyprpaper &
