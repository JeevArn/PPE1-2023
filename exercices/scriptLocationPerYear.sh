#!/bin/bash

#écrire un script qui donne le nombre de Location par année

if [ $# -ne 0 ]
then
    echo "Ce script ne prend pas d'arguments. Il comptabilise les annotations de location par année."
    exit
fi

#2016
(echo "nombre d'annotations de location en 2016 :" && cat ./docs_ex1Arborescence/ann/2016/*/* | grep Location | wc -l) > exoShell_LocationPerYear.txt

#2017
(echo "nombre d'annotations de location en 2017 :" && cat ./docs_ex1Arborescence/ann/2017/*/* | grep Location | wc -l) >> exoShell_LocationPerYear.txt

#2018
(echo "nombre d'annotations de location en 2018 :" && cat ./docs_ex1Arborescence/ann/2018/*/* | grep Location | wc -l) >> exoShell_LocationPerYear.txt
