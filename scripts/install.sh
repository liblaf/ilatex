#!/usr/bin/bash
set -o errexit
set -o nounset
set -o pipefail

if command -v rich > /dev/null 2>&1; then
  function info() {
    rich --print "[bold bright_blue]${*}"
  }
else
  function info() {
    echo -e -n "\x1b[1;94m"
    echo -n "${*}"
    echo -e "\x1b[0m"
  }
fi

function call() {
  info "+ ${*}"
  "${@}"
}

REPO_HOME="$(realpath --canonicalize-missing "${0}/../..")"

TEXMFHOME="$(kpsewhich --var-value TEXMFHOME)"
info "TEXMFHOME = ${TEXMFHOME}"
mkdir --parent "${TEXMFHOME}/tex/latex"
srcs=(${REPO_HOME}/src/*)
for src in "${srcs[@]}"; do
  call cp "${src}" "${TEXMFHOME}/tex/latex"
done
call texhash
