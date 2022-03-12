\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{iwork}[2022/03/12 Coursework Class]

% load in the main exam class with appropriate options
\LoadClass[12pt, a4paper]{exam}

% space out the lines by 25% more than the default (basically 1.5 line spacing)
\linespread{1.25}

% General thinking is that 12pt font, with 1.25 spread, black on white text,
% gives a good readable document for most people. For those that benefit
% from larger fonts many will be best zooming / expanding the document on
% screen or simply printing enlarged on A3 as that will best preserve the
% formatting rather than enlarging the font whilst still fitting into an A4
% sized space.  For those that benefit from a different background colour
% this is likely easiest achieved if the document is on white and then
% software or a film is used to change the white to cream, blue etc

% increase the printed page area width
\extrawidth{0.5cm}

% increase header space on title page only
\extraheadheight[2.0cm]{0cm}

% setup page headers/footers for first and subsequent pages
\pagestyle{headandfoot}
\lhead{}
\chead[
  \bfseries \Large \theCourse \\
  \large Sheet \theSheetNumber \ Solutions \quad --- \quad \theTerm \\
  \@title \\
  \@author
]{}
\rhead[]{\bfseries \theCourse: Sheet \theSheetNumber \ Solutions --- \theTerm}
\lfoot{\footnotesize Weiyang College, Tsinghua University \\ \theContact}
\cfoot{}
\rfoot{Page \thepage{} of \numpages}
\footrule

% define newcommands for user set page header details
\newcommand{\iterm}[1]{\def\theTerm{#1}}
\newcommand{\icourse}[1]{\def\theCourse{#1}}
\newcommand{\isheetNumber}[1]{\def\theSheetNumber{#1}}
\iterm{}
\icourse{}
\isheetNumber{}
\title{}
\author{}

% define a command for user to set some contact info in the footer
\newcommand{\icontact}[1]{\def\theContact{#1}}
\icontact{}

\RequirePackage{hyperref}
\hypersetup{
  colorlinks=true,
  linkcolor=blue,
  filecolor=magenta,
  urlcolor=cyan,
}

\RequirePackage{amsthm}
\RequirePackage{xcolor}
\theoremstyle{definition}
\newtheorem{iproblem}{{\color{blue} Problem}}
\newtheorem{iexercise}{{\color{blue} Exercise}}
\newtheorem{iquestion}{{\color{blue} Question}}
\theoremstyle{remark}
\newtheorem*{ianswer}{{\color{blue} Answer}}
\newtheorem*{isolution}{{\color{blue} Solution}}

\renewcommand{\proofname}{{\color{blue} Proof}}

\RequirePackage{ifthen}
\newcommand{\iproblemNumber}[1][]{
  \ifthenelse{\equal{#1}{}}{
  }{
    \setcounter{iproblem}{#1}
    \addtocounter{iproblem}{-1}
  }
}
\newcommand{\iquestionNumber}[1][]{
  \ifthenelse{\equal{#1}{}}{
  }{
    \setcounter{iquestion}{#1}
    \addtocounter{iquestion}{-1}
  }
}

\RequirePackage{enumitem}
\newlist{iparts}{enumerate}{2}
\newcommand{\ipartLabel}{\arabic{ipartsi}.}
\setlist[iparts]{label=\ipartLabel}
\newcommand{\ipart}[1][]{
  \ifthenelse{\equal{#1}{}}{
  }{
    \setcounter{ipartsi}{#1}
    \addtocounter{ipartsi}{-1}
  }
  \item
}
\newenvironment{isubparts}{\begin{iparts}}{\end{iparts}}
\newcommand{\isubpart}[1][]{
  \ifthenelse{\equal{#1}{}}{
  }{
    \setcounter{ipartsii}{#1}
    \addtocounter{ipartsii}{-1}
  }
  \item
}
