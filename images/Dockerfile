FROM debian:buster-slim

ARG RUST_VERSION
ARG RUSTUP_PROFILE
ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ca-certificates=20190110 \
    gcc=4:8.3.0-1 \
    libc6-dev=2.28-10 \
    wget=1.20.1-1.1 && \
    rm -rf /var/lib/apt/lists/*

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN url="https://static.rust-lang.org/rustup/dist/x86_64-unknown-linux-gnu/rustup-init" && \
    wget ${url} && \
    chmod +x rustup-init && \
    ./rustup-init -y --no-modify-path --profile ${RUSTUP_PROFILE} --default-toolchain ${RUST_VERSION} && \
    rm rustup-init && \
    chmod -R a+w ${RUSTUP_HOME} ${CARGO_HOME} && \
    rustup --version && \
    cargo --version && \
    rustc --version

RUN apt-get remove -y --auto-remove wget && \
    rm -rf /var/lib/apt/lists/*
