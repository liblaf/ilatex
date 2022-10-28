#!/usr/bin/bash
set -o errexit
set -o nounset

REPO_HOME="$(dirname "$(dirname "$(realpath "${0}")")")"

srcs=(${REPO_HOME}/src/*)

demos=(
  ${REPO_HOME}/demo/article/default
  ${REPO_HOME}/demo/article/twocolumn
  ${REPO_HOME}/demo/article/zh
  ${REPO_HOME}/demo/work/default
)

function prepare() {
  for demo in "${demos[@]}"; do
    cp "${srcs[@]}" "${demo}"
  done
}

function build() {
  for demo in "${demos[@]}"; do
    (
      cd "${demo}"
      latexmk -synctex=1 -interaction=nonstopmode -file-line-error -xelatex -shell-escape
    )
  done
}

function install() {
  cp ${REPO_HOME}/demo/**/*.pdf "${REPO_HOME}/docs/demo/"
}

cmd="${1}"
shift 1
"${cmd}"
