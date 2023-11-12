#!/bin/bash

if [ $# -lt 1 ]; then
	echo "Ce script nécessite un argument minimum : chemin du fichier txt (le nombre de mot à afficher est optionnel)"
	exit
fi

cleantext=$(./seance7_ex1.sh "$1")

nb_mots=${2:-25} #le 2e argument du script prendra 25 comme valeur pas défaut

echo "$cleantext" | sort | uniq -c | sort -nr | head -n "$nb_mots"

<<com

echo "$cleantext" 		>>> Afficher la sortie du premier script
sort					>>> Trier les mots (lignes) par ordre alphabétique
uniq -c					>>> Compter le nombre d'occurrences de chaque mot consécutif
sort -nr				>>>	Trier les mots par le nombre d'occurrences décroissant
head -n "$nb_mots"		>>> Afficher les premières lignes en fonction du nombre spécifié dans nb_mots

com