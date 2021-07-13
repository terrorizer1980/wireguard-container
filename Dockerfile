FROM alpine:3.14

RUN echo "@community http://dl-cdn.alpinelinux.org/alpine/v3.14/community" >> /etc/apk/repositories

RUN apk update \
    && apk upgrade \
    && apk add wireguard-tools iptables libqrencode sed