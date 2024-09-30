# Stage 1: Build environment
FROM docker.io/redhat/ubi8 AS builder

LABEL maintainer="Carl Pearson <me@carlpearson.net>"
LABEL org.opencontainers.image.title="cmake-format 0.6"
LABEL description="A container with cmake-format 0.6"
LABEL org.opencontainers.image.description="A container with cmake-format 0.6"
LABEL org.opencontainers.image.source https://github.com/cwpearson/cmake-format
LABEL org.opencontainers.image.licenses="GPLv3"

RUN dnf install -y \
    python3 \
    && dnf clean all

ADD pip-install.sh .
RUN /bin/bash pip-install.sh

# expect caller to map $PWD into /src with -v flag
WORKDIR /src
