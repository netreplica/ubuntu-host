# syntax=docker/dockerfile:1
FROM ubuntu:latest

# Install basic networking tools and LLDPD
RUN apt-get update && DEBIAN_FRONTEND="noninteractive" apt-get install -y \
    curl \
    iproute2 \
    net-tools \
    iputils-ping \
    lldpd \
    tcpdump \
    telnet \
    traceroute \
    wget \
    openssh-server \
    netcat \
    ncat \
    && rm -rf /var/lib/apt/lists/*

COPY portidsubtype.conf /etc/lldpd.d

RUN mkdir /run/sshd
COPY sshd_allow_root.conf /etc/ssh/sshd_config.d/10_allow_root.conf
EXPOSE 22

COPY start.sh /

CMD ["/start.sh",""]
