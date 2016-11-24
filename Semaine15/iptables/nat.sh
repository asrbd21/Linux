#!/bin/bash
for ip in $(cat blackip.txt)
do 
	iptables -I INPUT -s $ip -j DROP
done
:PREROUTING ACCEPT [1347:412154]
:INPUT ACCEPT [109:12096]
:OUTPUT ACCEPT [904:62271]
:POSTROUTING ACCEPT [515:34272]
-A POSTROUTING -o vmbr0 -m comment --comment "nat openvpn vmbr0" -j MASQUERADE
-A POSTROUTING -s 192.168.5.0/24 -o vmbr0 -m comment --comment "nat openvpn vmbr0" -j MASQUERADE

