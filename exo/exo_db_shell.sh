#!/bin/bash

#### Merci à Papa Peter :) 

display=no
wipe=no
akey=""
dkey=""
value=""
read=""
nbr=0

USAGE="\n
\e[1;33mNOM\n
\e[1;37m\tdb\n
\n
\e[1;33mDESCRIPTION\n
\n
\e[1;37m\tdb permet de gérer des données dans un fichier\n
\n
\e[1;33mOPTIONS\n
\n
\e[1;37m\tInformations générales\n
\n
\e[0;37m\t\t-h afficher l'aide pour la commande\n
\n
\e[1;37m\tIdentification du fichier\n
\n
\e[0;37m\t\t-f sélection du fichier à utiliser\n
\n
\e[1;37m\tActions sur le fichier\n
\n
\e[0;37m\t\t-k Affiche les clés et leur contenu\n
\e[0;35m\t\t\tEx : db.sh -f data.db -k\n
\n
\e[0;37m\t\t-p Ajoute ou remplace une clé sa valeur peut être défini avec l'option -v\n
\e[0;35m\t\t\tEx : db.sh -f data.db -p key1\n
\n
\e[0;37m\t\t-d Supprime une clé en fonction de son nom met si on défini l'option -v de sa valeur\n
\e[0;35m\t\t\tEx : db.sh -f data.db -d key5\n
\n
\e[0;37m\t\t-s Affiche les entrées contenant une chaine ou expression\n
\e[0;35m\t\t\tEx : db.sh -f data.db -s key5\n
\e[0;35m\t\t\tEx : db.sh -f data.db -s '[2-9]'\n
\n
\e[0;37m\t\t-c Efface l'intégralité du fichier\n
\e[0;35m\t\t\tEx : db.sh -f data.db -c\n
\n
\e[1;37m\tDéfinition des valeurs\n
\n
\e[0;37m\t\t-v Permet de définir une valeur lors de l'ajout ou du remplacement d'une clé\n
\e[0;35m\t\t\tEx : db.sh -f data.db -p key1 -v val1\n
\e[0;37m\t\tOu d'ajouter un condition de valeur pour la suppression d'une clé\n
\e[0;35m\t\t\tEx : db.sh -f data.db -d key5 -v val5\n
\n
\e[0;37m"


param ()
{
	if [ "$file" == "" ]
	then
		echo -e "\n\e[0;31mL'option -f est requise !!!\e[0;37m"
		echo -e $USAGE
		exit
	elif [ ! -e "$file" ] && [ "$akey" == "" ]
	then
		echo -e "\n\e[0;31mFichier non trouvé : $file\e[0;37m"
		echo -e $USAGE
		exit
	elif [ $"$akey" != "" ] && [ "$dkey" != "" ]
	then
		echo -e "\n\e[0;31mUne action à la fois !!!\e[0;37m"
		echo -e $USAGE
		exit
	elif [ $"$akey" != "" ] && [ "$read" != "" ]
	then
		echo -e "\n\e[0;31mUne action à la fois !!!\e[0;37m"
		echo -e $USAGE
		exit
	elif  [ $"$dkey" != "" ] && [ "$read" != "" ]
	then
		echo -e "\n\e[0;31mUne action à la fois !!!\e[0;37m"
		echo -e $USAGE
		exit
	elif [ "$display" == "no" ] && [ "$wipe" == "no" ] && [ $"$akey" == "" ] && [ "$dkey" == "" ] && [ "$read" == "" ]
	then
		echo -e "\n\e[0;31mPas d'action choisie !!!\e[0;37m"
		echo -e $USAGE
		exit
	fi
}

displaying()
{
	nbr=`cat $file | wc -l`
	if [ $nbr -gt 0 ]
	then
		echo -e "\e[0;32m"
	fi
	cat $file | more
	echo -e "\e[0;32m\n$nbr occurence(s) affichée(s)"
	echo -e "\e[0;37m"
}


injection()
{
	if [ ! -e "$file" ]
	then
		touch $file
	fi
	
	if [ `cat $file | grep -c "<$akey>=<$value>"` != "0" ]
	then
			echo -e "\e[0;31m\nL'occurence existe déjà"
	elif [ `cat $file | grep -c "<$akey>="` != "0" ]
	then
		match=`cat $file | grep "<$akey>="`
		sed -r "s/^<$akey>=.*$/<$akey>=<$value>/g" $file > db.tmp
		mv db.tmp $file
		echo -e "\n\e[0;32m$match"
		echo -e "\nOccurence remplacée"
	else
		echo -e "\n\e[0;32m<$akey>=<$value>"
		echo "<$akey>=<$value>" >> $file
		echo -e "\nOccurence ajoutée"
	fi

	echo -e "\e[0;37m"
}

suppression()
{
	match=""
	if [ "$value" == "" ]
	then
		nbr=`cat $file | grep -c "<$dkey>="`
		match=`cat $file | grep "<$dkey>="`
		cat $file | grep -v "<$dkey>" > db.tmp
		mv db.tmp $file
		
	else
		nbr=`cat $file | grep -c "<$dkey>=<$value>"`
		match=`cat $file | grep "<$dkey>=<$value>"`
		cat $file | grep -v "<$dkey>=<$value>" > db.tmp
		mv db.tmp $file
	fi
	
	if [ "$match" != "" ]
	then
		echo -e "\n\e[0;31m$match"
	fi
	echo -e "\e[0;31m\n$nbr occurence(s) supprimée(s)"
	echo -e "\e[0;37m"
}

selection()
{
	nbr=`grep -c "$read" $file`
	if [ $nbr -gt 0 ]
	then
		echo -e "\e[0;32m"
	fi
	grep "$read" $file
	echo -e "\e[0;32m\n$nbr occurence(s) trouvée(s)"
	echo -e "\e[0;37m"
}

wipe ()
{
	nbr=`cat $file | wc -l`
	echo -e "\e[0;31m"
	for line in `cat $file`; do echo $line; done
	> $file
	echo -e "\n$nbr occurence(s) supprimée(s)"
	echo -e "\e[0;37m"
	
}


main()
{
	while getopts kf:p:v:d:s:ch option;
	do
		case $option in
			k) display=yes;;
			f) file=$OPTARG;;
			p) akey=`echo $OPTARG | sed -e "s/\\$//"`;;
			v) value=`echo $OPTARG | sed -e "s/\\$//"`;;
			d) dkey=`echo $OPTARG | sed -e "s/\\$//"`;;
			s) read=`echo $OPTARG |sed -e "s/\\$//"`;;
			c) wipe=yes;;
			h) echo -e $USAGE; exit;;
			\?) echo "Invalid option: -$OPTARG" >&2;echo -e $USAGE;exit;;
		esac
	done
	
	param

	if [ "$display" == "yes" ]
	then
		displaying
	elif [ "$wipe" == "yes" ]
	then
		wipe
	elif [ "$akey" != "" ]
	then
		injection
	elif [ "$dkey" != "" ]
	then
		suppression
	elif [ "$read" != "" ]
	then
		selection
	fi

}

main $*

