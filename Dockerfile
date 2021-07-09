FROM ubuntu:focal as builder

RUN apt-get update && \
    apt-get install -y wireguard && \
    rm -rf /var/lib/apt/lists/*

FROM ubuntu:focal

RUN apt-get update && \
    apt-get install -y iproute2 iptables tcpdump iputils-ping && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /usr/bin/wg /usr/bin/wg-quick /usr/bin/