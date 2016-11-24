# A - Echauffement (préparation du système)
apt-get install lvm2
cat /proc/partitions
# vdb et vdc (because i'm using kvm on proxmox) 
dd if=/dev/zero of=/dev/vdb
dd if=/dev/zero of=/dev/vdc
#B - Mise en place de LVM
#B1 - Préparation physique
pvcreate /dev/vdb
pvcreate /dev/vdc
pvscan
#B2 - Formation de groupe
vgcreate vgnextformation /dev/vdb /dev/vdc
vgscan
#B3 - Question de logique
lvcreate vgnextformation -l 30%FREE -n telechargements
lvcreate vgnextformation -l 100%FREE -n archives
lvscan
#C - Chasse et cueillette
#C1 - Observation
cd /dev
for i in $(find | grep vg); do ls -l $i; done
# dm-0 -> telechargements
# dm-1 -> archives
# type: lien symbolique
# Ce sont des lien vers des périphériques physique ( dm-0 et dm-1 ) 
#C1 - Utilisation
mkfs.ext4 /dev/dm-0
mkfs.ext4 /dev/dm-1
mkdir /mnt/telechargements
mount /dev/dm-0 /mnt/telechargements
mkdir /mnt/archives
mount /dev/dm-1 /mnt/archives
mount
mkdir /mnt/telechargements/strangerthings
mkdir /mnt/telechargements/westworld
mkdir /mnt/archives/friends
mkdir /mnt/archives/buffy
#reboot
# Les fichiers ne sont pas là car les volumes logiques dm-0 et dm-1 n'ont pas été monté 
# le fichier fstab permet de définirs des montages de volumes physique, logique (des périphériques de stockage) au démarrage 
# La syntaxe est la composé de:
## - l'identifiant du périphérique = UUID=f91eb3b9-081b-4932-8a2c-ed1be540abb1 
## - le point de montage souhaité = /
## - le format du volume monté = ext4 
## - des options de montage = errors=remount-ro 
## - les options pour l'archivage = 0
## - le poids lors d'une vérification du système de fichiers = 1
echo "/dev/dm-0   /mnt/telechargements   ext4      defaults      0   0" >> /etc/fstab
echo "/dev/dm-1   /mnt/archives   ext4      defaults      0   0" >> /etc/fstab
#D - Bonus
##0 - Shabang sh 
##1 - le script liste les périphérique sata dans dev
##2 - il scan les volumes physiques  
##3 - il check les montage existant 
##4 - il regarde le man de vgextend
##5 - il etend grace à la commande "vgextend" le groupe de volume "vgnextformation" en y ajoutant le volume physique sdd 
##6 - il scan les groupes de volume existant 
##7 - il etend grace à la commande "lvextend" le volume logique archives en utilisant tous l'expace libre restant du groupe de volume vgnextformation
##8 - il scan les volumes physiques
##9 - il redimentionne grace a la commande "resize2fs" le système de fichier présent sur le volume logique archives 

