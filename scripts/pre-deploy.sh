#!/usr/bin/bash
set -o errexit
set -o nounset

REPO_HOME="$(dirname "$(dirname "$(realpath "${0}")")")"

function prepare-pkgs() {
  for file in ${REPO_HOME}/src/*; do
    echo "${file}"
    ln --symbolic "${file}" "${1}/$(basename "${file}")"
  done
}

demos=(
  ${REPO_HOME}/demo/article/default
  ${REPO_HOME}/demo/article/twocolumn
  ${REPO_HOME}/demo/article/cn
  ${REPO_HOME}/demo/work/default
)
for demo in "${demos[@]}"; do
  prepare-pkgs ${demo}
done
