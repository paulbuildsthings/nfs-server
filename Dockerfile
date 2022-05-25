FROM alpine:latest@sha256:efd0190b26581b93c8cfdaa4c8dfaa4e29a06b32b7f061b97c2a217cfc62809a

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
