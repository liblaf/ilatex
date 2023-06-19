\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{iwork}

\LoadClassWithOptions{iarticle}

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
      \includegraphics[height = 0.3 \linewidth]{#3}
    }{
      \includegraphics[#2]{#3}
    }
    \ifdefempty{\cmdKV@image@caption}{
      \caption{}
    }{
      \caption{\cmdKV@image@caption}
    }
    \ifdefempty{\cmdKV@image@label}{
      \label{fig:#3}
    }{
      \label{fig:\cmdKV@image@label}
    }
  \end{figure}
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

\NewTasksEnvironment[
  label = \Alph*.,
  ref   = \Alph*,
]{choices}[\choice](4)

\theoremstyle{remark}
\newtheorem*{sol}{\textcolor{theorem}{Solution}}
\renewcommand{\proofname}{\textcolor{theorem}{Proof}}

\author{
  \thename \quad \theid \\
  \theclass
}

\course{Coursework}
\ifdefstring{\i@lang}{zh}{
  \course{课程作业}
}{}
