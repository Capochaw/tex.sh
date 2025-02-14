#!/bin/bash

if [ "$1" = '' ]; then
		echo "te faltó el nombre de salida del archivo cabeza."
		exit
fi

if [ "$2" = '' ]; then
		echo "te faltó el color de salida cabeza."
		exit
fi

echo $1 $2
sleep 2

vim input.tex

echo "" > inputA.tex
echo "\documentclass[varwidth=true,border=1pt]{standalone}" >> inputA.tex
echo "" >> inputA.tex
echo "\usepackage{amsmath}" >> inputA.tex
echo "\usepackage{amssymb}" >> inputA.tex
echo "\usepackage{amsfonts}" >> inputA.tex
echo "\renewenvironment{gather*}{$\gathered}{\endgathered$}" >> inputA.tex
echo "\usepackage[utf8]{inputenc}" >> inputA.tex
echo "" >> inputA.tex
echo "\thispagestyle{empty}" >> inputA.tex
echo "\begin{document}" >> inputA.tex
echo "\begin{gather*}" >> inputA.tex
echo "$(cat input.tex)" >> inputA.tex
echo "\end{gather*}" >> inputA.tex
echo "\end{document}" >> inputA.tex

pdflatex inputA.tex

$(convert -density 500 inputA.pdf -quality 90 -fill \#$2 -colorize 100 $1.png)

sleep 1

rm inputA.tex input.tex inputA.aux inputA.log inputA.pdf
