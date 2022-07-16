$TEXMFLOCAL = (kpsewhich -var-value TEXMFLOCAL)
Copy-Item "*.cls" -Destination "$TEXMFLOCAL/tex/latex/local/"
Copy-Item "*.sty" -Destination "$TEXMFLOCAL/tex/latex/local/"
texhash
