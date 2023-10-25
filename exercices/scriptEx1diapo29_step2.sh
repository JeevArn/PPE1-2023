#!/bin/bash

#Écrire un second script qui lance le script précédent trois fois, une fois pour chaque années, en prenant le type d’entité en argument.

if [ $# -ne 1 ]
then
    echo "Ce script nécessite un argument : le type d'entité"
    exit  
fi

chmod +x scriptEx1diapo29.sh
typeEntite=$1

./scriptEx1diapo29.sh 2016 "$typeEntite"
./scriptEx1diapo29.sh 2017 "$typeEntite"
./scriptEx1diapo29.sh 2018 "$typeEntite"
