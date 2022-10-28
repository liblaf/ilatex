#!/usr/bin/bash
set -o errexit
set -o nounset

REPO_HOME="$(dirname "$(dirname "$(realpath "${0}")")")"

TEXMFHOME="$(kpsewhich --var-value TEXMFHOME)"
mkdir --parent "${TEXMFHOME}/tex/latex/"
cp ${REPO_HOME}/src/* "${TEXMFHOME}/tex/latex/"
texhash
