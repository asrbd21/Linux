#!/bin/bash
iptables -A INPUT -m conntrack --ctstate ESTABLISHED -j ACCEPT

