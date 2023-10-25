#!/usr/bin/env bash

if [ $# -ne 1 ]
then
    echo "Ce script nécessite un argument : chemin du fichier txt avec les urls"
    exit 
fi

file=$1
N=0

while read -r line;
do

#Pour extraire le code HTTP de réponse à la requête :
#ici -o /dev/null sert à spécifier qu'on n'affiche pas le contenu à l'écran
# -s : mode silencieux (pas d'info de progression de la requête)
# -w "%{http_code}\n" : pour spécifier le format de sortie -> on demande à avoir uniquement le code HTTP
#l'option -L pour suivre les redirections et corriger erreur 301
code=$(curl -o /dev/null -s -w "%{http_code}\n" -L $line) 

#Pour extraire l'encodage :
# -I : pour afficher uniquement les entêtes
# grep -i "Content-Type" : recherche la ligne d'entête qui contient Content-Type qui contient l'encodage
# sed -n <regex> : recherche la regex dans la ligne
# 's/.*charset=\([^;]*\).*/\1/p' : capture la valeur de l'encodage (tout ce qui suit "charset=" jusqu'au prochain ;)
# s/ : début substitution
# puis remplace la ligne par la valeur capturée, qui est stockée dans \1
# -n : supprime les lignes non modifiées
# p : affiche la ligne modifiée
charset=$(curl -s -I "$line" | grep -i "Content-Type" | sed -n 's/.*charset=\([^;]*\).*/\1/p')

#autre solution :
#charset=$(curl -s $line | pcregrep -o1 "charset=\"(.*)\"")

	for i in line
	do
	N=$(expr $N + 1)
	echo "$N	$line	$code	$charset" 
	#\t ne semble pas marcher pour les tabulations, du coup insertion de tabulation directement entre ""
	done
	
done < $file

#error 301 Moved Permanently : solution -> option -L
#error 404 Not Found et 502 Bad Gateway : pas de solution trouvée, le problème se trouve possiblement côté serveur distant