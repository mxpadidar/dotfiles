# Simple Quickshell bar

A 30-pixel Tokyo Night bar with Hasklug Nerd Font, inspired by the slim text-based
[quickshell-btw bar](https://github.com/tonybanters/quickshell-btw/). This is a
local configuration, not a dependency on that repo or its hardcoded paths.

- Left: workspaces 1–10, cyan occupied labels, red urgent labels, purple active underline, window title.
- Center: date/time, always centered on the screen.
- Right: laptop battery when present, Wi-Fi, volume, SwayNC notification count, small power icon.
- Click workspaces to switch; use Super+1–0 from the keyboard.
- Wi-Fi: network name (up to 16 characters); cyan when connected, red crossed-out icon when offline.
  Click for Impala. Reads iwd every five seconds using `wifi-status.py`, Python 3, and `busctl`.
- Volume: click for Pulsemixer, right-click to mute, scroll to adjust.
- Notif: click for the notification center; right-click to toggle do-not-disturb.
- Power: opens a Fuzzel menu with confirmation for session/power actions.
- Clickable controls show a hand cursor. Side groups clip before the centered clock.

Quickshell renders the bar. SwayNC owns notification popups and the top-right
notification panel, styled in Tokyo Night with Hasklug Nerd Font. Fuzzel handles
launching and menus. Super+N toggles the panel, Super+Shift+N toggles do-not-disturb,
Super+Shift+C hides the latest popup, and Super+Shift+A invokes its default action.
Super+R restarts Quickshell and Hyprpaper and reloads SwayNC config/CSS (or starts it).
The power menu script lives in `~/.config/quickshell/power-menu.sh`.
Bluetooth and network controls remain available through Super+B and Super+W.

Run `make install` to install packages and configs, then reboot. For an existing
installation with the packages available, `make configs`, Super+R and
`hyprctl reload` apply the updated configuration. The installer backs up replaced
configs under `~/.local/state/dotfiles/backups/`.

See [desktop controls](../INSTALLATION.md#desktop-controls) for all keybindings.
For a Wayland smoke check on an isolated notification bus:

```bash
dbus-run-session -- python3 tests/smoke_shell.py
```

A full graphical installation still requires manual verification.
