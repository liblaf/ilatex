\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{iwork}[2024/11/08 Minimal LaTeX coursework template]

\RequirePackage{kvoptions}
\SetupKeyvalOptions{
  family = i,
  prefix = i@,
}
\DeclareStringOption[en]{lang}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessKeyvalOptions{i}

\input{share/silence.tex}

\LoadClass{article}

\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage{array}
\RequirePackage{biblatex}
\RequirePackage{booktabs}
\RequirePackage{caption}
\RequirePackage{enumitem}
\RequirePackage{esint}
\RequirePackage{etoolbox}
\RequirePackage{fancyhdr}
\RequirePackage{float}
\RequirePackage{fontawesome5}
\RequirePackage{fontenc}
\RequirePackage{geometry}
\RequirePackage{graphicx}
\RequirePackage{hyperref}
\RequirePackage{import}
\RequirePackage{lastpage}
\RequirePackage{mathrsfs}
\RequirePackage{mathtools}
\RequirePackage{microtype}
\RequirePackage{multicol}
\RequirePackage{multirow}
\RequirePackage{physics}
\RequirePackage{siunitx}
\RequirePackage{subcaption}
\RequirePackage{tabularx}
\RequirePackage{tasks}
\RequirePackage{tcolorbox}
\RequirePackage{titlesec}
\RequirePackage{ulem}
\RequirePackage{xcolor}
\RequirePackage{xkeyval}
\RequirePackage{xparse}
\RequirePackage{cleveref} % should be loaded last

\input{share/geometry.tex} % should be loaded first
\input{share/xcolor.tex}   % should be loaded first
\input{share/ctex.tex}
\input{share/enumitem.tex}
\input{share/fancyhdr.tex}
\input{share/float.tex}
\input{share/fontspec.tex}
\input{share/hyperref.tex}
\input{share/siunitx.tex}
\input{share/tabularx.tex}
\input{share/tcolorbox.tex}
\input{share/titlesec.tex}

\DeclareDocumentCommand{\ymd}{m m m}{\year=#1 \month=#2 \day=#3}
\DeclareDocumentCommand{\emph}{m}{\textbf{\textcolor{emph}{#1}}}

\DeclareDocumentCommand{\ilatex}{}{i\LaTeX}

\DeclareDocumentCommand{\course}{m}{\csdef{@course}{#1}}
\DeclareDocumentCommand{\email}{m}{\csdef{@email}{#1}}
\DeclareDocumentCommand{\id}{m}{\csdef{@id}{#1}}
\DeclareDocumentCommand{\institute}{m}{\csdef{@institute}{#1}}
\DeclareDocumentCommand{\name}{m}{\csdef{@name}{#1}}

\DeclareDocumentCommand{\thecourse}{}{\csuse{@course}}
\DeclareDocumentCommand{\theemail}{}{\href{mailto:\csuse{@email}}{\nolinkurl{\csuse{@email}}}}
\DeclareDocumentCommand{\theid}{}{\csuse{@id}}
\DeclareDocumentCommand{\theinstitute}{}{\csuse{@institute}}
\DeclareDocumentCommand{\thename}{}{\csuse{@name}}

\linespread{1.3}

\DeclareDocumentCommand{\maketitle}{}{
  \begin{center}
    { \LARGE \textbf{\csuse{@title}} }
    \par \vspace{1ex}
    \small
    \begin{tabular}[t]{c}
      \csuse{@author}
    \end{tabular}
  \end{center}
}

\newcounter{prob}[section]
\newtcolorbox[
  auto counter,
  use counter = prob,
]{prob}[1][]{
  colback  = tcolorbox!5,
  colframe = tcolorbox,
  title    = {Problem \thetcbcounter. #1},
}

\theoremstyle{remark}
\newtheorem*{sol}{\textcolor{theorem}{Solution}}
\renewcommand{\proofname}{\textcolor{theorem}{Proof}}

\author{
  \thename \quad \theid \\
  \theemail
}

\input{defs.tex}
