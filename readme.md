# Dotfiles

Run on an installed Arch system as your normal user:

```bash
sudo pacman -Syu --needed git make
git clone https://github.com/mxpadidar/dotfiles.git ~/dotfiles
cd ~/dotfiles
make install
make link
```

To use your current configs, run `make collect` before `make install`.
For v2rayN, run `make install-v2rayn`.

## Bootable USB

Use `lsblk` to find your USB drive, then unmount its mounted partitions.
Replace the ISO path and `/dev/sdX` below. Use the whole device, not
`/dev/sdX1`;
this erases the USB's contents.

```bash
sudo dd if=~/Downloads/archlinux.iso of=/dev/sdX \
    bs=4M status=progress conv=fsync
```

`if` is the ISO, `of` is the USB, and `bs=4M` copies in 4 MiB blocks.
Progress is displayed and writes are flushed before the command finishes.
Wait for completion before removing the USB.
