#!/usr/bin/bash
set -o errexit
set -o nounset
set -o pipefail

if command -v rich >/dev/null 2>&1; then
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

srcs=(${REPO_HOME}/src/*)

demos=(
  ${REPO_HOME}/demo/article/default
  ${REPO_HOME}/demo/article/twocolumn
  ${REPO_HOME}/demo/article/zh
  ${REPO_HOME}/demo/work/default
)

function build() {
  for demo in "${demos[@]}"; do
    (
      set +o errexit
      call cd "${demo}"
      call latexmk -synctex=1 -interaction=nonstopmode -file-line-error -xelatex -shell-escape
      set -o errexit
    )
  done
}

function install() {
  call cp ${REPO_HOME}/demo/**/*.pdf "${REPO_HOME}/docs/demo/"
}

cmd="${1}"
shift 1
"${cmd}"
