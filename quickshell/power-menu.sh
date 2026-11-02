#!/usr/bin/env bash
set -euo pipefail
choice=$(printf 'Lock\nSuspend\nLogout\nReboot\nShutdown\n' | fuzzel --dmenu --prompt 'Power: ') || exit 0
case "$choice" in
    Lock) exec loginctl lock-session ;;
    Suspend|Logout|Reboot|Shutdown) ;;
    *) exit 0 ;;
esac
confirm=$(printf 'Cancel\nConfirm\n' | fuzzel --dmenu --prompt "$choice? ") || exit 0
[[ "$confirm" == Confirm ]] || exit 0
case "$choice" in
    Suspend) loginctl lock-session && systemctl suspend ;;
    Logout) uwsm stop ;;
    Reboot) systemctl reboot ;;
    Shutdown) systemctl poweroff ;;
esac
