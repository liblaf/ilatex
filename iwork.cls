\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{iwork}[2022/03/12 Coursework Class]

% load in the main exam class with appropriate options
\LoadClass[a4paper]{exam}

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
  \bfseries \Large \theCourse \leavevmode \\
  \large Sheet \theSheetNumber \ Solutions \quad --- \quad \theTerm \leavevmode \\
  \@title \leavevmode \\
  \@author
]{}
\rhead[]{\bfseries \theCourse: Sheet \theSheetNumber \ Solutions --- \theTerm}
\lfoot{\footnotesize \theDepartment \leavevmode \\ \href{mailto:\theContact}{\theContact}}
\cfoot{}
\rfoot{Page \thepage{} of \numpages}
\footrule

% define newcommands for user set page header details
\title{}
\author{Qin Li}
\newcommand{\iterm}[1]{\def\theTerm{#1}}
\newcommand{\icourse}[1]{\def\theCourse{#1}}
\newcommand{\isheetNumber}[1]{\def\theSheetNumber{#1}}
\iterm{Spring Term 2021 -- 2022}
\icourse{Course Name}
\isheetNumber{0}

% define a command for user to set some contact info in the footer
\newcommand{\idepartment}[1]{\def\theDepartment{#1}}
\newcommand{\icontact}[1]{\def\theContact{#1}}
\idepartment{Weiyang College, Tsinghua University}
\icontact{liqin20@mails.tsinghua.edu.cn}

\RequirePackage{hyperref}
\hypersetup{
  colorlinks=true,
}

\RequirePackage{tcolorbox}
\tcbuselibrary{breakable, skins}
\newcounter{iproblemCounter}
\newtcolorbox[
  auto counter,
  use counter = iproblemCounter,
]{iproblem}[1][]{
  title       = {Problem \thetcbcounter. #1},
  colframe    = blue!75!white,
  colback     = blue!5!white,
  fonttitle   = \bfseries,
  breakable,
  enhanced,
}
\RequirePackage{amsthm}
\RequirePackage{xcolor}
\theoremstyle{remark}
\newtheorem*{ianswer}{{\color{blue} Answer}}
\newtheorem*{isolution}{{\color{blue} Solution}}
\renewcommand{\proofname}{{\color{blue} Proof}}

\RequirePackage{ifthen}
\newcommand{\iproblemNumber}[1][]{
  \ifthenelse{\equal{#1}{}}{
  }{
    \setcounter{iproblemCounter}{#1}
    \addtocounter{iproblemCounter}{-1}
  }
}

\RequirePackage{enumitem}
\newlist{iparts}{enumerate}{2}
\newcommand{\ipartLabel}{\arabic*.}
\setlist[iparts]{label*=\ipartLabel}
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
