#!/bin/bash
fidsk /dev/sdb
fdisk /dev/sdc
apt-get install mdadm
mdadm --create --verbose /dev/md0 --level=1 --raid-devices=2 /dev/sdb1 /dev/sdc1
mkfs.ext4 /dev/md0
mdadm --detail --scan --verbose > /etc/mdadm/mdadm.conf
mkdir /tmp/backup
mv /home/* /tmp/backup/
mount /dev/md0 /home
mv /tmp/backup/* /home/
echo "/dev/md0   /home   ext3      defaults      0   0" >> /etc/fstab

