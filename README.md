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

### Image `CMD` arguments

Typical deployment with SSHD and LLDP in station mode

```Dockerfile
CMD ["/start.sh","-Ss"]
```

Usage:

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

This snippet would launch `host` node in Containerlab with SSH server enabled via `-S` and root password set to `root`

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

## Copyright notice

Copyright 2022 Netreplica Team

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

   http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
