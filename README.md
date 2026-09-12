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

Every push to a branch builds all three binaries. Pushing a tag also uploads
the built binaries and creates a GitHub release named after that tag. The Linux
binaries are built inside a pinned Rocky Linux 8 container (glibc 2.28 baseline)
on Linux amd64 and Linux arm64 runners. After each binary is built, it is
smoke-tested on the GitHub Actions host with `--version`. The macOS arm64 binary
is built natively on macOS arm64.

To build locally on your host:

```sh
python3 -m pip install "cmakelang==0.6.13" "PyInstaller==6.21.0"
python3 scripts/build.py
./dist/cmake-format --version
```

To reproduce the Linux release environment locally, first build the pinned
Rocky Linux 8 image. The workflow builds CPython with a shared library inside
the container because PyInstaller requires one:

```sh
docker build --pull=false --tag cmake-format-build:rockylinux8 \
  --file .github/docker/rockylinux8.Dockerfile .
docker run --rm --user "$(id -u):$(id -g)" -v "$PWD:/work" -w /work \
  -e HOME=/tmp -e CMAKE_FORMAT_VERSION=0.6.13 -e PYINSTALLER_VERSION=6.21.0 -e CPYTHON_VERSION=3.12.12 \
  cmake-format-build:rockylinux8 \
  bash -lc 'curl -fsSL -o "/tmp/Python-${CPYTHON_VERSION}.tgz" "https://www.python.org/ftp/python/${CPYTHON_VERSION}/Python-${CPYTHON_VERSION}.tgz" && tar -xzf "/tmp/Python-${CPYTHON_VERSION}.tgz" -C /tmp && cd "/tmp/Python-${CPYTHON_VERSION}" && ./configure --prefix=/tmp/cpython --enable-shared --with-ensurepip=install && make -j"$(nproc)" && make install && export LD_LIBRARY_PATH=/tmp/cpython/lib && /tmp/cpython/bin/python3 -c "import ssl; print(ssl.OPENSSL_VERSION)" && /tmp/cpython/bin/python3 -m pip install "cmakelang==${CMAKE_FORMAT_VERSION}" "PyInstaller==${PYINSTALLER_VERSION}" && cd /work && /tmp/cpython/bin/python3 scripts/build.py'
```

This project packages [cmakelang / cmake-format](https://github.com/cheshirekow/cmakelang), which is licensed under GPL-3.0.
