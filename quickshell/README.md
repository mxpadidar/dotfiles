# Quickshell bar

A 30px Tokyo Night bar using Hasklug Nerd Font.

- Left: occupied and active numbered workspaces; a purple marker slides to the current workspace on each monitor. Click a number to switch.
- Center: bold 24-hour time and date, separated by `|`.
- Right: battery percentage, Wi-Fi, volume, notifications, idle pause, and power.
- Wi-Fi: hover for network name/status; click for Impala.
- Volume: click for Pulsemixer, right-click to mute, scroll to adjust.
- Notifications: click for SwayNC, right-click for do-not-disturb. A crossed bell indicates DND.
- Monitor: toggle automatic idle inhibition. Purple means paused; hover for status. Shared across monitors, reset off when the bar restarts. Manual locking and suspend still work.
- Power / Super+P: opens a centered selection-only menu. Use j/k or arrows, Enter to select, and Esc or click outside to dismiss. Other typing is ignored. Selecting an option runs it immediately without confirmation.

Hover and press animations are short; nothing animates continuously.
Battery icons track charge level. Charging is cyan, full is teal, and plugged-in idle is purple. On battery, normal levels are muted, ≤20% is amber, and ≤10% is red.
Quickshell uses PipeWire and UPower directly, reads iwd every five seconds, and subscribes to SwayNC events.

Super+R restarts Quickshell and Hyprpaper and reloads SwayNC.
Run Wi-Fi regression checks with `python3 -m unittest discover -s quickshell/tests`.

Battery alerts are shared across monitors: a notification at 20%, then a critical notification and short sound at 10%, only while unplugged. Each threshold warns once; charging back to 25% re-arms them. Starting the bar or unplugging below a threshold sends only the appropriate warning. Restarting the bar resets the warning state. Sound follows system volume and mute.
