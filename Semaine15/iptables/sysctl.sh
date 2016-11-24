#!/bin/bash
## Activer le routage 
sysctl -w net.ipv4.ip_forward=1
## Activer la protection handshake TCP grâce aux cookies
sysctl -w net.ipv4.tcp_syncookies=1
## Désactiver le ping
sysctl -w icmp_echo_ignore_broadcasts=1
## Modifier le nombre de fois qu’un segment SYN/ACK sera retransmis sur une connexion TCP passive à 3
sysctl -w net.ipv4.tcp_synack_retries=3
## Modifier la quantité de mémoire disponible pour les files d’attente d’entrée et sortie de socket: Memoire par défault 
sysctl -w net.core.rmem_default=65535
sysctl -w net.core.wmem_default=65535
## Mémoire max pour rmem et wmem
sysctl -w net.core.rmem_max=8388608
sysctl -w net.core.wmem_max=8388608
## Mémoire du tampon 
sysctl -w net.ipv4.tcp_rmem='4096 65535 8388608'
sysctl -w net.ipv4.tcp_wmem='4096 65535 8388608'
##
sysctl net.ipv4.tcp_mem='8388608 8388608 8388608'

