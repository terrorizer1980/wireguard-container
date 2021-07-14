#!/bin/bash
#set -x

PRIVKEY=`wg genkey`
PUBKEY=`echo $PRIVKEY | wg pubkey`

read -p "Client Name: " CLIENT_NAME
read -p "Client IP: " CLIENT_IP

CLIENT_NAME_FILE=`sed -e 's/[[:space:][:punct:]]//g' <<< "$CLIENT_NAME" | tr '[:upper:]' '[:lower:]'`

CLIENT_CFG=$(cat << EOF
[Interface]
PrivateKey = $PRIVKEY
Address = $CLIENT_IP/24
DNS = 192.168.0.254

[Peer]
PublicKey = 14YhHPvnqOCNcGlmxmvMlcrhzXo3tC+q+oXZlA3Xjlk=
AllowedIPs = 192.168.0.0/16
Endpoint = server:port
PersistentKeepalive = 15
EOF
)

echo
echo "########## Server config ##########"
cat << EOF
[Peer]
# $CLIENT_NAME
PublicKey = $PUBKEY
AllowedIPs = $CLIENT_IP/32
EOF

echo
echo "########## Client config ##########"
echo "$CLIENT_CFG"
echo
echo "$CLIENT_CFG" | qrencode -t ansiutf8
