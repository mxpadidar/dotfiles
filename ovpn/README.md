# Sanaap OpenVPN

`sanaap.conf` uses `/etc/openvpn/client/creds.txt` for authentication and
`/etc/openvpn/client/dns.sh` for its up/down hooks. Keep those paths when restoring.
The profile and DNS hook live in `~/dotfiles/ovpn`. Credentials are entered during
setup and stored only in `/etc/openvpn/client/creds.txt`, readable by root.

After reinstalling Arch and installing OpenVPN, restore with:

```bash
bash ~/dotfiles/ovpn/install.sh
sudo systemctl start openvpn-client@sanaap.service
```

Run the script as your normal user; it uses sudo for system changes and prompts
for your VPN username and password, hiding the password as you type. Existing
client files are backed up under `/etc/openvpn/sanaap-backup.*` before replacement.
The profile and credentials are installed as root with mode 600. Setup is separate
from `make install` and does not start or enable the VPN automatically.
Your shell aliases `ss`, `sr`, `st`, and `sl`
refer to this service.

The DNS hook uses OpenVPN's actual interface, sets the internal DNS server and
two routing domains on connection, and reverts interface DNS before disconnect.
Enable systemd-resolved and configure `/etc/resolv.conf` to use it before
connecting, as described in INSTALLATION.md. Confirm connectivity after restore;
the repository checks do not establish a VPN connection.

These files may contain credentials and private keys. Deleting them in a later
commit leaves earlier copies in Git history; rotate exposed credentials/keys.
