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
                margin=0cm]{geometry}
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

% ---------------- Section Styling ----------------

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

\newif\ifaftersection
\aftersectionfalse

\newlength{\temp}
\renewcommand{\section}[1]{%
  \setlength{\temp}{\parskip}%
  \setlength{\parskip}{0ex}%
  \par\vspace{2ex}%
  {\bfseries
   \fontsize{50}{50}\selectfont
   \textcolor{hsmwblue}{#1}\par}%
  \vspace{-1ex}%
  \setlength{\parskip}{\temp}%
  \aftersectiontrue
}

\renewcommand\subsection[1]{%
  \setlength{\temp}{\parskip}%
  \setlength{\parskip}{0ex}%
  \par
  \ifaftersection
    \vspace{2.5ex}   % larger distance after section
  \else
    \vspace{1.5ex} % normal distance
  \fi
  {\bfseries
   \fontsize{35}{35}\selectfont
   \textcolor{hsmwblue}{#1}\par}%
  \vspace{-0.5ex}%
  \setlength{\parskip}{\temp}%
  \aftersectionfalse
}

\makeatother

% ---------------- Math Font ----------------

\setmathfont{TeX Gyre Pagella}


% ---------------- Positions ----------------

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
\newlength{\TitleBoxHeight}


\setlength{\LeftMargin}{0.038\paperwidth}
\setlength{\RightMargin}{0.028\paperwidth}
\setlength{\TopMargin}{0.18\paperheight}
\setlength{\ColumnWidth}{0.27\paperwidth}
\setlength{\TitleWidth}{0.57\paperwidth}
\setlength{\TitleTop}{0.05\paperheight}
\setlength{\TitleBoxHeight}{0.072\paperheight}
\setlength{\FullLine}{\dimexpr\paperwidth - 2\LeftMargin\relax}
%\setlength{\AuthorTop}{0.164\paperheight}
\setlength{\AuthorTop}{0.15\paperheight}
\setlength{\FooterTop}{\dimexpr\paperheight - 0.07\paperheight\relax}
%\setlength{\BodyBottom}{0.12\paperheight}
\setlength{\BodyBottom}{0.135\paperheight}
\setlength{\BodyHeight}{0.675\paperheight}

% Full-width reservation heights
\newlength{\TopFullWidthHeight}
\newlength{\BottomFullWidthHeight}
\setlength{\TopFullWidthHeight}{0pt}
\setlength{\BottomFullWidthHeight}{0pt}

% ---------------- Font ----------------

\setmainfont[
  Path = ./fonts/,
  UprightFont = *-Regular.ttf,
  BoldFont = *-Bold.ttf,
  ItalicFont = *-Italic.ttf,
  BoldItalicFont = *-BoldItalic.ttf
]{Raleway}

% ---------------- Colors and Helpers ----------------

\definecolor{hsmwblue}{RGB}{0, 105, 179}
\newcommand{\blue}{\color{hsmwblue}}
\newcommand{\black}{\color{black}}

% ---------------- Title / Footer ----------------

\makeatletter
\global\let\@mainauthors\@empty
\global\let\@coauthors\@empty
\global\let\@correspondent\@empty
\global\let\@email\@empty
\global\let\@centerlogo\@empty
\global\let\@sponsorlogo\@empty
\global\let\@sponsortext\@empty

\newcommand{\mainauthor}[1]{%
  \ifx\@mainauthors\@empty
    \gdef\@mainauthors{\uline{#1}}%
  \else
    \g@addto@macro\@mainauthors{, \uline{#1}}%
  \fi
}

\newcommand{\coauthor}[1]{%
  \ifx\@coauthors\@empty
    \gdef\@coauthors{#1}%
  \else
    \g@addto@macro\@coauthors{, #1}%
  \fi
}

\newcommand{\correspondent}[1]{%
  \gdef\@correspondent{#1}%
}

\newcommand{\email}[1]{%
  \gdef\@email{#1}%
}


\newcommand{\posterlayout}{%
  % poster title
    \begin{textblock*}{\TitleWidth}(\LeftMargin,\TitleTop)
      \begin{minipage}[b][\TitleBoxHeight][b]{\TitleWidth}
        \microtypesetup{protrusion=false}
        \hyphenpenalty=10000
        \exhyphenpenalty=10000
        \pretolerance=1000
        \tolerance=1000
        \bfseries \blue
        \fontsize{80}{92}\selectfont
        \raggedright
        \@title
      \end{minipage}
    \end{textblock*}

  % poster authors
  \begin{textblock*}{\FullLine}(\LeftMargin,\AuthorTop)
    \itshape
    \fontsize{50}{50}\selectfont
    \ifx\@mainauthors\@empty
      \@coauthors
    \else
      \@mainauthors
      \ifx\@coauthors\@empty
      \else
        , \@coauthors
      \fi
    \fi
  \end{textblock*}

% ---------------- Footer ----------------
  \begin{textblock*}{\FullLine}(\LeftMargin,\FooterTop)
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


% -------- Storage --------
\global\let\@centerlogo\@empty
\global\let\@sponsorblocks\@empty

% -------- Public commands --------

\newlength{\SponsorTopShift}
\setlength{\SponsorTopShift}{0pt}

\newcommand{\SetSponsorTopShift}[1]{%
  \setlength{\SponsorTopShift}{#1}%
}

\newcommand{\CenterLogo}[1]{%
  \gdef\@centerlogo{#1}%
}

\newcommand{\ClearCenterLogo}{%
  \global\let\@centerlogo\@empty
}

\newcommand{\ClearSponsorBlocks}{%
  \global\let\@sponsorblocks\@empty
}

\newcommand{\AddSponsorBlockVertical}[2]{%
  \g@addto@macro\@sponsorblocks{%
    \hspace{0.5cm}%
    \begin{minipage}[c]{0.2\FullLine}%
      \raggedleft
      \includegraphics[
              height=5cm,
              width=\linewidth,
              keepaspectratio
            ]{#1}\par
      {\fontsize{20}{22}\selectfont #2}%
    \end{minipage}%
  }%
}
\newcommand{\AddSponsorBlockHorizontal}[2]{%
  \g@addto@macro\@sponsorblocks{%
    \hspace{0.5cm}%
    \begin{minipage}[t]{0.26\FullLine}%
      \raggedleft
      \begin{minipage}[c]{0.44\linewidth}
      \makebox[\linewidth][r]{%
        \includegraphics[
          height=8cm,
          width=\linewidth,
          keepaspectratio
        ]{#1}
        }
      \end{minipage}%
      \hfill
      \begin{minipage}[c]{0.55\linewidth}
        {\fontsize{20}{22}\selectfont #2}
      \end{minipage}
    \end{minipage}%
  }%
}

% -------- Print command --------
\newcommand{\printsponsorblock}{%
  % Center logo
  \ifx\@centerlogo\@empty\else
    \begin{textblock*}{\FullLine}(\LeftMargin,\dimexpr\FooterTop+\SponsorTopShift\relax)
      \centering
      \includegraphics[height=5cm]{\@centerlogo}
    \end{textblock*}
  \fi

  % Right sponsor area with multiple blocks
  \ifx\@sponsorblocks\@empty\else
    \begin{textblock*}{0.78\FullLine}(\dimexpr\LeftMargin+0.22\FullLine\relax,\dimexpr\FooterTop+\SponsorTopShift\relax)
      \raggedleft
      \@sponsorblocks
    \end{textblock*}
  \fi
}

\makeatother




% ---------------- Sponsors ----------------

\newenvironment{sponsorblock}{%
  \begin{textblock*}{0.757\FullLine}(\dimexpr\LeftMargin + 0.23\paperwidth\relax,\FooterTop)
    \fontsize{25}{29}\selectfont
    \noindent\ignorespaces
}{%
  \end{textblock*}
}



% ---------------- Main Poster Environment ----------------

\newenvironment{poster}
{%
  \sloppy
  \fontsize{35}{40}\selectfont
  \setlength{\parskip}{\baselineskip}
    % formula
    \setlength{\abovedisplayskip}{24pt}
    \setlength{\belowdisplayskip}{24pt}  
  \raggedbottom
  
}
{%
  \par\nobreak\vfil
}



% ---------------- Column Setup ----------------

\makeatletter

\newlength{\ColumnGap}
\setlength{\ColumnGap}{35pt}

\newlength{\PosterBodyY}
\newlength{\PosterColumnHeight}
\newlength{\fc@colwidth}
\newlength{\LeftMarginOffset}

\newcommand{\ReserveTopFullWidth}[1]{%
  \setlength{\TopFullWidthHeight}{#1}%
}

\newcommand{\ReserveBottomFullWidth}[1]{%
  \setlength{\BottomFullWidthHeight}{#1}%
}

\newcommand{\SetPosterColumns}[1]{%
  \def\fc@N{#1}%
  \setlength{\LeftMarginOffset}{\LeftMargin}%
  \setlength{\PosterBodyY}{\dimexpr\BodyBottom + \BottomFullWidthHeight\relax}%
  \setlength{\PosterColumnHeight}{\dimexpr\BodyHeight - \TopFullWidthHeight - \BottomFullWidthHeight\relax}%
  \ifnum\fc@N=1
    \newflowframe{\FullLine}{\PosterColumnHeight}{\LeftMarginOffset}{\PosterBodyY}%
  \else
    \ifnum\fc@N=2
      \setlength{\fc@colwidth}{\dimexpr(\FullLine-\ColumnGap)/2\relax}%
      \newflowframe{\fc@colwidth}{\PosterColumnHeight}{\LeftMarginOffset}{\PosterBodyY}%
      \newflowframe{\fc@colwidth}{\PosterColumnHeight}{\dimexpr\LeftMarginOffset+\fc@colwidth+\ColumnGap\relax}{\PosterBodyY}%
    \else
      \PackageError{hsmwposter}{Only 1 or 2 columns supported}{}%
    \fi
  \fi
}
\makeatother

% ---------------- Full-width Blocks ----------------

\newenvironment{topfullwidthblock}[1]
{%
  % #1 = block height
  \begin{textblock*}{\FullLine}(\LeftMargin,\BodyBottom)
    \begin{minipage}[t][#1][t]{\FullLine}
      \fontsize{35}{40}\selectfont
      \setlength{\parskip}{\baselineskip}
      \raggedright
}
{%
    \end{minipage}
  \end{textblock*}
}

\newenvironment{bottomfullwidthblock}[1]
{%
  % #1 = block height
  \begin{textblock*}{\FullLine}(\LeftMargin,\dimexpr\BodyBottom+\BodyHeight-#1\relax)
    \begin{minipage}[t][#1][t]{\FullLine}
      \fontsize{35}{40}\selectfont
      \setlength{\parskip}{\baselineskip}
      \raggedright
}
{%
    \end{minipage}
  \end{textblock*}
}