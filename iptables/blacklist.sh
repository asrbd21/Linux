#!/bin/bash
for ip in $(cat blackip.txt)
do 
	iptables -I INPUT -s $ip -j DROP
done

