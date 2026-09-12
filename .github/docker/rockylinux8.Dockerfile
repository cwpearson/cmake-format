FROM rockylinux:8@sha256:9794037624aaa6212aeada1d28861ef5e0a935adaf93e4ef79837119f2a2d04c

RUN dnf install -y \
    bzip2-devel \
    ca-certificates \
    curl \
    gcc \
    libffi-devel \
    make \
    openssl-devel \
    readline-devel \
    sqlite-devel \
    tar \
    xz-devel \
    zlib-devel \
    && dnf clean all
