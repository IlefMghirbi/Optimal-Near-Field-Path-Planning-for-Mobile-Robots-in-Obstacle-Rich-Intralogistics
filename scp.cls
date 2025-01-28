% ----------------------------------------------------------------------
% LaTeX class for the proceedings 
% Student Conference Proceedings
% ----------------------------------------------------------------------
% Please do not change this document.
% For writing your paper use SCP2025_main.tex
% ----------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{scp}[2024/12/05 v. 1.0 SCP class]

\@ifundefined{ClassPath}{\newcommand{\ClassPath}{}}{}
\@ifundefined{articleformat}{\newcommand{\printSubmissionType}{\articleformat{Submission to Student Conference}}}

\@ifundefined{Journalname}{\newcommand{\Journalname}{Student Conference Proceedings}}{}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}} 
\ProcessOptions\relax
\LoadClass[10pt,twocolumn]{scrartcl}


% journal colors
\RequirePackage[table]{xcolor}
\definecolor{scp_gray}{RGB}{88,105,121}	
\definecolor{scp_lightblue}{RGB}{110,165,206}
\definecolor{scp_darkblue}{RGB}{0,106,163}


% font settings
\RequirePackage[adobe-utopia]{mathdesign}

\RequirePackage{iftex}
\ifpdf
	\RequirePackage[T1]{fontenc}
	\RequirePackage[utf8]{inputenc}
\else
	\RequirePackage{fontspec}
\fi

%\RequirePackage{amssymb}

% page settings
\RequirePackage[a4paper,scale=0.8]{geometry}
\RequirePackage[spread]{flushend}


