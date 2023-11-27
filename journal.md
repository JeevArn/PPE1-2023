# Journal de Jeevya

# Séance 1
## 20 septembre 2023

commandes utiles pour l'ex 1 :
- mkdir : créer un dossier
- cd : aller dans un dossier / changer de dossier
- mv : déplacer un fichier

- && : pour faire plusieurs commandes en même temps
- "*" : remplacer des caractères dans un nom de fichier (ex: *.txt)

# Séance 2
## 27 septembre 2023

Tâches effectuées pendant le cours :
- correction ex1Arborescence
- création d'une clé de sécurité github
- création d'un clone du dépôt PPE1-2023
- synchronisation du dépôt de manière à récupérer les nouveaux docs déposées
  
astuce : touche tabulation pour auto-complétion

éléments correction de l'ex 1 :
- unzip
- option -p (pour mkdir) : créer une arborescence de dossier (ex: mkdir -p txt/2017/01)
- chemin pour retrouver l'historique des commandes : .bash_history

synchronisation de l’ordi avec le dépôt distant sur github :
- création d'une clé de sécurité ; cryptographie asymétrique, à clé publique -> 2 clés : 1 que tous le monde pourra voir et une clé privée : visible par nous uniquement

commandes git :
- git add <FILE>
- git status
- ls -a pour voir si c'est bien un dépôt synchronisé avec git
- git commit -m "remplir message et ne pas fermer les guillemets. (1 commit = un "paquet" de plusieurs changement avec add)
- git push : pousser les modifications
- git fetch : récupérer journal des modification, les metadonnées du dépôt
- git **pull** : **pour mettre à jour le dépôt sur l'ordi**, récupérer les nouveaux commits
- git rm : pour supprimer, mais peut revenir si on met à jour le dépôt
- git log : permet de voir l'ensemble des commits
- git tag -a -m tagname [commit (si diff du commit courant)]

A effectuer chaque semaine : **add > commit > push** 

# Séance 3
## 4 octobre 2023

Sujet de la séance : Comment corriger des erreurs sur github ?

**git reset** <commit> :

- HEAD : commit actuel
- <tag> : étiquette placé sur un commit spécifique
- ~[N] : remonter la flèche de l'ascendance directe ex : ~[1] représente le commit parent => non linéaire
- ^[N] : Nième parent du commit ex: ^[1] : commit parent => linéaire
- git reset HEAD~ : revenir avant le commit actuel, et annule la mise en place --soft HEAD~ ne l'annule pas
  => fonctionne uniquement sur commit et pas sur fichiers spécifiques
- gti reset --hard : fichier supprimé, retour version HEAD

**git revert** <commit> : créer un nouveau commit où les changements ont été marqués comme annulés (<commit> : SHA ou tag)

difficultés rencontrées pour les exercices :
- une fois git reset appliqué au dernier commit, impossible de push des modifications sur le dépôt distant : "Updates were rejected because the tip of your current branch is behind"
- tentatives pour résoudre le problème : création d'une branche temporaire, puis git reset --hard main, puis git cherry-pick une série de commits depuis la branche temporaire
  => résultat : ça n'a pas marché

# Séance 4
## 9 octobre 2023

Abordé lors de la séance : 
- les pipelines
- intro aux scripts

Difficultés rencontrées pour les exercices : 
- pas réussi à accepter * pour l’année et le mois dans l'ex 2
- même '*' entre guillemet ça ne marche pas

Création du groupe pour le projet avec Anissa (inalco) et Constance (inalco).

Résolution du conflit rencontré en séance 3 avec :
- git config pull.rebase true
- résolution manuelle du conflit dans journal.md
- git add journal.md
- git rebase --continue

# Séance 5
## 18 octobre 2023

Abordé lors de la séance:
- instructions de contrôle
- test de vérification pour être sûr que toutes les conditions sont réunies (présence d'argument si requis, existence du fichier) avant de lancer des commandes

Pour le projet :
- on va faire des aspirations de pages web
- enlever les balises du html pour avoir juste le texte

codes HTTP :
- 1XX : information
- 200 : réussite
- 3XX : redirections
- 4XX : erreurs du client
- 5XX : erreurs du serveurs

Lynx : navigateur web en terminal
-> retire tout le metatexte

- option --dump : pour afficher le contenu textuel d'une page
- option --dump --listonly : affiche uniquement la liste des liens
- --nolist : sans les liens

wget et curl :      
options:
- -i :info sur interaction avec serveur
- -L : suit les redirections
- -o <fichier> : indique un fichier de sortie     

# Séance 6
## 25 octobre 2023           

choix du mot pour le projet : "festival" (hésitation avec "genre")     
langues : anglais ; thai ; coréen 
=> problématiser le choix du mot

Abordé lors de la séance :
- révision HTML -> pour le rendu final du projet
- construction de tableaux
- il faudra avoir uniquement des codes 200 (réussite) dans le tableau
- avoir un seul encodage au mieux UTF-8

Exo lynx :
lynx https://fr.wikipedia.org/wiki/Festival --dump > wikiFestival.txt
lynx https://fr.wikipedia.org/wiki/Festival --dump --nolist > wikiFestivalNoLinks.txt

Mini-projet :

- lire le fichier ligne par ligne
- vérifier si l'url est ok
- si l'encodage est en UTF-8
- si conditions réunies : alors on extrait le texte la page
=> et à chaque fois si ça ne marche pas, soit on ne fait rien soit on effectue des traitement

le script devra :
- récupérer les url contenue dans le texte
- écrire sur le terminal des info separées par des tabulations

EX1 :

1) pourquoi on n'utilise pas 'cat' :
- car il va juste l'afficher, pas pratique pour faire des opérations après
- si espaces dans les urls alors ça posera problème

