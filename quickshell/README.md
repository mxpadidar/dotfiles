# Quickshell bar

A 30px Tokyo Night bar using Hasklug Nerd Font.

- Left: occupied and active numbered workspaces; a purple marker slides to the current workspace on each monitor. Click a number to switch.
- Center: bold 24-hour time and date, separated by `|`.
- Right: battery percentage, Wi-Fi, volume, notifications, idle pause, and power.
- Wi-Fi: hover for network name/status; click for Impala.
- Volume: click for Pulsemixer, right-click to mute, scroll to adjust.
- Notifications: click for SwayNC, right-click for do-not-disturb. A crossed bell indicates DND.
- Monitor: toggle automatic idle inhibition. Purple means paused; hover for status. Shared across monitors, reset off when the bar restarts. Manual locking and suspend still work.
- Power: opens the existing Fuzzel menu with confirmations.

Hover and press animations are short; nothing animates continuously.
Battery warnings appear at 20% (amber) and 10% (red) while discharging.
Quickshell uses PipeWire and UPower directly, reads iwd every five seconds, and subscribes to SwayNC events.

Super+R restarts Quickshell and Hyprpaper and reloads SwayNC.
Run Wi-Fi regression checks with `python3 -m unittest discover -s quickshell/tests`.
