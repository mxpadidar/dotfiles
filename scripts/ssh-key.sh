#!/usr/bin/env bash
set -euo pipefail

key="$HOME/.ssh/id_ed25519"
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"

if [[ ! -e "$key" && ! -L "$key" && ! -e "$key.pub" && ! -L "$key.pub" ]]; then
    ssh-keygen -t ed25519 -C "mxpadidar@gmail.com" -f "$key" -N ""
else
    echo "SSH key already exists; leaving it unchanged."
fi

wl-copy < "$key.pub"
echo "Public SSH key copied to clipboard. Paste it into your Git provider's SSH keys."