% header and footer settings
\newcommand*{\doifooter}[1]{\href{https://dx.doi.org/#1}{\vskip0em\sffamily\color{scp_lightblue}#1}}

\ifdefined\ArticleIDYear\ifdefined\ArticleIDMonth\ifdefined\ArticleIDNumber
\newcommand{\ArticleID}{%
	\ArticleIDYear\ArticleIDMonth\ArticleIDNumber%
}
\fi\fi\fi

\RequirePackage[compatV3]{fancyhdr} %%% option is new xxx
\RequirePackage{ifthen}
\renewcommand{\headrulewidth}{0pt}
\setlength{\headheight}{30pt}
\setlength{\footskip}{40pt}
\pagestyle{fancy}

	\lhead{\ifthenelse{\value{page}=1}{
			\sffamily \color{scp_gray} \Journalname \\ %
			\ifdefined\FutureIssue
				Accepted Manuscript for Future Issue, %
			\else
				\ifdefined\CustomIssueTitle
					\CustomIssueTitle, %				
				\else
					\ifdefined\VolNr \ifdefined\IssNr
					Vol \VolNr , No \IssNr , \ArticleIDYear %
					\ifdefined\CustomIssueSuffix
						\CustomIssueSuffix %
					\fi
					\fi\fi
				\fi
			\fi
			\ifdefined\ArticleID , Article ID \ArticleID \fi
			\ifdefined\NumPages , \NumPages{} Pages \fi
			}{ 
			\sffamily\color{scp_gray}\Journalname}}
		\ifdefined\DOIPrefix \ifdefined\DOIJournal \ifdefined\DOIYear \ifdefined\ArticleID
		\lfoot{\doifooter{\DOIPrefix/\DOIJournal.\DOIYear.\ArticleID}}
		\fi\fi\fi\fi
		\cfoot{}
		\ifdefined\PublisherYear \ifdefined\Publishername
		\rfoot{\vskip0.25em\sffamily \color{scp_gray} \copyright\ \PublisherYear{} \Publishername}
		\fi \fi

% language settings
\RequirePackage[american]{babel}
\RequirePackage{csquotes}

% captions settings
\RequirePackage{caption}
\DeclareCaptionFont{scp_darkblue}{\color{scp_darkblue}}
\captionsetup{format = plain, font = small, font ={small}, labelfont={small,scp_darkblue,sf,bf}}
\setlength\belowcaptionskip{5pt}


% graphics settings
\RequirePackage{graphicx}


% horizontael tables lines
\RequirePackage{booktabs} % \toprule, \midrule, \bottomrule


% tweaking the footnotes
\RequirePackage[hang,flushmargin]{footmisc} 


% optimized typography
\RequirePackage{ifpdf}
\ifpdf
  \RequirePackage[protrusion=true,expansion=true]{microtype}
\fi


% new commands to pass authors and affiliations
\def\addtok#1#2{\global#1\expandafter{\the#1#2}}
\newcounter{n@authors}
\newtoks\@authors
\newtoks\@pdfauthors
\newtoks\@shortauthors

\renewcommand{\author}[4]{%
	\stepcounter{n@authors}%
  	\ifnum \then@authors > 1 \addtok\@authors{$\cdot$ } \addtok\@pdfauthors{, } \addtok\@shortauthors{$\cdot$ } \fi%
	\addtok\@authors{#2~#1%
		\def\temp{#4}\ifx\temp\empty\else\,\orcidlink{#4}\fi%
		\textcolor{scp_lightblue}{$^{\,#3}$}}%
  	\addtok\@pdfauthors{#2 #1}%
  	\addtok\@shortauthors{#1}%
  	
}

\newcounter{n@affiliations}
\newtoks\@affiliations
\newcommand{\affiliation}[2]{%
	\stepcounter{n@affiliations}%
  	\ifnum \then@affiliations > 1 \addtok\@affiliations{\newline} \fi%
  	\addtok\@affiliations{\textcolor{scp_lightblue}{$^{#1}$}#2}%
}

\newcommand{\email}[1]{email: %
	\href{mailto:#1}{#1}}

% article format
\newcommand\articleformat[1]{\renewcommand\@articleformat{\textit{#1}}}
\newcommand\@articleformat{\@latex@error{No \noexpand\articleformat given}\@ehc}

\def\printCC{1}

% title page
\renewcommand{\maketitle}{
  	\vskip1.5em%
	\ifdefined\NoSubmissionType
	\else
		{\flushleft\large\sffamily\@articleformat}%
	\fi
  	{\flushleft\color{scp_darkblue}\huge\bfseries\sffamily\@title\par}%
  	\vskip1.5em%
  	{\flushleft\sffamily\large\the\@authors\par}%
  	\vskip1.5em%
  	{\flushleft\sffamily\the\@affiliations}%
  	\vskip1.5em%
  	\rhead{\ifthenelse{\value{page}=1}{
	\ifdefined\PublisherLogo \includegraphics[height=50pt]{\PublisherLogo} \fi
	}{
	\sffamily \color{scp_gray}\thepage}}%

{\flushleft\sffamily
	\ifdefined\ReceivingDate Received \ReceivingDate; \fi%
	\ifdefined\RevisionDate Revised \RevisionDate; \fi%
	\ifdefined\AcceptanceDate Accepted \AcceptanceDate; \fi%
	\ifdefined\PublishingDate Published online \PublishingDate \fi%
}

\ifdefined\IWMPIFormat
	%\vskip0.5em%
\else
  	\vskip1.5em%
\fi

	\ifdefined\AuthorCopyrightYear \ifdefined\AuthorCopyrightName 
	{\flushleft\sffamily \copyright\ \AuthorCopyrightYear{} \AuthorCopyrightName; \ifdefined\FullPublishername licensee \FullPublishername \fi}%
	\fi \fi
	\ifdefined\printCC
  	{\flushleft\sffamily This is an Open Access article distributed under the terms of the Creative Commons Attribution License (http://creativecommons.org/licenses/by/4.0), which permits unrestricted use, distribution, and reproduction in any medium, provided the original work is properly cited.}%
	\fi
	\hypersetup{pdftitle=\@title}%
  	\hypersetup{pdfauthor=\the\@pdfauthors}%
}


% abstract 
%\usepackage{tcolorbox}

\renewenvironment{abstract}{
	\centering
\ifdefined\IWMPIFormat
	\vskip0.5em
\else
  	\vskip3em
\fi
%  	\begin{tcolorbox}[size=tight,oversize,sharp corners,colback=scp_lightblue!0,colframe=scp_lightblue!0,left=65pt,right=65pt,bottom=10pt,top=10pt]
  	\begin{minipage}[t]{\textwidth}
  		\noindent%
  		{\flushleft\bfseries\sffamily\abstractname\vskip0.25em}%
	}{
  	\end{minipage}\par%
%  	\end{tcolorbox}
\ifdefined\IWMPIFormat
	\vskip2em
\else
  	\vskip4em
\fi
}


% font sizes and vertical spacings
\setlength\parindent{1.5em}
\setlength\partopsep{2\p@ \@plus 1\p@ \@minus 1\p@}
\def\@listi{\leftmargin\leftmargini
            \parsep 2\p@ \@plus\p@ \@minus\p@
            \topsep 4\p@ \@plus\p@ \@minus2\p@
            \itemsep2\p@ \@plus\p@ \@minus\p@}
\let\@listI\@listi
\@listi
\def\@listii {\leftmargin\leftmarginii
              \labelwidth\leftmarginii
              \advance\labelwidth-\labelsep
              \topsep    2\p@ \@plus\p@\@minus\p@
              \parsep    \z@
              \partopsep \p@ \@plus\z@ \@minus\p@
              \itemsep   \parsep}
\def\@listiiii {\leftmargin\leftmarginiii
              \labelwidth\leftmarginiii
              \advance\labelwidth-\labelsep}
\def\@listiv {\leftmargin\leftmarginiv
              \labelwidth\leftmarginiv
              \advance\labelwidth-\labelsep}
\def\@listv  {\leftmargin\leftmarginv
              \labelwidth\leftmarginv
              \advance\labelwidth-\labelsep}
\def\@listvi {\leftmargin\leftmarginvi
              \labelwidth\leftmarginvi
              \advance\labelwidth-\labelsep}

\renewcommand\thesection{\Roman{section}}  
\setkomafont{section}{\normalfont\Large\sffamily\bfseries\color{black}}
\renewcommand\thesubsection{\thesection.\Roman{subsection}}
\setkomafont{subsection}{\normalfont\large\sffamily\bfseries\color{black}}
\setkomafont{subsubsection}{\normalfont\normalsize\sffamily\bfseries\color{black}}
\setkomafont{paragraph}{\normalfont\large\sffamily\bfseries\color{black}}
\setkomafont{subparagraph}{\normalfont\large\sffamily\bfseries\color{black}}

% hyperref settings
\RequirePackage[colorlinks,%
				linkcolor=scp_lightblue,%
				citecolor=scp_lightblue,%
				urlcolor=scp_lightblue,
				breaklinks]{hyperref}
\hypersetup{pdfpagelayout=SinglePage,pdfdisplaydoctitle}
\hypersetup{pagebackref=true}
\usepackage{doi}

% bibliography settings
\RequirePackage[style=\ClassPath scp,
	dashed=false,
	maxnames=99,
	backend=biber]{biblatex}
	
\renewcommand*{\bibfont}{\footnotesize}
\setlength{\bibitemsep}{1.5pt}
\setlength{\biblabelsep}{5pt}

\RequirePackage[binary-units=true]{siunitx}

\DeclareSIUnit{\mT}{\milli\tesla}
\DeclareSIUnit{\kHz}{\kilo\hertz}
\DeclareSIUnit{\MHz}{\mega\hertz}
\DeclareSIUnit{\Tpm}{\tesla\per\metre}
\DeclareSIUnit{\mul}{\micro\litre}
\DeclareSIUnit{\mgml}{\milli\gram/\milli\litre}
\DeclareSIUnit{\cm}{\centi\metre}
\DeclareSIUnit{\mm}{\milli\metre}
\DeclareSIUnit{\mum}{\micro\metre}
\DeclareSIUnit{\mumol}{\micro\mol}
\DeclareSIUnit{\degC}{\celsius}

\RequirePackage{orcidlink}

\newcommand{\refTab}[1]{Table~\ref{#1}}
\newcommand{\refFig}[1]{Figure~\ref{#1}}
\newcommand{\refEq}[1]{(\ref{#1})}
\newcommand{\refSec}[1]{Section~\ref{#1}}