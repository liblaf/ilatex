\NeedsTeXFormat{LaTeX2e}
\ProvidesPackage{iarticle}[2022/10/20 Article Class]

\RequirePackage{etoolbox}
\newbool{chinese}
\DeclareOption{chinese}{\booltrue{chinese}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

\LoadClass{article}

\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage{array}
\RequirePackage{caption}
\RequirePackage{enumitem}
\RequirePackage{etoolbox}
\RequirePackage{fancyhdr}
\RequirePackage{float}
\RequirePackage{fontspec}
\RequirePackage{geometry}
\RequirePackage{graphicx}
\RequirePackage{hyperref}
\RequirePackage{ifthen}
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
\RequirePackage{xcolor}
\RequirePackage{xparse}

\RequirePackage{cleveref}

\ifbool{chinese}{\RequirePackage{ctex}}{}

\floatplacement{figure}{H}
\geometry{
  hmargin = 20mm,
  paper   = a4paper,
  vmargin = 25mm,
}
\hypersetup{
  colorlinks = true,
}
\linespread{1.3}
\setlength{\columnsep}{10mm}
\settasks{
  label = \arabic*.,
}
\renewcommand{\tabularxcolumn}[1]{>{\centering\arraybackslash}m{#1}}
\tcbuselibrary{breakable}
\tcbuselibrary{listings}
\tcbuselibrary{skins}
\tcbuselibrary{theorems}
\tcbuselibrary{xparse}
\tcbset{
  breakable,
  colback   = blue!5!white,
  colframe  = blue!75!white,
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
    {
      \small
      \begin{tabular}[t]{c}
        \csuse{@author}
      \end{tabular}
    }
  \end{center}
}

\ifbool{chinese}{
  \DeclareDocumentCommand{\keywordsname}{}{关键词}
}{
  \DeclareDocumentCommand{\keywordsname}{}{Keywords}
}
\DeclareDocumentCommand{\keywords}{m}{
  \par \vspace{0.5em}
  \textbf{\keywordsname :} #1
}

\AtBeginDocument{\maketitle}

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
