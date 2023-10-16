#!/bin/bash

#écrire un script qui donne le nombre de Location par année

#2016
(echo "nombre d'annotations de location en 2016 :" && cat ann/2016/*/* | grep Location | wc -l) > exoShell_LocationPerYear.txt

#2017
(echo "nombre d'annotations de location en 2017 :" && cat ann/2017/*/* | grep Location | wc -l) >> exoShell_LocationPerYear.txt

#2018
(echo "nombre d'annotations de location en 2018 :" && cat ann/2018/*/* | grep Location | wc -l) >> exoShell_LocationPerYear.txt

