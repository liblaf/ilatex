\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{iwork}[2022/03/12 Coursework Class]

% load in the main exam class with appropriate options
\LoadClass[a4paper]{exam}

\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{amsthm}
\RequirePackage{enumitem}
\RequirePackage{etoolbox}
\RequirePackage{float}
\RequirePackage{hyperref}
\RequirePackage{physics}
\RequirePackage{siunitx}
\RequirePackage{subcaption}
\RequirePackage{tcolorbox}
\RequirePackage{xcolor}

\RequirePackage{cleveref}

\AtBeginDocument{\RenewCommandCopy\qty\SI}

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
  \bfseries \Large \@course \leavevmode \\
  \large Sheet \@sheetNumber \ Solutions \quad --- \quad \@semester \leavevmode \\
  \@title \leavevmode \\
  \ifstrempty{\@class}{}{\@class \quad} \ifstrempty{\@id}{}{\@id \quad} \@author
]{}
\rhead[]{\bfseries \@course: Sheet \@sheetNumber \ Solutions --- \@semester}
\lfoot{\footnotesize \@department \leavevmode \\ \href{mailto:\@email}{\@email}}
\cfoot{}
\rfoot{Page \thepage{} of \numpages}
\footrule

% define newcommands for user set page header details
\title{}
\author{Qin Li}
\newcommand{\class}[1]{\def\@class{#1}}
\newcommand{\id}[1]{\def\@id{#1}}
\newcommand{\semester}[1]{\def\@semester{#1}}
\newcommand{\course}[1]{\def\@course{#1}}
\newcommand{\sheetNumber}[1]{\def\@sheetNumber{#1}}
\class{未央-水木 02}
\id{2020012872}
\semester{Autumn Term 2022 -- 2023}
\course{Course Name}
\sheetNumber{0}

% define a command for user to set some contact info in the footer
\newcommand{\department}[1]{\def\@department{#1}}
\newcommand{\email}[1]{\def\@email{#1}}
\department{Weiyang College, Tsinghua University}
\email{liqin20@mails.tsinghua.edu.cn}

\hypersetup{
  colorlinks = true,
}

\tcbuselibrary{breakable, skins}
\newcounter{probCounter}
\newtcolorbox[
  auto counter,
  use counter = probCounter,
]{prob}[1][]{
  title     = {Problem \thetcbcounter. #1},
  colframe  = blue!75!white,
  colback   = blue!5!white,
  fonttitle = \bfseries,
  breakable,
  enhanced,
}

\theoremstyle{remark}
\newtheorem*{ans}{{\color{blue} Answer}}
\newtheorem*{sol}{{\color{blue} Solution}}
\renewcommand{\proofname}{{\color{blue} Proof}}

\newcommand{\probNumber}[1][]{
  \ifstrempty{#1}{
  }{
    \setcounter{probCounter}{#1}
    \addtocounter{probCounter}{-1}
  }
}

\newlist{subprobs}{enumerate}{2}
\newcommand{\subprobLabel}{\arabic*.}
\setlist[subprobs]{label*=\subprobLabel}
\newcommand{\subprob}[1][]{
  \ifstrempty{#1}{
  }{
    \setcounter{subprobsi}{#1}
    \addtocounter{subprobsi}{-1}
  }
  \item
}
\newenvironment{subsubprobs}{\begin{subprobs}}{\end{subprobs}}
\newcommand{\subsubprob}[1][]{
  \ifstrempty{#1}{
  }{
    \setcounter{subprobsii}{#1}
    \addtocounter{subprobsii}{-1}
  }
  \item
}
