#!/bin/bash
TEXMFLOCAL=$(kpsewhich --var-value TEXMFLOCAL)
mkdir --parent "$TEXMFLOCAL/tex/latex/"
cp *.cls "$TEXMFLOCAL/tex/latex/"
cp *.sty "$TEXMFLOCAL/tex/latex/"
texhash
