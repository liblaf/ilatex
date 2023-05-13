\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{iarticle}[2022/10/20 Article Class]

\RequirePackage{etoolbox}
\newbool{chinese}
\DeclareOption{chinese}{\booltrue{chinese}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\PassOptionsToPackage{dvipsnames}{xcolor}

\LoadClass{article}

\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage{array}
\RequirePackage{booktabs}
\RequirePackage{caption}
\RequirePackage{enumitem}
\RequirePackage{esint}
\RequirePackage{etoolbox}
\RequirePackage{fancyhdr}
\RequirePackage{float}
\RequirePackage{fontspec}
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
\RequirePackage{ulem}
\RequirePackage{xcolor}
\RequirePackage{xkeyval}
\RequirePackage{xparse}

\RequirePackage{cleveref}

\ifbool{chinese}{\RequirePackage{ctex}}{}

\DeclareDocumentCommand{\ilatex}{}{\href{https://github.com/liblaf/ilatex}{i\LaTeX}}

\floatplacement{figure}{H}
\floatplacement{table}{H}
\geometry{
  hmargin = 20mm,
  paper   = a4paper,
  vmargin = 25mm,
}
\hypersetup{
  colorlinks = true,
  % https://tex.stackexchange.com/a/525984
  linkcolor       = BrickRed,
  citecolor       = Green,
  filecolor       = Mulberry,
  urlcolor        = NavyBlue,
  menucolor       = BrickRed,
  runcolor        = Mulberry,
  linkbordercolor = BrickRed,
  citebordercolor = Green,
  filebordercolor = Mulberry,
  urlbordercolor  = NavyBlue,
  menubordercolor = BrickRed,
  runbordercolor  = Mulberry,
}
\linespread{1.3}
\setlength{\columnsep}{10mm}
\renewcommand{\tabularxcolumn}[1]{>{\centering\arraybackslash}m{#1}}

\tcbuselibrary{breakable}
\tcbuselibrary{listings}
\tcbuselibrary{skins}
\tcbuselibrary{theorems}
\tcbuselibrary{xparse}
\tcbset{
  breakable,
  colback  = blue!10!white,
  colframe = blue!80!white,
  enhanced,
  fonttitle = \bfseries,
}

\DeclareDocumentCommand{\class}{m}{\csdef{@class}{#1}}
\DeclareDocumentCommand{\course}{m}{\csdef{@course}{#1}}
\DeclareDocumentCommand{\department}{m}{\csdef{@department}{#1}}
\DeclareDocumentCommand{\email}{m}{\csdef{@email}{#1}}
\DeclareDocumentCommand{\id}{m}{\csdef{@id}{#1}}
\DeclareDocumentCommand{\name}{m}{\csdef{@name}{#1}}

\DeclareDocumentCommand{\theclass}{}{\csuse{@class}}
\DeclareDocumentCommand{\thecourse}{}{\csuse{@course}}
\DeclareDocumentCommand{\thedepartment}{}{\csuse{@department}}
\DeclareDocumentCommand{\theemail}{}{\href{mailto:\csuse{@email}}{\csuse{@email}}}
\DeclareDocumentCommand{\theid}{}{\csuse{@id}}
\DeclareDocumentCommand{\thename}{}{\csuse{@name}}
\author{
  \thename \quad \theid \\
  \theclass             \\
  \theemail
}

\pagestyle{fancy}
\fancyhead[L]{\small\textsl{\rightmark}}
\fancyhead[R]{\small\textsl{\leftmark}}
\fancyfoot[C]{Page \thepage{} of \,\pageref{LastPage}}

\fancypagestyle{titlepage}{
  \fancyhead[L]{\small \thecourse}
  \fancyhead[C]{}
  \fancyhead[R]{\small \@date}
  \renewcommand{\headrulewidth}{0.4pt}
}

\DeclareDocumentCommand{\maketitle}{}{
  \thispagestyle{titlepage}
  \begin{center}
    { \LARGE \textbf{\@title} }
    \par \vspace{0.5em}
    \small
    \begin{tabular}[t]{c}
      \csuse{@author}
    \end{tabular}
  \end{center}
}

\sisetup{
  uncertainty-mode = separate,
}
\ifbool{chinese}{
  \sisetup{
    list-final-separator = 和 \,,
    list-pair-separator  = 和 \,,
    per-mode             = symbol,
    range-phrase         = \,\text{--}\,,
  }
}{}

\ifbool{chinese}{
  \DeclareDocumentCommand{\keywordsname}{}{关键词}
}{
  \DeclareDocumentCommand{\keywordsname}{}{Keywords}
}
\DeclareDocumentCommand{\keywords}{m}{
  \par \vspace{0.5em}
  \textbf{\keywordsname :} #1
}

\define@cmdkey{image}{caption}[]{}
\define@cmdkey{image}{label}[]{}
\DeclareDocumentCommand{\image}{O{} O{} m}{
  \presetkeys{image}{
    caption,
    label,
  }{}
  \setkeys{image}{#1}
  \begin{figure}[H]
    \centering
    \ifstrempty{#2}{
      \includegraphics[height = 0.3\linewidth]{#3}
    }{
      \includegraphics[#2]{#3}
    }
    \ifx\cmdKV@image@caption\empty
      \caption{}
    \else
      \caption{\cmdKV@image@caption}
    \fi
    \ifx\cmdKV@image@label\empty
      \label{fig:#3}
    \else
      \label{fig:\cmdKV@image@label}
    \fi
  \end{figure}
}

\AtBeginDocument{\maketitle}

\graphicspath{{assets}}
\email{liqin20@mails.tsinghua.edu.cn}
\id{2020012872}
\ifbool{chinese}{
  \class{未央-水木 02}
  \course{实验报告}
  \department{清华大学, 未央书院}
  \name{李钦}
}{
  \class{Class 02}
  \course{Lab. Report}
  \department{Weiyang College, Tsinghua University}
  \name{Qin Li}
}
