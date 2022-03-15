# nfs-server
A container for running an NFS server. This starts a simple NFS server and
exports one directory so that others may connect.

## Running on Docker

This container expects to listen on one port and have one mounted volume. It
needs to listen on port 2049 TCP. It needs to have `/export` mounted to
something.

    docker build -t ghcr.io/paullockaby/nfs-server:latest .
    docker run --rm --privileged -p 2049:2049/tcp -v $PWD/example:/export ghcr.io/paullockaby/nfs-server:latest

The following environment variables can be set to modify the functionality of
the container:

* `READ_ONLY` can be set to any value to make the export read-only. Otherwise it
  will be read/write by default.
* `ASYNC` can be set to any value to make the export async instead of sync.

After Docker has started the container you can mount your NFS export directory
like this:

    mkdir -p /mnt/nfs
    mount -t nfs 127.0.0.1:/ /mnt

You may need to install NFS tools in order to mount NFS servers.

## Credit

This is an updated and modified version of the NFS server container provided by Steven Iveson.
His version [can be found on GitHub](https://github.com/sjiveson/nfs-server-alpine) and also on
[found on Docker Hub](https://hub.docker.com/r/itsthenetwork/nfs-server-alpine).
