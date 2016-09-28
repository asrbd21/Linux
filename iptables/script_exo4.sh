#!/bin/bash
## Vider toutes les tables
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X
iptables -P INPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -P OUTPUT ACCEPT
iptables -t nat -P PREROUTING ACCEPT
iptables -t nat -P POSTROUTING ACCEPT
iptables -t nat -P OUTPUT ACCEPT
## Autoriser les states déjà établies
iptables -A INPUT -m conntrack --ctstate ESTABLISHED -j ACCEPT
## DNS en sortie
iptables -A OUTPUT -o eth0 --protocol udp --destination-port 53 -j ACCEPT
iptables -A OUTPUT -o eth0 --protocol tcp --destination-port 53 -j ACCEPT
## DNS en entree
iptables -A INPUT -i lo --protocol udp --source-port 53 -j ACCEPT
iptables -A INPUT -i lo --protocol tcp --source-port 53 -j ACCEPT
iptables -A INPUT -s $(route | awk '{ print $1 }' | grep -vE 'Table|Destination|default') --protocol udp --source-port 53 -j ACCEPT
iptables -A INPUT -s $(route | awk '{ print $1 }' | grep -vE 'Table|Destination|default') --protocol udp --source-port 53 -j ACCEPT
## SSH 
-A OUTPUT -p tcp -m tcp --sport 22 -j ACCEPT
-A OUTPUT -p tcp -m tcp --sport 22 -j ACCEPT

