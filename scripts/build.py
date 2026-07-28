#!/usr/bin/env python3
"""Build a single-file cmake-format executable with PyInstaller."""

from __future__ import annotations

import argparse
import shutil
import subprocess
import sys
from pathlib import Path


ROOT = Path(__file__).resolve().parent.parent
DIST = ROOT / "dist"
BUILD = ROOT / "build"


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--name", default="cmake-format", help="name of the output executable"
    )
    args = parser.parse_args()

    shutil.rmtree(DIST, ignore_errors=True)
    shutil.rmtree(BUILD, ignore_errors=True)

    subprocess.run(
        [
            sys.executable,
            "-m",
            "PyInstaller",
            "--noconfirm",
            "--clean",
            "--onefile",
            "--name",
            args.name,
            "--distpath",
            str(DIST),
            "--workpath",
            str(BUILD),
            "--specpath",
            str(BUILD),
            str(ROOT / "cmake_format.py"),
        ],
        check=True,
    )


if __name__ == "__main__":
    main()
