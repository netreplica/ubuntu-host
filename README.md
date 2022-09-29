# ubuntu-host
Ubuntu host node for emulated network topologies

## Overview

`netreplica/ubuntu-host` Docker image provides the following capabilities:

* LLDP daemon
* SSH daemon
* `ncat chat` service

In addition, it includes a variety of networking utilities like `tcpdump`, `curl`. See [Dockerfile](Dockerfile) for a complete list.

## Building the image

### Using `local` tag for custom builds

```Shell
docker image build -t ubuntu-host:local .
```
## Using the image

### Image `command` arguments

```
Usage: start.sh [-s|r] [-l|C] [-S] [-h]
   -s         station mode: disable ip_forwarding
   -r         router  mode: enable  ip_forwarding
   -l <port>  listen on the port with ncat
   -C <port>  start ncat chat sevice on the port
   -S         launch SSH daemon
   -h         show usage
```

### Adding `ubuntu-host` to Containerlab

This snipper would launch `host` node in Containerlab with SSH server enabled via `-S` and root password set to `root`

```Yaml
topology:
  nodes:
    host1:
      kind: linux
      image: ubuntu-host:local
      cmd: /start.sh -S
      exec:
        - bash -c "echo root:root | chpasswd"
```