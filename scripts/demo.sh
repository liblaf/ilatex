#!/usr/bin/bash
set -o errexit
set -o nounset
set -o pipefail
shopt -s globstar

function exists() {
  command -v "${@}" > /dev/null 2>&1
}

function info() {
  if exists rich; then
    rich --print --style "bold bright_blue" "${*}"
  else
    echo -e -n "\x1b[1;94m"
    echo -n "${*}"
    echo -e "\x1b[0m"
  fi
}

function success() {
  if exists rich; then
    rich --print --style "bold bright_green" "${*}"
  else
    echo -e -n "\x1b[1;92m"
    echo -n "${*}"
    echo -e "\x1b[0m"
  fi
}

function call() {
  info "+ ${*}"
  "${@}"
}

function copy() {
  mkdir --parents "$(realpath --canonicalize-missing ${2}/..)"
  cp --force --recursive "${1}" "${2}"
  success "Copy: ${1} -> ${2}"
}

REPO_HOME="$(git rev-parse --show-toplevel)"
srcs=("${REPO_HOME}/src"/*.cls "${REPO_HOME}/src"/*.sty)
demos=(
  "${REPO_HOME}/demo/article/default"
  "${REPO_HOME}/demo/article/twocolumn"
  "${REPO_HOME}/demo/article/zh"
  "${REPO_HOME}/demo/work/default"
)

function build() {
  for demo in "${demos[@]}"; do
    (
      set +o errexit
      call cd "${demo}"
      call latexmk -synctex=1 -interaction=nonstopmode -file-line-error -xelatex -shell-escape
    )
  done
}

function install() {
  demos_pdf=("${REPO_HOME}/demo"/**/*.pdf)
  for demo_pdf in "${demos_pdf[@]}"; do
    copy "${demo_pdf}" "${REPO_HOME}/docs/demo"
  done
}

cmd="${1}"
shift 1
"${cmd}"
