#!/bin/bash

#Écrire un second script qui lance le script précédent trois fois, une fois pour chaque années, en prenant le type d’entité en argument.

typeEntite=$1
./scriptEx1diapo29.sh 2016 "$1"
./scriptEx1diapo29.sh 2017 "$1"
./scriptEx1diapo29.sh 2018 "$1"