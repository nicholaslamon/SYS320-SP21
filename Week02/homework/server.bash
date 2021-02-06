#!/bin/bash

# Storyline: Scirpt to create a wireguard server.

# Create a private key

p="$(wg genkey)"

# Create a public key

pub="$(echo ${p} | wg pubkey)"

# Set the addresses

address="10.254.132.0/24,172.16.28.0/24"


# Set server IP address

ServerAddress="10.254.132.1/24,172.16.28.1/24"

# Set the Listen port

lport="4282"

# Create the format for the client configuration

peerInfo="# ${address} 162.243.2.92:4282 ${pub} 8.8.8.8,1.1.1.1 1280 120 0.0.0.0/0"


: '

# 10.254.132.0/24,172.16.28.0/24 162.243.2.92:4282 8.8.8.8,1.1.1.1 1280 120 0.0.0.0/0
[Interface]
Address = 10.254.132.1/24,172.16.28.1/24
#PostUp = /etc/wireguard/wg-up.bash
#PostDown = /etc/wireguard/wg-down.bash
ListenPort = 4282
PrivateKey = 

'

echo "${peerInfo}
[Interface]
Address = ${ServerAddress}
#PostUp = /etc/wireguard/wg-up.bash
#PostDown = /etc/wireguard/wg-down.bash
ListenPort = ${lport}
PrivateKey = ${p}
" > wg0.conf
