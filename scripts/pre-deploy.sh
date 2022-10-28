#!/usr/bin/bash
set -o errexit
set -o nounset

REPO_HOME="$(dirname "$(dirname "$(realpath "${0}")")")"

function prepare-pkgs() {
  cp ${REPO_HOME}/src/* "${1}/"
}

demos=(
  ${REPO_HOME}/demo/article/default
  ${REPO_HOME}/demo/article/twocolumn
  ${REPO_HOME}/demo/article/zh
  ${REPO_HOME}/demo/work/default
)
for demo in "${demos[@]}"; do
  prepare-pkgs ${demo}
done
