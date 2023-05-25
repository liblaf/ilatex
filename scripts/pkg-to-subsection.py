import typing
import urllib.parse
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

import bs4
import requests
import typer
import yaml
from rich.progress import (
    BarColumn,
    MofNCompleteColumn,
    Progress,
    SpinnerColumn,
    TaskID,
    TaskProgressColumn,
    TextColumn,
    TimeElapsedColumn,
    TimeRemainingColumn,
)


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
    pkg_dir: Path = Path.cwd() / "demo" / "article" / "manual" / "pkg",
) -> None:
    filepath: Path = pkg_dir / f"{pkg}.tex"
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
    config_filepath: Path = typer.Option(
        Path.cwd() / "data" / "pkgs.yaml", "-c", "--config"
    ),
    pkg_dir: Path = typer.Option(
        Path.cwd() / "demo" / "article" / "manual" / "pkg", "-p", "--pkg-dir"
    ),
) -> None:
    config: dict = yaml.safe_load(config_filepath.read_text())
    pkgs: list[str] = typing.cast(list[str], config.get("packages"))
    with Progress(
        TextColumn("[bold blue]{task.description}"),
        SpinnerColumn(),
        BarColumn(),
        MofNCompleteColumn(),
        TaskProgressColumn(),
        TimeElapsedColumn(),
        TimeRemainingColumn(),
    ) as progress:
        task_id: TaskID = progress.add_task("Generating Documentation", total=len(pkgs))
        with ThreadPoolExecutor() as executor:
            generator = executor.map(generate_documentation, pkgs)
            for _ in generator:
                progress.advance(task_id=task_id)


if __name__ == "__main__":
    typer.run(main)
