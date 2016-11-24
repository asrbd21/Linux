#!/bin/sh

set -e

##
##   Display help
##
#help()
#{
#    cat <<EOF
#    $PROGNAME --type ldap --name toto [OPTIONS]
#    Display password for specific user and type. Default type is ldap
#
#    --put             Add value for specific key
#    --select          Select key for read 
#    --help            Display this help
#
#Synopsis
#	script.sh [-k] [-f <db_file>] (put (<key> | $<key>) (<value> | $<key>) |
#                                del (<key> | $<key>) [<value> | $<key>] |
#                                select [<expr> | $<key>] |
#								flush)
#
#   Les paramètres sont les suivants:
#
#    - put <key> <value> - Ajoute une clef <key> contenant la valeur
#    <value>. Si la key existe déjà, la valeur est écrasée.
#    Rien n'est affiché.
#    Si la base de données n'existe pas, la commande "put" crée la DB.
#
#    - del <key> [<value>] - Efface la clef <key>. Si la valeur n'est pas precisee,
#    la key reste présente sans contenu. Si la clef n'existe pas ou si la
#    value ne correspond pas à celle de la key, il ne se passe rien.
#    Rien n'est affiché.
#
#    - select [<expr>] - Affiche les values dont les cles correspondent a <expr>.
#    Si aucun parametre n'est donne, toutes les values sont affichees.
#    Expr pourra gerer le meme "globing" que la commande grep.
#
#	flush - Vide toutes la base. Le fichier n'est cependant pas supprime
#
#EOF
#}
#
#
#put()
db="sh.db"
key=""
value=""
key_db=""
if [ -f "$db" ]
then
    echo "db found."
else
    touch $db
    echo "key=('value')" >> $db
    echo "db created."
fi

if [ "$1" = "put" ]
then
    key="$2"
    value="$3"
    for key_db in $(cat "$db" | cut -d "=" -f 1)
    do

        if [ "$key_db" = "$key" ]
        then
            sed -i -e "s/$key=('*')/$key=('$value')/g" $db
        else
            echo "$key=('$value')" >> $db
        fi
    
    done
else
    echo 'c est pas fini :)'
fi

#cat sh.db | cut -d "=" -f 1
#echo "toto=('tata')" >> sh.db
#

#del() 


#select()
    




#
#flush() cat /dev/null > sh.db
#

