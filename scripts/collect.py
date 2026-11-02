#!/usr/bin/env python3
"""Copy current HOME configs into the dotfiles repository."""

import shutil
from pathlib import Path

HOME = Path.home()
DOTFILES_DIR = Path(__file__).resolve().parent.parent

DOTFILES = {
    "fastfetch": ".config/fastfetch",
    "fuzzel": ".config/fuzzel",
    "swaync": ".config/swaync",
    "hypr": ".config/hypr",
    "yazi": ".config/yazi",
    "yazi.desktop": ".local/share/applications/yazi.desktop",
    "nvim": ".config/nvim",
    "quickshell": ".config/quickshell",
    "alacritty": ".config/alacritty",
    ".zshrc": ".zshrc",
    ".zprofile": ".zprofile",
    ".gitconfig": ".gitconfig",
    "user-dirs.conf": ".config/user-dirs.conf",
    "user-dirs.dirs": ".config/user-dirs.dirs",
}


def collect_configs() -> None:
    """Copy existing configs into the repository.

    Skip missing configs and paths already pointing to the repository.
    Merge directories and overwrite matching files.
    """
    for name, relative_path in DOTFILES.items():
        source = HOME / relative_path
        destination = DOTFILES_DIR / name

        if not source.exists():
            print(f"Skipped missing config: {source}")
            continue

        if source.resolve() == destination.resolve():
            print(f"Already linked: {source}")
            continue

        destination.parent.mkdir(parents=True, exist_ok=True)

        if source.is_dir():
            shutil.copytree(
                source,
                destination,
                dirs_exist_ok=True,
                symlinks=True,
            )
        else:
            shutil.copy2(source, destination)

        print(f"Copied: {source} -> {destination}")


if __name__ == "__main__":
    collect_configs()
