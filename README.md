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

### macOS quarantine

If macOS blocks the downloaded binary, clear its quarantine attribute before
running it:

```sh
xattr -d com.apple.quarantine cmake-format
```

## Releases

Every push to a branch builds and publishes all three binaries. The workflow
creates a release tag in the form `<branch>-<short-sha>` (for example,
`main-a1b2c3d`) at the pushed commit. The Linux binaries are built inside
`manylinux2014` containers (CentOS 7 / glibc 2.17 baseline) on Linux amd64 and
Linux arm64 runners to keep their runtime GLIBC requirements as old as practical.
After each binary is built, it is smoke-tested on the GitHub Actions host with
`--version`. The macOS arm64 binary is built natively on macOS arm64.

To build locally on your host:

```sh
python3 -m pip install "cmakelang==0.6.13" "PyInstaller==6.21.0"
python3 scripts/build.py
./dist/cmake-format --version
```

To reproduce the Linux release environment locally, use the matching
`manylinux2014` image for your architecture. The workflow installs a conda-forge
Python with micromamba because the Python interpreters bundled in the manylinux
images are not built with the shared library that PyInstaller requires:

```sh
docker run --rm --user "$(id -u):$(id -g)" -v "$PWD:/work" -w /work \
  -e HOME=/tmp -e CMAKE_FORMAT_VERSION=0.6.13 -e PYINSTALLER_VERSION=6.21.0 \
  quay.io/pypa/manylinux2014_x86_64 \
  bash -lc 'curl -Ls "https://micro.mamba.pm/api/micromamba/linux-64/latest" | tar -xvj -C /tmp bin/micromamba && export MAMBA_ROOT_PREFIX=/tmp/micromamba && /tmp/bin/micromamba create -y -n build -c conda-forge python=3.12 pip && /tmp/micromamba/envs/build/bin/python -m pip install "cmakelang==${CMAKE_FORMAT_VERSION}" "PyInstaller==${PYINSTALLER_VERSION}" && /tmp/micromamba/envs/build/bin/python scripts/build.py'
```

This project packages [cmakelang / cmake-format](https://github.com/cheshirekow/cmakelang), which is licensed under GPL-3.0.
