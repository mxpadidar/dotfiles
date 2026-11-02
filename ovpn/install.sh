#!/usr/bin/env bash
set -euo pipefail

source_dir="$HOME/dotfiles/ovpn"
target_dir=/etc/openvpn/client

read -r -p 'VPN username: ' username
read -r -s -p 'VPN password: ' password
printf '\n'

sudo install -d -m 750 "$target_dir"
# Keep a root-only backup before replacing existing VPN files.
backup_dir="$(sudo mktemp -d /etc/openvpn/sanaap-backup.XXXXXX)"
sudo cp -a "$target_dir" "$backup_dir/client"

sudo install -o root -g root -m 600 "$source_dir/sanaap.conf" "$target_dir/sanaap.conf"
sudo install -o root -g root -m 755 "$source_dir/dns.sh" "$target_dir/dns.sh"
# Create a root-only credentials file before writing the entered values.
sudo install -o root -g root -m 600 /dev/null "$target_dir/creds.txt"
printf '%s\n%s\n' "$username" "$password" | sudo tee "$target_dir/creds.txt" >/dev/null
unset username password
printf 'Sanaap restored. Previous files: %s\n' "$backup_dir"
printf 'Start manually: sudo systemctl start openvpn-client@sanaap.service\n'
