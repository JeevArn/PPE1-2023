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

XXXX lignes à supprimer XXXXXX
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
















