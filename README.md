# ilatex

Simple LaTeX templates

| Filename               | Description               |
| ---------------------- | ------------------------- |
| [iwork.cls](iwork.cls) | coursework template       |
| [icode.sty](icode.sty) | code highlight package    |
| [imath.sty](imath.sty) | math package              |
| [ipkg.sty](ipkg.sty)   | useful package collection |

## Usage

### Installation Free

Simply copy the `*.cls` and / or `*.sty` files to the same folder of the `*.tex` file you are working on.

### Install to `TEXMFLOCAL`

Use [install.sh](install.sh) (Bash script) or [install.ps1](install.ps1) (PowerShell script) to install `ilatex` to `TEXMFLOCAL` (`sudo` permission may be needed). After that, you won't need to copy `*.cls` and `*.sty` files to your work folder.

## Manual

Since the templates are mostly used by myself only, I'm too lazy to write a manual. It's not hard to understand the source code of `ilatex`. Just read them, and you will understand what those commands are doing.

## Example

Visit [liblaf/thu-course (github.com)](https://github.com/liblaf/thu-course) (my coursework collection) to see some examples.

## LaTeX Tutorial

- [Home - LaTeX-Tutorial.com](https://latex-tutorial.com/)
- [Documentation - Overleaf](https://www.overleaf.com/learn)

### Environment Setup

#### Overleaf

Visit [Overleaf, Online LaTeX Editor](https://www.overleaf.com) for more detail.

#### Local Setup

TODO

### Useful Reference

- [The Comprehensive LaTeX Symbol List (ctan.org)](http://tug.ctan.org/info/symbols/comprehensive/symbols-a4.pdf)

### Useful Packages

Read package documentation / manual for more detailed instructions.

| Name                                              | Description                                                | Useful Commands / Environments                               |
| ------------------------------------------------- | ---------------------------------------------------------- | ------------------------------------------------------------ |
| [amsfonts](https://ctan.org/pkg/amsfonts)         | TeX fonts from the American Mathematical Society           |                                                              |
| [amsmath](https://www.ctan.org/pkg/amsmath)       | AMS mathematical facilities for LaTeX                      |                                                              |
| amssymb                                           |                                                            |                                                              |
| [amsthm](https://www.ctan.org/pkg/amsthm)         | Typesetting theorems (AMS style)                           | `\newtheorem`, `\theoremstyle`                               |
| [bm](https://www.ctan.org/pkg/bm)                 | Access bold symbols in maths mode                          | `\bm`                                                        |
| [booktabs](https://www.ctan.org/pkg/booktabs/)    | Publication quality tables in LaTeX                        | `\toprule`, `\midrule`, `\bottomrule`                        |
| [ctex](https://www.ctan.org/pkg/ctex)             | LaTeX classes and packages for Chinese typesetting         |                                                              |
| [enumitem](https://www.ctan.org/pkg/enumitem)     | Control layout of itemize, enumerate, description          | `\newlist`                                                   |
| [esint](https://www.ctan.org/pkg/esint)           | Extended set of integrals for Computer Modern              | `\oiint`                                                     |
| [fancyhdr](https://www.ctan.org/pkg/fancyhdr)     | Extensive control of page headers and footers in LaTeX2e   | `\pagestyle`                                                 |
| [float](https://www.ctan.org/pkg/float)           | Improved interface for floating objects                    | float option `H`                                             |
| [geometry](https://www.ctan.org/pkg/geometry)     | Flexible and complete interface to document dimensions     | `\geometry`                                                  |
| [graphicx](https://ctan.org/pkg/graphicx)         | Enhanced support for graphics                              | `\includegraphics`                                           |
| [hyperref](https://ctan.org/pkg/hyperref)         | Extensive support for hypertext in LaTeX                   | `\hypersetup`, `\href`, `\url`                               |
| [listings](https://www.ctan.org/pkg/listings)     | Typeset source code listings using LaTeX                   | `{lstlisting}`                                               |
| [longtable](https://ctan.org/pkg/longtable)       | Allow tables to flow over page boundaries                  | `{longtable}`                                                |
| [mathrsfs](https://www.ctan.org/pkg/mathrsfs)     | Support for using RSFS fonts in maths                      | `\mathscr`                                                   |
| [minted](https://www.ctan.org/pkg/minted)         | Highlighted source code for LaTeX                          | `\inputminted`, `\setminted`                                 |
| [multirow](https://www.ctan.org/pkg/multirow)     | Create tabular cells spanning multiple rows                | `\multirow`, `\multicolumn`                                  |
| [mhchem](https://www.ctan.org/pkg/mhchem)         | Typeset chemical formulae/equations and H and P statements | `\ce`                                                        |
| [pdfpages](https://www.ctan.org/pkg/pdfpages)     | Include PDF documents in LaTeX                             | `\includepdf`                                                |
| [siunitx](https://ctan.org/pkg/siunitx)           | A comprehensive (SI) units package                         | `\ang`, `\num`, `\unit`, `\qty`, `\numlist`, `\qtylist`, `\tablenum` |
| [subcaption](https://www.ctan.org/pkg/subcaption) | Support for sub-captions                                   | `\subcaptionbox`                                             |
| [url](https://www.ctan.org/pkg/url)               | Verbatim with URL-sensitive line breaks                    | `\url`                                                       |
| [xcolor](https://www.ctan.org/pkg/xcolor)         | Driver-independent color extensions for LaTeX and pdfLaTeX | `\color`, `\textcolor`, `\definecolor`                       |

### Useful Tools

- [Overleaf, Online LaTeX Editor](https://www.overleaf.com)
- [Detexify LaTeX handwritten symbol recognition (kirelabs.org)](http://detexify.kirelabs.org/classify.html)
- [Shapecatcher: Draw the Unicode character you want!](http://shapecatcher.com/)
- [Mathpix Snip](https://mathpix.com/)
- [Create LaTeX tables online – TablesGenerator.com](https://www.tablesgenerator.com/)

## Similar Projects

- [GJCav/latex-template: lalalalatex (github.com)](https://github.com/GJCav/latex-template)
- [singlet-Carbene/WYC-Template: A template of assignment provided for students of Weiyang College, Tsinghua Univ. (github.com)](https://github.com/singlet-Carbene/WYC-Template)
