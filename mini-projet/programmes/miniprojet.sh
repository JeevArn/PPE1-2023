#!/usr/bin/env bash

<<correction

if [[ $# -neq 1]];
then
	echo "on veut exactement un argument"
	exit
fi

URLS=$1

if [ ! -f $URLS]
then 
	echo "on attend un fichier pas un dossier"
	exit
fi



lineno=1
while read -r URL
do
	response=$(curl -s -I -L -w "%{http_code}" -o /dev/null $URL)
	encoding=$(curl -s -I -L -w "%{content_type}" -o /dev/null $URL | grep -P -o "charset=\S+" | cut -d"=" -f2 | tail -n 1)
	echo -e "$lineno \t $URL \t $response"
	lineno=$(($lineno + 1))
done < $URLS

correction

if [ $# -ne 1 ]; then
    echo "Ce script nécessite un argument : chemin du fichier txt avec les urls"
    exit 
fi

file=$1
output_file="tableaux/tableau-fr.html"
N=1

###### New Version : create HTML file output ##########

# Ne pas oublier le charset !!!!
echo '<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>PPE Mini-Projet - Tableau</title>
    <!-- Inclure la feuille de style Bulma -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.3/css/bulma.min.css">

</head>

<body>
    <!-- Barre de navigation -->
    <nav class="navbar" role="navigation" aria-label="main navigation">
        <div class="navbar-brand">
            <a class="navbar-item" href="#">
                <h1 class="title is-4">PPE Mini-Projet</h1>
            </a>
        </div>
        <!-- Vous pouvez inclure une barre de navigation ici si nécessaire -->
        <div id="navbar" class="navbar-menu">
            <div class="navbar-start">
                <a class="navbar-item" href="../../index.html">
                    Accueil
                </a>

                <a class="navbar-item" href="tableau-fr.html">
                    Tableau
                </a>

            </div>
        </div>
    </nav>

    <!-- Héros -->
    <section class="hero is-info is-bold">
        <div class="hero-body">
            <div class="container">
                <h1 class="title">Tableau URL</h1>
                <p class="subtitle">Informations sur les URL</p>
            </div>
        </div>
    </section>' > "$output_file"

echo '<!-- Section avec le tableau -->
<section class="section">
        <div class="table is-bordered is-narrow is-hoverable is-fullwidth">
            <table>
                <thead>
                    <tr>
                        <th>#</th>
                        <th>URL</th>
                        <th>HTTP Code</th>
                        <th>Charset</th>
                    </tr>
                </thead>
                <tbody>' >> "$output_file"

while read -r line; do
<<com

Pour extraire le code HTTP de réponse à la requête :
ici -o /dev/null sert à spécifier qu'on n'affiche pas le contenu à l'écran
-s : mode silencieux (pas d'info de progression de la requête)
-w "%{http_code}\n" : pour spécifier le format de sortie -> on demande à avoir uniquement le code HTTP
l'option -L pour suivre les redirections et corriger erreur 301

com
	code=$(curl -o /dev/null -s -w "%{http_code}\n" -L $line) 
<<com

Pour extraire l'encodage :
-I : pour afficher uniquement les entêtes
grep -i "Content-Type" : recherche la ligne d'entête qui contient Content-Type qui contient l'encodage
sed -n <regex> : recherche la regex dans la ligne
's/.*charset=\([^;]*\).*/\1/p' : capture la valeur de l'encodage (tout ce qui suit "charset=" jusqu'au prochain ;)
s/ : début substitution
puis remplace la ligne par la valeur capturée, qui est stockée dans \1
-n : supprime les lignes non modifiées
p : affiche la ligne modifiée

com
	#charset=$(curl -s -I "$line" | grep -i "Content-Type" | sed -n 's/.*charset=\([^;]*\).*/\1/p')
	charset=$(curl -s -I -L -w "%{content_type}" -o /dev/null $line | grep -E -o "charset=\S+" | cut -d"=" -f2 | tail -n 1)
<<com
#autre solution :
#charset=$(curl -s $line | pcregrep -o1 "charset=\"(.*)\"")

#error 301 Moved Permanently : solution -> option -L
#error 404 Not Found et 502 Bad Gateway : pas de solution trouvée, le problème se trouve possiblement côté serveur distant
com
<<oldVersion
	#for i in line
	#do
	#N=$(($N + 1))
	#echo -e "$N\t$line\t$code\t$charset"
	# il faut mettre l'option -e pour mettre des tabulations \t
	#done
	
#done < $file
oldVersion

	echo "        <tr>
            <td>$N</td>
            <td><a href=$line>$line</a></td>
            <td>$code</td>
            <td>$charset</td>
        </tr>" >> "$output_file"
    N=$((N + 1))
done < "$file"

echo "    </tbody>
        </table>
   	 </div>
    </section>
</body>
</html>" >> "$output_file"

echo "Le fichier HTML a été créé : $output_file"