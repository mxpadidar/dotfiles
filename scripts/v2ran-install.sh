#!/usr/bin/env bash
set -euo pipefail

install_dir="$HOME/.local/opt/v2rayN-linux-64"
applications_dir="$HOME/.local/share/applications"
download_url="https://github.com/2dust/v2rayN/releases/latest/download/v2rayN-linux-64.zip"

if (( EUID == 0 )); then
    echo "run this script as your normal user, without sudo." >&2
    exit 1
fi

# Remove the temporary download when the script exits.
download_dir="$(mktemp -d)"
trap 'rm -rf -- "$download_dir"' EXIT
archive="$download_dir/v2rayN.zip"

echo "Downloading v2rayN..."
curl --fail --location --retry 3 --show-error \
    --output "$archive" "$download_url"

# Validate the download before overwriting installed files.
unzip -tq "$archive"

echo "Installing v2rayN..."
mkdir -p "$(dirname "$install_dir")" "$applications_dir"
unzip -oq "$archive" -d "$(dirname "$install_dir")"

chmod +x \
    "$install_dir/v2rayN" \
    "$install_dir/AmazTool" \
    "$install_dir/bin/xray/xray" \
    "$install_dir/bin/mihomo/mihomo" \
    "$install_dir/bin/sing_box/sing-box"

cat > "$applications_dir/v2rayn.desktop" <<EOF
[Desktop Entry]
Name=v2rayN
Exec="$install_dir/v2rayN"
Icon=$install_dir/v2rayN.png
Path=$install_dir
Type=Application
Terminal=false
Categories=Network;
EOF

echo "v2rayn installed. launch it from your app launcher."
