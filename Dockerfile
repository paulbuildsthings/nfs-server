FROM alpine:latest@sha256:d6d0a0eb4d40ef96f2310ead734848b9c819bb97c9d846385c4aca1767186cd4 AS base

# github metadata
LABEL org.opencontainers.image.source=https://github.com/paullockaby/nfs-server

# install minimal tools and do not store caches
RUN apk add --no-cache --update --verbose nfs-utils bash

RUN mkdir -p /var/lib/nfs/rpc_pipefs && \
    mkdir -p /var/lib/nfs/v4recovery && \
    mkdir -p /export && \
    echo "rpc_pipefs /var/lib/nfs/rpc_pipefs rpc_pipefs defaults 0 0" >> /etc/fstab && \
    echo "nfsd /proc/fs/nfsd nfsd defaults 0 0" >> /etc/fstab

COPY entrypoint /entrypoint
RUN chmod +x /entrypoint

VOLUME ["/export"]
EXPOSE 2049/tcp
ENTRYPOINT ["/entrypoint"]
