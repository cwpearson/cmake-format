# cmake-format

## Quick Run

```bash
cd your/source/tree
podman run --rm -v "${PWD}"/src ghcr.io/cwpearson/cmake-format:0.6.13 cmake-format ...
```

Inside the container, the working directory is /src, we use the volume mount to map the host working directory `${PWD}` into `/src`: `-v "${PWD}"/src`.

## Building the Image Locally

```bash
podman build -f cmake-format-0.6.13.dockerfile -t cmake-format:0.6.13
podman run --rm -v "${PWD}"/src cmake-format:0.6.13 cmake-format ...
```

## Deploy

1. Create a "personal access token (classic)" with `write:packages`
  * account > settings > developer settings > personal access tokens
2. Put that personal access token as the repository secret `GHCR_TOKEN`.
