$TEXMFHOME = (kpsewhich -var-value TEXMFHOME)
Copy-Item "*.cls" -Destination "$TEXMFHOME/tex/latex/local/"
Copy-Item "*.sty" -Destination "$TEXMFHOME/tex/latex/local/"
texhash
