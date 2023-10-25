#!/bin/bash

# créer un script pour établir le classement des lieux les plus cités.
# prendre en argument l’année, le mois et le nombre de lieux à afficher
# accepter * pour l’année et le mois.

#year=$1
#month=$2
#nb=$3

#cat ./docs_ex1Arborescence/ann/"$year"/"$month"/* | grep Location | cut -f 3 | sort | uniq -c | sort -nr | head -n "$nb"

if [ $# -ne 3 ]
then
    echo "Ce script nécessite trois arguments : année, mois, et nombre de lieux à afficher"
    exit 
fi

if [ ! -d "./docs_ex1Arborescence/ann/$1/$2" ]
then
    echo "Le répertoire du mois $2 n'existe pas."
    exit  
fi

if [ ! -d "./docs_ex1Arborescence/ann/$1" ]
then
    echo "Le répertoire de l'année $1 n'existe pas."
    exit 
fi

cat ./docs_ex1Arborescence/ann/"$1"/"$2"/* | grep Location | cut -f 3 | sort | uniq -c | sort -nr | head -n "$3"

# resultat : l'étoile n'est toujours pas acceptée comme argument même entre ""