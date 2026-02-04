\ProvidesClass{hsmwposter}
\LoadClass[oneside]{article}

\AtBeginDocument{%
  \pagestyle{empty}
  \thispagestyle{empty}
}

\setlength{\parindent}{0pt}

% import packages
\RequirePackage{graphicx}
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{fontspec}
\RequirePackage[dvipsnames]{xcolor}
\RequirePackage{microtype}
\RequirePackage{amsmath}
\RequirePackage[normalem]{ulem}
\RequirePackage{ragged2e}
\RequirePackage{multicol}
\RequirePackage[a0paper,
                portrait,
                margin=0cm,
                ]{geometry} 
\RequirePackage{eso-pic}  
\RequirePackage{atbegshi} 
\RequirePackage{changepage}
\RequirePackage{afterpage}
\RequirePackage{etoolbox}
\RequirePackage{pgffor}
\RequirePackage{flowfram}
\RequirePackage{titlesec}
\RequirePackage{unicode-math}
\RequirePackage{caption}
\RequirePackage{subcaption}
\RequirePackage{adjustbox}


\DeclareCaptionFormat{poster}
{
  {\fontsize{30}{32}\selectfont#1#2\textit{#3}}
}
\captionsetup{
  format=poster
}

%--Section Styling--

% Section Spacing

\titlespacing*{\section}{0pt}{0ex}{-1ex}
\titlespacing*{\subsection}{0pt}{-0.5ex}{-1.5ex}
% Background
\AddToShipoutPictureBG*{
  \AtPageLowerLeft{
    \includegraphics[width=\paperwidth,height=\paperheight]{./background/bg.pdf}%
  }
}

% Section Formatting
\makeatletter

\newlength{\temp}
\renewcommand{\section}[1]{
  \setlength{\temp}{\parskip}
  \setlength{\parskip}{0ex}
  \par\vspace{2ex}
  {\bfseries
   \fontsize{50}{50}\selectfont
   \textcolor{hsmwblue}{#1}\par}
  \vspace{-1ex}
  \setlength{\parskip}{\temp}
}

\renewcommand\subsection[1]{%
  \setlength{\temp}{\parskip}
  \setlength{\parskip}{0ex}
  \par\vspace{1.5ex}
  {\bfseries
   \fontsize{35}{35}\selectfont
   \textcolor{hsmwblue}{#1}\par}%
  \vspace{-0.5ex}%
  \setlength{\parskip}{\temp}
}

\makeatother
% Math Font Size
% \setmathfont{Latin Modern Math}
% \setmathfont{TeX Gyre Termes Math}
\setmathfont{TeX Gyre Pagella}

% positions
\newlength{\LeftMargin}
\newlength{\RightMargin}
\newlength{\TopMargin}
\newlength{\ColumnWidth}
\newlength{\TitleWidth}
\newlength{\TitleTop}
\newlength{\FullLine}
\newlength{\AuthorTop}
\newlength{\FooterTop}
\newlength{\BodyBottom}
\newlength{\BodyHeight}
\newlength{\OffSetX}

\setlength{\LeftMargin}{0.038\paperwidth}
\setlength{\RightMargin}{0.028\paperwidth}
\setlength{\TopMargin}{0.18\paperheight}
\setlength{\ColumnWidth}{0.27\paperwidth}
\setlength{\TitleWidth}{0.57\paperwidth}
\setlength{\TitleTop}{0.05\paperheight}
\setlength{\FullLine}{\dimexpr\paperwidth - 2\LeftMargin \relax}
\setlength{\AuthorTop}{0.164\paperheight}
\setlength{\FooterTop}{\dimexpr\paperheight - 0.07\paperheight\relax}
\setlength{\BodyBottom}{0.12\paperheight}
\setlength{\BodyHeight}{0.675\paperheight}

% font
\setmainfont[
  Path = ./fonts/,
  UprightFont = *-Regular.ttf,
  BoldFont = *-Bold.ttf,
  ItalicFont = *-Italic.ttf,
  BoldItalicFont = *-BoldItalic.ttf
]{Raleway}

% variables
\definecolor{hsmwblue}{RGB}{0, 105, 179}
\newcommand{\blue}{\color{hsmwblue}}
\newcommand{\black}{\color{black}}

%--------- title/footer ----------
% author variables
\makeatletter
\global\let\@mainauthors\@empty % main authors underlined italic
\global\let\@coauthors\@empty   % coauthors italic
\global\let\@correspondent      % footer correspeondent
\global\let\@email              % footer email

% mainauthor is array, add authors with \mainauthor{}
\newcommand{\mainauthor}[1]{
  \ifx\@mainauthors\@empty
    \gdef\@mainauthors{\uline{#1}}
  \else
    \g@addto@macro\@mainauthors{, \uline{#1}}
  \fi
}

% coauthor is array, add coauthors with \coauthor{}
\newcommand{\coauthor}[1]{
  \ifx\@coauthors\@empty
    \gdef\@coauthors{#1}
  \else
    \g@addto@macro\@coauthors{, #1}
  \fi
}

% correcpondent is single variable
\newcommand{\correspondent}[1]{
  \gdef\@correspondent{#1}
}

% email is single variable
\newcommand{\email}[1]{
  \gdef\@email{#1}
}

% poster title, authors and footer
\newcommand{\posterlayout}{ 

  % poster title
  \begin{textblock*}{\TitleWidth}(\LeftMargin,\TitleTop)
  \begin{minipage}{\TitleWidth}
    \microtypesetup{protrusion=false}
    \hyphenpenalty=10000
    \exhyphenpenalty=10000
    \pretolerance=1000
    \tolerance=1000
    \bfseries \blue 
    \fontsize{80}{92}\selectfont 
    \par \@title
  \end{minipage}
  \end{textblock*}
  
  % poster authors (main author, main author, coauthor, coauthor)
  \begin{textblock*}{\FullLine}(\LeftMargin,\AuthorTop)
  \itshape
  \fontsize{50}{50}\selectfont
  \ifx\@mainauthors\@empty
    \@coauthors
  \else
    \@mainauthors 
    \ifx\@coauthors\@empty
      %ignore
    \else
      , \@coauthors
    \fi
  \fi
  \end{textblock*}
  
  % footer with correspondent and email
  \begin{textblock*}{\FullLine}(\LeftMargin, \FooterTop)
    \fontsize{25}{29}\selectfont
    \par{
    {\bfseries\blue Hochschule Mittweida}\\
    University of Applied Sciences\\
    Technikumplatz 17, 09648 Mittweida\\
    \@correspondent / \@email\\[0.5em]
    www.hs-mittweida.de
    }
  \end{textblock*}
}
\makeatother

% sponsors

\newenvironment{sponsorblock}[0]{
  \begin{textblock*}{0.757\FullLine}(\dimexpr\LeftMargin + 0.23\paperwidth\relax, \FooterTop)
    \fontsize{25}{29}\selectfont 
    \noindent\ignorespaces
}
{
  \end{textblock*}
}

% main poster environment
\newenvironment{poster}
  {
    \sloppy
    \fontsize{35}{40}\selectfont
    \setlength{\parskip}{\baselineskip}
    \raggedbottom
  }
  {
    \par\nobreak\vfil
  } 


% columns setup
\makeatletter

\newlength{\ColumnGap}
\setlength{\ColumnGap}{35pt}  

\newcommand{\SetPosterColumns}[1]{
  \def\fc@N{#1}
  \newlength{\LeftMarginOffset}
  \setlength{\LeftMarginOffset}{\dimexpr\LeftMargin}
  \ifnum\fc@N=1
    \newflowframe{\FullLine}{\BodyHeight}{\LeftMarginOffset}{\BodyBottom}%
  \else
    \ifnum\fc@N=2
      \newlength{\fc@colwidth}
      \setlength{\fc@colwidth}{
        \dimexpr(\FullLine-\ColumnGap)/2\relax}
      \newflowframe{\fc@colwidth}{\BodyHeight}{\LeftMarginOffset}{\BodyBottom}
      \newflowframe{\fc@colwidth}{\BodyHeight}{\dimexpr\LeftMarginOffset+\fc@colwidth+\ColumnGap\relax}{\BodyBottom}
    \else
      \PackageError{hsmwposter}{Only 1 or 2 columns supported}{}
    \fi
  \fi
}
\makeatother
