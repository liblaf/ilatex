import pathlib
import typing
import urllib.parse
from collections.abc import Sequence
from concurrent import futures
from typing import Annotated

import bs4
import requests
import tqdm.rich
import typer


def get_pkg_description(pkg: str) -> str:
    url: str = urllib.parse.urljoin(base="https://ctan.org/pkg/", url=pkg)
    response: requests.Response = requests.get(url=url)
    soup: bs4.BeautifulSoup = bs4.BeautifulSoup(
        markup=response.text, features="html.parser"
    )
    title: bs4.Tag = typing.cast(bs4.Tag, soup.select_one(selector="h1"))
    text: str = title.get_text()
    if text.startswith(f"{pkg}"):
        return text[len(pkg) + 3 :]
    else:
        return ""


def generate_documentation(
    pkg: str,
    manual_dir: pathlib.Path = pathlib.Path.cwd()
    / "demo"
    / "article"
    / "manual"
    / "pkg",
) -> None:
    filepath: pathlib.Path = manual_dir / f"{pkg}.tex"
    if filepath.exists():
        text: str = filepath.read_text()
    else:
        text: str = ""
    lines: list[str] = text.splitlines()
    lines += [""] * 3
    description: str = get_pkg_description(pkg=pkg)

    lines[0] = "% !TeX root = ../manual.tex"
    lines[1] = ""
    if description:
        lines[2] = f"\\subsection{{\\pkg{{{pkg}}} - {description}}}"
    else:
        lines[2] = f"\\subsection{{\\pkg{{{pkg}}}}}"

    if not lines[-1]:
        lines.append("")
    while not lines[-2]:
        del lines[-1]

    filepath.write_text("\n".join(lines))


def main(
    package_filepath: Annotated[
        pathlib.Path, typer.Option("-p", "--package-file")
    ] = pathlib.Path.cwd() / "data" / "pkg.txt",
    manual_dir: Annotated[
        pathlib.Path, typer.Option("-m", "--manual-dir")
    ] = pathlib.Path.cwd() / "demo" / "article" / "manual" / "pkg",
) -> None:
    pkgs: Sequence[str] = package_filepath.read_text().splitlines()
    with futures.ThreadPoolExecutor() as executor:
        for _ in tqdm.rich.tqdm(
            futures.as_completed(
                [
                    executor.submit(generate_documentation, pkg, manual_dir)
                    for pkg in pkgs
                ]
            )
        ):
            pass


if __name__ == "__main__":
    typer.run(main)
