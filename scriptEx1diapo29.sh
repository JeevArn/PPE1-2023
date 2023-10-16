#!/bin/bash

#Écrire un script qui compte les entités pour une année un type d’entité donnés en argument du programme.

cd ./docs_ex1Arborescence/

year=$1
typeEntite=$2
nbEntite=$(cat ann/$1/*/* | grep $2 | wc -l)
echo "nombre d'annotations de $2 en $1 : $nbEntite"



