#!/usr/bin/env python3
import logging
import shutil
from pathlib import Path

logging.basicConfig(level=logging.INFO, format="%(name)s - %(levelname)s - %(message)s")
logger = logging.getLogger("config_installer")

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


def install(src: Path, dst: Path):
    if dst.exists():
        shutil.rmtree(dst) if dst.is_dir() else dst.unlink()
    dst.parent.mkdir(parents=True, exist_ok=True)
    shutil.copytree(src, dst) if src.is_dir() else shutil.copy2(src, dst)
    logger.info(f"Installed {src.name} -> {dst}")


def main():
    for repo_name, home_path in CONFIG_MAP.items():
        src = REPO / repo_name
        dst = HOME / home_path

        if src.exists():
            install(src, dst)
        else:
            logger.warning(f"Missing in repo: {repo_name}")


if __name__ == "__main__":
    main()
