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

REPO_NAME="$(basename "$(pwd)")"
files=(
  "mkdocs.yaml"
  "pyproject.toml"
  "README.md"
)
for file in "${files[@]}"; do
  call sed --in-place "s/template/${REPO_NAME}/g" "${file}"
done

files=(.github/workflows/**.yaml)
for file in "${files[@]}"; do
  call sed --in-place "s/branches-ignore/branches/g" "${file}"
done

call gh repo edit --homepage "https://liblaf.github.io/${REPO_NAME}/"

call git add .
call git commit --message "build: initialize" --verify --gpg-sign
call git push
