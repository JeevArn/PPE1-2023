#!/bin/bash

#Écrire un script qui compte les entités pour une année un type d’entité donnés en argument du programme.

if [ $# -ne 2 ]
then
    echo "Ce script nécessite deux arguments : année et type d'entité"
    exit 
fi

year=$1
typeEntite=$2

if [ ! -d "./docs_ex1Arborescence/ann/$year" ]
then
    echo "Le répertoire de l'année $year n'existe pas."
    exit  
fi

nbEntite=$(cat ./docs_ex1Arborescence/ann/$year/*/* | grep $typeEntite | wc -l)
echo "Nombre d'annotations de $typeEntite en $year : $nbEntite"
