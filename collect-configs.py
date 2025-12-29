#!/usr/bin/env python3
import logging
import shutil
from pathlib import Path

logging.basicConfig(level=logging.INFO, format="%(name)s - %(levelname)s - %(message)s")
logger = logging.getLogger("config_collector")

HOME = Path.home()
REPO = Path.cwd()

CONFIG_MAP = {
    "hypr": ".config/hypr",
    "kitty": ".config/kitty",
    "swaync": ".config/swaync",
    "zed": ".config/zed",
    "nvim": ".config/nvim",
    "waybar": ".config/waybar",
    "wofi": ".config/wofi",
    "ghostty": ".config/ghostty",
    "i3": ".config/i3",
    "pcmanfm": ".config/pcmanfm",
    ".zshrc": ".zshrc",
    ".zprofile": ".zprofile",
    ".vimrc": ".vimrc",
    ".gitconfig": ".gitconfig",
}


def collect(src: Path, dst: Path):
    if dst.exists():
        shutil.rmtree(dst) if dst.is_dir() else dst.unlink()
    shutil.copytree(src, dst) if src.is_dir() else shutil.copy2(src, dst)
    logger.info(f"Collected {src} -> {dst}")


def main():
    for repo_name, home_path in CONFIG_MAP.items():
        src = HOME / home_path
        dst = REPO / repo_name

        if src.exists():
            collect(src, dst)
        else:
            logger.warning(f"Missing in HOME: {src}")


if __name__ == "__main__":
    main()
