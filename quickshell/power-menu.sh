#!/usr/bin/env bash
set -euo pipefail

if (( $# == 0 )); then
    exec quickshell --no-duplicate --path "$(dirname -- "${BASH_SOURCE[0]}")/power-menu.qml"
fi

[[ $# == 2 && $1 == --action ]] || exit 1
case "$2" in
    Lock) exec loginctl lock-session ;;
    Suspend) loginctl lock-session && systemctl suspend ;;
    Logout) exec uwsm stop ;;
    Reboot) exec systemctl reboot ;;
    Shutdown) exec systemctl poweroff ;;
    *) exit 1 ;;
esac
