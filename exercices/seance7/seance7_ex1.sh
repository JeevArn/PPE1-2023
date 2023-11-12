#!/usr/bin/env bash

if [ $# -ne 1 ]
then
    echo "Ce script nécessite un argument : chemin du fichier txt"
    exit 
fi

doc=$1
cat "$doc" | tr '[:punct:]' ' '| tr '[:upper:]' '[:lower:]' | tr -s ' ' | tr ' ' '\n' | grep -v '^$' #| head -n 10

<<com

1) cat $doc						>>> lire le fichier
2) tr '[:punct:]' ' ' 			>>> supprimer la ponctuation et remplacer par un espace
3) tr '[:upper:]' '[:lower:]' 	>>> mettre en minuscules
4) tr -s ' ' 					>>> remplacer les espaces consécutifs par un seul espace avec l'option -s (Squeeze multiple occurrences of the characters into a single instance of the character)
5) tr ' ' '\n' 					>>> remplacer les espaces par des sauts de ligne
6) grep -v '^$' 				>>> exclure les lignes vides avec l'option -v, --invert-match

com
