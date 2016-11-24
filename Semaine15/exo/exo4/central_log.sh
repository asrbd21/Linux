#!/bin/bash
cat $(find /var/log/ -type f) | grep -i "$(date --date '1 days ago' +"%F")" >> /root/logfile_$(date --date '1 days ago' +"%F")

