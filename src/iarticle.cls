\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{iarticle}

\RequirePackage{kvoptions}
\SetupKeyvalOptions{
  family = i,
  prefix = i@,
}
\DeclareBoolOption[false]{sfdefault}
\DeclareBoolOption[false]{noto}
\DeclareStringOption[en]{lang}
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessKeyvalOptions{i}

\PassOptionsToPackage{inline}{enumitem}
\PassOptionsToPackage{T1}{fontenc}

\RequirePackage{silence}
\input{common/silence.tex}

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

\RequirePackage{cleveref}

\input{common/geometry.tex}
\input{common/xcolor.tex}

\input{common/ctex.tex}
\input{common/enumitem.tex}
\input{common/fancyhdr.tex}
\input{common/float.tex}
\input{common/fontspec.tex}
\input{common/hyperref.tex}
\input{common/noto.tex}
\input{common/siunitx.tex}
\input{common/tabularx.tex}
\input{common/tcolorbox.tex}
\input{common/titlesec.tex}

\DeclareDocumentCommand{\ymd}{m m m}{\year=#1 \month=#2 \day=#3}
\DeclareDocumentCommand{\emph}{m}{\textbf{\textcolor{emph}{#1}}}

\DeclareDocumentCommand{\ilatex}{}{i\LaTeX}

\DeclareDocumentCommand{\class}{m}{\def\@class{#1}}
\DeclareDocumentCommand{\course}{m}{\def\@course{#1}}
\DeclareDocumentCommand{\email}{m}{\def\@email{#1}}
\DeclareDocumentCommand{\id}{m}{\def\@id{#1}}
\DeclareDocumentCommand{\institute}{m}{\def\@institute{#1}}
\DeclareDocumentCommand{\name}{m}{\def\@name{#1}}

\DeclareDocumentCommand{\theclass}{}{\csuse{@class}}
\DeclareDocumentCommand{\thecourse}{}{\csuse{@course}}
\DeclareDocumentCommand{\theemail}{}{\href{mailto:\csuse{@email}}{\nolinkurl{\csuse{@email}}}}
\DeclareDocumentCommand{\theid}{}{\csuse{@id}}
\DeclareDocumentCommand{\theinstitute}{}{\csuse{@institute}}
\DeclareDocumentCommand{\thename}{}{\csuse{@name}}

\linespread{1.3}

\DeclareDocumentCommand{\maketitle}{}{
  \thispagestyle{titlepage}
  \begin{center}
    { \LARGE \textbf{\csuse{@title}} }
    \par \vspace{1em}
    \small
    \begin{tabular}[t]{c}
      \csuse{@author}
    \end{tabular}
  \end{center}
}

\author{
  \thename \quad \theid \\
  \theclass             \\
  \theemail
}

\class{Class 02}
\course{Lab. Report}
\email{liqin20@mails.tsinghua.edu.cn}
\id{2020012872}
\institute{Weiyang College, Tsinghua University}
\name{Qin Li}
\ifdefstring{\i@lang}{zh}{
  \class{未央-水木 02}
  \course{实验报告}
  \institute{清华大学, 未央书院}
  \name{李钦}
}{}
