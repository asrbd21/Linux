#!/bin/bash
for ip in $(cat whiteip.txt)
do 
	iptables -I INPUT -s $ip -j ACCEPT
done

