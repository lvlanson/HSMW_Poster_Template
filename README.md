# Useage

**Compilation with lualatex!**

```bash
lualatex a0_poster.tex
```

Following the official design mostly. Using `Raleway` font instead of `open sans`. **Sections are currently not auto-numbered**

![full_pdf](./REPO_IMAGES/full_pdf.png)
## Authors
- add mainauthors with `\mainauthor{Leonhard Euler}`
- add coauthors with `\coauthor{Kurt Gödel}`

![author_image](./REPO_IMAGES/authors.png)

## Correspondents
- add main correspondent with `\correspondent{Leonhard Euler}`
- add email correpondence with `\email{leonhard.euler@euler-mathematics.unreal}`

![correspondence_image](./REPO_IMAGES/correspondence.png)

## Sponsors
- add sponsors with `\begin{sponsorblock}...\end{sponsorblock}` environment
```latex
\begin{sponsorblock}
  \hfill 
  \begin{minipage}[t]{0.30\textwidth}
    \raggedleft
    \includegraphics[width=\linewidth]{./sponsor/esf.jpg}
    {\fontsize{20}{22}\selectfont L.E. and C.F.G. are sponsored by European Social Fund \\(ESF, 000000000 \& 000000000)}
  \end{minipage}
\end{sponsorblock}
```

![sponsors_image](./REPO_IMAGES/sponsors.png)

## Figures
- add figures with `\begin{staticfigure} ... \end{staticfigure}` just like with the `figure` environment.

![figure_image](./REPO_IMAGES/figures.png)

## Tables
- add tables wrapped inside an adjustbox
```latex
\begin{statictable}
  \begin{adjustbox}{max width=\columnwidth}
    % your table goes here
  \end{adjustbox}
\end{statictable}
```