2) transformer "urls/fr.txt" en paramètre du script
- remplacer par $1
- ajout du if [ $# -ne 1 ]

EX2 :

1) Pour extraire le code HTTP de réponse à la requête : code=$(curl -o /dev/null -s -w "%{http_code}\n" -L $line)
- -o /dev/null sert à spécifier qu'on n'affiche pas le contenu à l'écran
- s : mode silencieux (pas d'info de progression de la requête)
- -w "%{http_code}\n" : pour spécifier le format de sortie -> on demande à avoir uniquement le code HTTP
- l'option -L pour suivre les redirections et corriger erreur 301 Moved Permanently
- 404 Not Found et 502 Bad Gateway : pas de solution trouvée

2) Pour extraire l'encodage : charset=$(curl -s -I "$line" | grep -i "Content-Type" | sed -n 's/.*charset=\([^;]*\).*/\1/p')
- -I : pour afficher uniquement les entêtes
- grep -i "Content-Type" : recherche la ligne d'entête qui contient Content-Type qui contient l'encodage
- sed -n <regex> : recherche la regex dans la ligne
- 's/.*charset=\([^;]*\).*/\1/p' : capture la valeur de l'encodage (tout ce qui suit "charset=" jusqu'au prochain ;)
- s/ : début substitution
- puis remplace la ligne par la valeur capturée, qui est stockée dans \1
- -n : supprime les lignes non modifiées
- p : affiche la ligne modifiée


# Séance 7
## 8 novembre 2023 

correction du mini-projet :
- pour récupérer le code http, on a 3 options :
curl -s -I https://fr.wikipedia.org/wiki/Robot | head -1 | grep -P -o '[0-9]{3}'
curl -s -I https://fr.wikipedia.org/wiki/Robot | head -1 | cut -d" " -f2 
curl -s -I -w "%{http_code}" -o /dev/null https://fr.wikipedia.org/wiki/Robot

-w : (write out) on va récupérer des info sur l'interaction entre nous et le serveur distant par exemple ici "%{http_code}"

suivre toutes les redirections : -L
attention ! si on utilise grep il faudra rajouter tail -n 1 pour récupérer le dernier code

- pour récupérer le charset :
curl -s -I -L -w "%{content_type}" -o /dev/null https://fr.wikipedia.org/wiki/Robot | grep -P -o "charset=\S+" | cut -d"=" -f2 | tail -n 1
-P : expression en Perl
\S : en Perl correspond à un non espace

autre solution pour trouver le charset :
grep -P -o "charset=\K\S+"
\K permet d'oublier tout ce qui est avant

sur mac il faut installer la nouvelle version de grep : ggrep 
-E
-P

HTML
-> "boîtes dans des boîtes"
structure en imbrication (!! pas d'enchâssement)

transformer fichier tabulaire en table html

# Séance 8
## 15 novembre 2023 

correction des exercices de la fiche TD Analyse d'un fichier texte :
ex1) cat "$doc" | ggrep -P -o '\p{Latin}+' | tr '[:upper:]' '[:lower:]' | tr 'ÉÀÈÊ' 'éàèê'
ex2) bash text2colonne.sh $FICHIER | sort  | uniq -c | sort -nr | head -n "$TOPN"
ex3) 
bash text2colonne.sh $FICHIER > col1
echo " " > col2
bash text2colonne.sh $FICHIER >> col2
paste col2 col1

exit convention : 
- exit 0 : pas de pb
- exit 1 : pb avec argument 1
- exit 2 : pb avec argument 2
etc.

syntaxe regex pour la vérification des arguments :
deux crochets [[ $argument =~ (regex) ]] pour faire des regex  


Correction mini projet output html :
(mettre > chemin/tableau.html directement dans la commande bash)

```
if [[ $# -ne 1]];
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


echo "<html>
	<head>
		<meta charset=\"UTF-8\">
	</head>
	<body>"
		
echo "		<table>
			<tr><th>ligne</th><th>URL</th><th>encodage</th></tr>"

lineno=1
while read -r URL
do
	response=$(curl -s -I -L -w "%{http_code}" -o /dev/null $URL)
	encoding=$(curl -s -I -L -w "%{content_type}" -o /dev/null $URL | grep -P -o "charset=\S+" | cut -d"=" -f2 | tail -n 1)
	#echo -e "$lineno \t $URL \t $response"
	echo "<tr>
            <td>$N</td>
            <td>$line</td>
            <td>$code</td>
            <td>$charset</td>
        </tr>"
	lineno=$(($lineno + 1))
done < $URLS

echo "		</table>
		</body>
	</html>"
```

Déploiement du site sur github
- balise style pour le css ou séparé avec un fichier css avec uniquement la feuille de style
-> relié avec <link rel="stylesheet" href="chemin/style.css"/>
-> possibilité d'associer à des noms de balise ou à des des classes .boxed{...}

On utilisera Bulma pour le css :
- classe de base
- classe de modifieur

ex pour les tables : https://bulma.io/documentation/elements/table/

# Séance 9
## 22 novembre 2023 
           
Travail de groupe :
choix du mot : "héritage"
langues : EN, FR, KR
(changement de langue : anglais à la place du thai)

problèmes rencontrés :
- le concordancier ne fonctionne pas
- certains charset ne s'affichent pas dans le tableau
- certains contextes ne sont pas extrait alors que le mot est bien présent dans la page
- certains sites affichent le code 000
- il y a des problèmes d'encodage en coréen

lien du dépôt github commun au groupe : https://github.com/JeevArn/PPE1-groupWork
lien du site créé : https://jeevarn.github.io/PPE1-groupWork/index.html





                                                