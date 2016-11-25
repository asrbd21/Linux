#!/bin/sh
##
# subject: http://formation.gnuside.com/system/linux/administration/tp3
##
## 1 - Preparation

#1.a
whoami

#1.b
ip addr && ifconfig

#1.c
echo "ip: $(ifconfig | egrep "([0-9]{1,3}\.){3}[0-9]{1,3}" | grep -i bcast | cut -d " " -f 12 | cut -d ":" -f 2 | head -n 1)" >> voisin.txt
echo "user: $USER" >> voisin.txt
echo "password: Bonjour, enchanté :)" >> voisin.txt


## 2 - Echauffement
apt-get update && apt-cache search TCP/IP swiss army knife
apt-get install netcat
apt-cache policy openssh-client


### 3 - Avec sa ... et son couteau

## 3.1 - Mode facile

# 3.1.a
# La commande nc permet d'ouvrir un port "l'activer"
# -l permet d'écouter 
# -p pour préciser le port 

## 3.2 - Level up ^_^
wget http://formation.gnuside.com/_export/code/system/linux/administration/tp3?codeblock=0 -O timeservice.sh
chmod u+x timeservice.sh
./timeservice.sh &
ssh root@10.3.107.61 nc 10.3.107.61 1982
# Thu Nov 24 22:42:55 CET 2016
# Le script permet d'executer infiniment (tant que vrai) l'affichage de la date grâce à la fonction idoinesur le port 1982 


## 4 - More than expected

# 4.1 - nmap 
apt-get install nmap
nmap 10.3.107.61
#Starting Nmap 6.47 ( http://nmap.org ) at 2016-11-24 23:13 CET
#Nmap scan report for 10.42.42.242
#Host is up (0.000019s latency).
#Not shown: 997 closed ports
#PORT     STATE SERVICE
#22/tcp   open  ssh
#MAC Address: 00:00:00:00:00:00 (Unknown)

# 4.2 - tcpdump
apt-get install tcpdump
apt-get install apache2 lynx curl 
tcpdump -i eth0
curl -I 127.0.0.1:80
lynx -cookies=1 -accept_all_cookies=1 http://google.fr
# tcpdump sert à suivre tous le traffic réseau
# On observe les échanges entre notre machines et les serbeurs comme la requête dns vers google.fr, les ports utilisé, le type de connexion, de flux
tcpdump -evvnt -i eth0
# -e : affiche l'address mac
# -n ne résou pas les nom de domain (affiche l'ip)
# -t n' affiche pas les timestamp pour chaque dump 
# -i indique l'interface réseau souhaité 


##5 - The Secure Shell 

# 5.1 
apt-get install openssh-server openssh-client
ssh root@10.3.107.61
# J'accède au shell de l'ordinateur de mon voisin
# Il permet donc de se connecter à distance sur un ordinateur possèdant un serveur ssh 

# 5.2
tail -n 20 /var/log/auth.log
# la liste des session qui se sont connecté avec le type d'authentification (pam) l'utilisateur et la date 
sed -i -e "s#PermitRootLogin yes#PermitRootLogin no#g" /etc/ssh/sshd_config
service ssh restart 

