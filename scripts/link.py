#!/usr/bin/env python3
"""Link repository configs into HOME after creating a timestamped backup."""

import os
import shutil
import tempfile
import zipfile
from datetime import datetime
from pathlib import Path

HOME = Path.home()
DOTFILES_DIR = Path(__file__).resolve().parent.parent

DOTFILES = {
    "wallpapers": "pix/wallpapers",
    "fastfetch": ".config/fastfetch",
    "fuzzel": ".config/fuzzel",
    "swaync": ".config/swaync",
    "hypr": ".config/hypr",
    "yazi": ".config/yazi",
    "yazi.desktop": ".local/share/applications/yazi.desktop",
    "nvim": ".config/nvim",
    "quickshell": ".config/quickshell",
    "ghostty": ".config/ghostty",
    ".zshrc": ".zshrc",
    ".zprofile": ".zprofile",
    ".gitconfig": ".gitconfig",
    "user-dirs.conf": ".config/user-dirs.conf",
    "user-dirs.dirs": ".config/user-dirs.dirs",
    "mimeapps.list": ".config/mimeapps.list",
}


def collect_pending_links() -> list[tuple[Path, Path]]:
    """Collect source and destination pairs that are not already linked.

    Stop if a repository config is missing, before changing any live configs.
    """
    pending = []

    for name, relative_destination in DOTFILES.items():
        source = DOTFILES_DIR / name
        destination = HOME / relative_destination

        if not source.exists():
            raise FileNotFoundError(f"Missing repository config: {source}")

        if destination.is_symlink() and destination.resolve() == source.resolve():
            continue

        pending.append((source, destination))

    return pending


def add_to_backup(backup: zipfile.ZipFile, path: Path) -> None:
    """Archive a config and its contents using paths relative to HOME.

    Store symbolic links themselves rather than copying their targets.
    """
    entries = [path]

    if path.is_dir() and not path.is_symlink():
        entries.extend(path.rglob("*"))

    for entry in entries:
        name = entry.relative_to(HOME).as_posix()

        if entry.is_symlink():
            info = zipfile.ZipInfo(name)
            info.create_system = 3
            info.external_attr = entry.lstat().st_mode << 16
            backup.writestr(info, os.readlink(entry))
        else:
            backup.write(entry, name)


def create_backup(pending: list[tuple[Path, Path]]) -> Path:
    """Back up existing destinations to a timestamped ZIP.

    Build the archive in a temporary directory and publish it only after it
    closes successfully. Keep backups from previous runs.
    """
    timestamp = datetime.now().strftime("%Y-%m-%d_%H-%M-%S_%f")
    backup_path = DOTFILES_DIR / f"backup-{timestamp}.zip"

    with tempfile.TemporaryDirectory(
        prefix=".link-backup-", dir=DOTFILES_DIR
    ) as staging:
        archive = Path(staging) / "backup.zip"

        with zipfile.ZipFile(archive, "w", zipfile.ZIP_DEFLATED) as backup:
            for _, destination in pending:
                if destination.exists() or destination.is_symlink():
                    add_to_backup(backup, destination)

        archive.chmod(0o600)
        archive.replace(backup_path)

    return backup_path


def install_link(source: Path, destination: Path) -> None:
    """Replace a destination with a symbolic link to its repository config.

    The caller must back up the destination before calling this function.
    """
    if destination.is_symlink():
        destination.unlink()
    elif destination.is_dir():
        shutil.rmtree(destination)
    elif destination.exists():
        destination.unlink()

    destination.parent.mkdir(parents=True, exist_ok=True)
    destination.symlink_to(source, target_is_directory=source.is_dir())

    print(f"{destination} -> {source}")


def main() -> None:
    """Collect changes, finish the backup, then install the pending links."""
    pending = collect_pending_links()

    if not pending:
        print("all configs are already linked.")
        return

    backup_path = create_backup(pending)

    print(f"backup: {backup_path}")

    for source, destination in pending:
        install_link(source, destination)


if __name__ == "__main__":
    main()
