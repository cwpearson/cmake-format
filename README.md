# cmake-format binaries

Standalone `cmake-format` v0.6.13 executables, built with PyInstaller.

## Downloads

| Platform | Latest binary |
| --- | --- |
| Linux amd64 | [cmake-format-0.6.13-linux-amd64](https://github.com/cwpearson/cmake-format/releases/latest/download/cmake-format-0.6.13-linux-amd64) |
| Linux arm64 | [cmake-format-0.6.13-linux-arm64](https://github.com/cwpearson/cmake-format/releases/latest/download/cmake-format-0.6.13-linux-arm64) |
| macOS arm64 | [cmake-format-0.6.13-macos-arm64](https://github.com/cwpearson/cmake-format/releases/latest/download/cmake-format-0.6.13-macos-arm64) |

For example, on Linux amd64:

```sh
curl -L -o cmake-format https://github.com/cwpearson/cmake-format/releases/latest/download/cmake-format-0.6.13-linux-amd64
chmod +x cmake-format
./cmake-format --version
```

## Releases

Every push to a branch builds and publishes all three binaries. The workflow
creates a release tag in the form `<branch>-<short-sha>` (for example,
`main-a1b2c3d`) at the pushed commit. It runs natively on Linux amd64, Linux
arm64, and macOS arm64.

To build locally:

```sh
python3 -m pip install "cmakelang==0.6.13" "PyInstaller==6.21.0"
python3 scripts/build.py
./dist/cmake-format --version
```

This project packages [cmakelang / cmake-format](https://github.com/cheshirekow/cmakelang), which is licensed under GPL-3.0.
