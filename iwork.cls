\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{iwork}[2022/10/20 Coursework Class]

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{iarticle}}
\ProcessOptions\relax

\LoadClass{iarticle}

\fancyhead[L]{\small \thecourse}
\fancyhead[C]{}
\fancyhead[R]{\small \@date}
\fancyfoot[L]{\small \thedepartment \\ \theemail}
\fancyfoot[C]{}
\fancyfoot[R]{Page \thepage{} of \,\pageref{LastPage}}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0.4pt}

\fancypagestyle{titlepage}{
  \pagestyle{fancy}
  \fancyhead[C]{}
}

\newcounter{prob}
\newtcolorbox[
  auto counter,
  use counter = prob,
]{prob}[1][]{
  title     = {Problem \thetcbcounter. #1},
  colframe  = blue!75!white,
  colback   = blue!5!white,
  fonttitle = \bfseries,
  breakable,
  enhanced,
}

\NewTasksEnvironment[
  label = \Alph*.,
  ref   = \Alph*,
]{choices}[\choice](4)

\theoremstyle{remark}
\newtheorem*{sol}{\textcolor{blue}{Solution}}
\renewcommand{\proofname}{\textcolor{blue}{Proof}}

\author{
  \thename \quad \theid \\
  \theclass
}

\course{}
