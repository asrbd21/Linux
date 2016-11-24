#!/bin/bash
##
# subject : http://formation.gnuside.com/system/linux/administration/tp1
##
#A - echauffement
# Un logiciel propriétaire de fournis pas ces sources, un logiciel libre les fournis 

#B - Qui commande ici ?
ls --color
#Permet la gestion des couleurs lors de l execution de la commande ls 
ls -l | grep jpg
#Liste les fichiers sous forme de liste avec les droits, type, date, etc, et on cherche le pattern jpg dans les nom de fichiers/dossiers liste grace a grep 
find -name '*.jpg' | wc -l
#On cherche dans le répertoire courant les fichiers et dossier qui contiennent l extension jpg (photos) et ont les compte grace a wc, -l compte les lignes 
echo "alias ls='ls --color'" > ~/.bashrc
#On créer un alias qui ajoute l'option de couleur vu ci dessus pour tous les appels a la commande dans bash 


#C - Si l'homme descend du singe et le singe descend de l'arbre...
cd /home/patrick 
cd /dev
cd mateo21
cd ..
cd ../../usr/games

#D - Qui commande (suite) ?
echo "My tailor is rich" > ~/mytailor
mkdir /tmp/vestimentaire
mv ~/mytailor /tmp/vestimentaire/
rm -ri /tmp/vestimentaire

#E - Voyage, voyage...
mkdir ~/StageLinux
mkdir ~/StageLinux/Exercice
cd ~/StageLinux/Exercice
mkdir TD
mkdir ../c && mkdir ../java
cd .. && ls -aR
cd Exercice/TD && pwd
cd ../../java && cd ../c
pwd
cd
rm -rf StageLinux/Java
for i in $(history); do $i | tee log_command.txt; done 

#F - Oh mon processus !
# & -> lance la commande en arrière plan et redonne la main tous de suite 
# && -> permet de chainer une commande si la premiere s est dérouler sans erreur 
# ; -> permet de chainer sans verification si la premiere s'est termine sans erreurs

# ctrl-c -> sigterm 9 
# ctrl-z -> equivaut à bg 


