#!/bin/bash

# créer un script pour établir le classement des lieux les plus cités.
# prendre en argument l’année, le mois et le nombre de lieux à afficher
# accepter * pour l’année et le mois.

year=$1
month=$2
nbLoc=$3

cat ./ann/"$year"/"$month"/* | grep Location | cut -f 3 | sort | uniq -c | sort -nr | head -n "$nbLoc"
