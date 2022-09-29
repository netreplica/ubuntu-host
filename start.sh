#!/bin/bash

function usage {
  echo "Usage: $(basename $0) [-s|r] [-l|C] [-S] [-h]" 2>&1
  echo '   -s         station mode: disable ip_forwarding' 2>&1
  echo '   -r         router  mode: enable  ip_forwarding' 2>&1
  echo '   -l <port>  listen on the port with ncat' 2>&1
  echo '   -C <port>  start ncat chat sevice on the port' 2>&1
  echo '   -S         launch SSH daemon' 2>&1
  echo '   -h         show usage' 2>&1
}

# list of arguments expected in the input
optstring=":srl:C:Sh"

while getopts ${optstring} arg; do
  case ${arg} in
    s)
      # Disable IP forwarding to prevent lldpd from announcing Router capabilities
      sysctl net.ipv4.conf.all.forwarding=0
      sysctl net.ipv6.conf.all.forwarding=0
      ;;
    r)
      # Enable IP forwarding to let lldpd announce Router capabilities
      sysctl net.ipv4.conf.all.forwarding=1
      sysctl net.ipv6.conf.all.forwarding=1
      ;;
    l)
      # Launch netcat in the background as a listener
      nohup /usr/bin/ncat -l -p $OPTARG -k --no-shutdown &
      ;;
    C)
      # Launch netcat in the background as a chat service
      nohup /usr/bin/ncat -l -p $OPTARG -k --chat --no-shutdown &
      ;;
    S)
      # Launch SSH daemon
      /usr/sbin/sshd -f /etc/ssh/sshd_config
      ;;
    h)
      usage
      exit
      ;;
    ?)
      usage
      exit 2
      ;;
  esac
done

# Launch lldpd in foreground
lldpd -d