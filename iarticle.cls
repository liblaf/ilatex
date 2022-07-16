\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{iarticle}[2022/04/08 Article Class]

\LoadClass{article}
\setlength{\columnsep}{10mm}

\RequirePackage{geometry}
\geometry{
  a4paper,
  top=25mm,
  bottom=25mm,
  left=20mm,
  right=20mm,
}

\RequirePackage{hyperref}
\hypersetup{
  colorlinks=true,
}

\newcommand{\isubject}[1]{\def\theSubject{#1}}
\newcommand{\idepartment}[1]{\def\theDepartment{#1}}
\newcommand{\icontact}[1]{\def\theContact{#1}}

\RequirePackage{fancyhdr}
\fancypagestyle{plain}{
  \fancyhf{}
  \lhead{\theSubject}
  \rhead{\@date}
  \cfoot{\thepage}
  \renewcommand{\headrulewidth}{1pt}
}
\pagestyle{fancy}

\renewcommand{\maketitle}{
  \thispagestyle{plain}
  \begin{center}
    {\LARGE\textbf{\@title}}
    
    \vspace{5mm}

    {\large{\@author}}

    \theDepartment

    \href{mailto:\theContact}{\theContact}
  \end{center}
  \vspace{5mm}
}

\DeclareOption{twocolumn}{
  \renewcommand{\maketitle}{
    \thispagestyle{plain}
    \twocolumn[
      \begin{@twocolumnfalse}
        \begin{center}
          {\LARGE\textbf{\@title}}
          
          \vspace{5mm}

          {\large{\@author}}

          \theDepartment

          \href{mailto:\theContact}{\theContact}
        \end{center}
        \vspace{5mm}
      \end{@twocolumnfalse}
    ]
  }
}
\ProcessOptions\relax

\isubject{Lab. of Physics (3)}
\idepartment{Weiyang College, Tsinghua University}
\icontact{liqin20@mails.tsinghua.edu.cn}
