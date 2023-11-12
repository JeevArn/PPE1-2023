#!/bin/bash

if [ $# -lt 1 ]; then
	echo "Ce script nécessite un argument minimum : chemin du fichier txt (le nombre de bigrammes à afficher est optionnel)"
	exit
fi

cleantext=$(./seance7_ex1.sh "$1")

nb_bigrammes=${2:-25}

echo "$cleantext" | paste -d ' ' - - | sort | uniq -c | sort -nr | head -n "$nb_bigrammes"

<<com

echo "$cleantext" 		>>> Afficher la sortie du premier script
paste -d ' ' - -		>>> Fusionner chaque paire de lignes consécutives avec un espace comme délimiteur, - - veut dire qu'on fait 2 colonnes, on prend 2 lignes consécutives
sort					>>> Trier les bigrammes par ordre alphabétique
uniq -c					>>> Compter le nombre d'occurrences de chaque bigramme consécutif
sort -nr				>>>	Trier les bigrammes par le nombre d'occurrences décroissant
head -n "$nb_bigrammes"	>>> Afficher les premières lignes en fonction du nombre spécifié dans nb_bigrammes

com


