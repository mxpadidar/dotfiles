#!/usr/bin/env python3
import logging
import shutil
from pathlib import Path

logging.basicConfig(level=logging.INFO, format="%(name)s - %(levelname)s - %(message)s")

logger = logging.getLogger("config_collector")

HOME = Path.home()
CONF_REPO = Path.cwd()


configs = [
    HOME / ".config/hypr",
    HOME / ".config/kitty",
    HOME / ".config/swaync",
    HOME / ".config/zed",
    HOME / ".config/nvim",
    HOME / ".config/waybar",
    HOME / ".config/wofi",
    HOME / ".config/ghostty",
    HOME / ".vimrc",
    HOME / ".zprofile",
    HOME / ".zshrc",
    HOME / ".gitconfig",
]


def copy_item(src: Path, dst: Path):
    """Force copy src into dst, overwriting existing."""
    target = dst / src.name
    if src.is_dir():
        if target.exists():
            shutil.rmtree(target)
        shutil.copytree(src, target)
        logger.info(f"Copied directory {src} -> {target}")
    elif src.is_file():
        shutil.copy2(src, target)
        logger.info(f"Copied file {src} -> {target}")


def main():
    for config in configs:
        if config.exists():
            copy_item(config, CONF_REPO)
        else:
            logger.warning(f"Missing: {config}")


if __name__ == "__main__":
    main()
