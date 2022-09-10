#!/bin/bash
TEXMFHOME=$(kpsewhich --var-value TEXMFHOME)
mkdir --parent "$TEXMFHOME/tex/latex/"
cp *.cls "$TEXMFHOME/tex/latex/"
cp *.sty "$TEXMFHOME/tex/latex/"
texhash
