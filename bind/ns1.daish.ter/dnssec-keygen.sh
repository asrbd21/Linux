#!/bin/bash
dnssec-keygen -a NSEC3RSASHA1 -b 2048 -n ZONE daish.ter.zone
dnssec-keygen -f KSK -a NSEC3RSASHA1 -b 4096 -n ZONE daish.ter.zone
if [ -f "*.key"]
for key in $(ls Kdaish.ter.*.key)
do
    echo "\$INCLUDE $key" >> db.daish.ter.zone
done
if [ -f "/var/lib/named/db.daish.ter.zone" ]
then
    dnssec-signzone -A -3 $(head -c 1000 /dev/random | sha1sum | cut -b 1-16) -N INCREMENT -o daish.ter -t daish.ter.zone
else
    echo "No key found"
fi

