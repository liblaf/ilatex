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

app = typer.Typer()


def get_package_description(package: str) -> str:
    url: str = urllib.parse.urljoin(base="https://ctan.org/pkg/", url=package)
    response: requests.Response = requests.get(url=url)
    soup: bs4.BeautifulSoup = bs4.BeautifulSoup(
        markup=response.text, features="html.parser"
    )
    title: bs4.Tag = typing.cast(bs4.Tag, soup.select_one(selector="h1"))
    text: str = title.get_text()
    if text.startswith(f"{package}"):
        return text[len(package) + 3 :]
    else:
        return ""


def generate_documentation(
    package: str,
    package_directory: Path = Path.cwd() / "demo" / "article" / "default" / "package",
) -> None:
    filepath: Path = package_directory / f"{package}.tex"
    if filepath.exists():
        text: str = filepath.read_text()
    else:
        text: str = ""
    lines: list[str] = text.splitlines()
    lines += [""] * 3
    description: str = get_package_description(package=package)

    lines[0] = "% !TeX root = ../default.tex"
    lines[1] = ""
    if description:
        lines[2] = f"\\subsection{{\\pkg{{{package}}} - {description}}}"
    else:
        lines[2] = f"\\subsection{{\\pkg{{{package}}}}}"

    if not lines[-1]:
        lines.append("")
    while not lines[-2]:
        del lines[-1]

    filepath.write_text("\n".join(lines))


@app.command()
def main(
    config_filepath: Path = typer.Option(
        Path.cwd() / "data" / "packages.yaml", "-c", "--config"
    ),
    package_directory: Path = typer.Option(
        Path.cwd() / "demo" / "article" / "default" / "package", "-p", "--package-dir"
    ),
) -> None:
    config: dict = yaml.safe_load(config_filepath.read_text())
    packages: list[str] = typing.cast(list[str], config.get("packages"))
    with Progress(
        TextColumn("[bold blue]{task.description}"),
        SpinnerColumn(),
        BarColumn(),
        MofNCompleteColumn(),
        TaskProgressColumn(),
        TimeElapsedColumn(),
        TimeRemainingColumn(),
    ) as progress:
        task_id: TaskID = progress.add_task(
            "Generating Documentation", total=len(packages)
        )
        with ThreadPoolExecutor() as executor:
            generator = executor.map(generate_documentation, packages)
            for _ in generator:
                progress.advance(task_id=task_id)


if __name__ == "__main__":
    app()
