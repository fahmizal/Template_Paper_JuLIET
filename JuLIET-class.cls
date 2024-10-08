\NeedsTeXFormat{LaTeX2e}

% Initial Statements
\DeclareOption{11pt}{\OptionNotUsed}
\DeclareOption{12pt}{\OptionNotUsed}
\DeclareOption{onecolumn}{\OptionNotUsed}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\newif\if@isblind\@isblindfalse
\DeclareOption{blind}{\@isblindtrue}

% Language Statements
\newif\iflang@eng
\newif\iflang@por
\def\lang@mutopterr{%
	\PackageError{lang}{Options 'eng' and 'por' are mutually exclusive.}{}%
}%
\DeclareOption{eng}{%
	\iflang@por\lang@mutopterr\fi
	\lang@engtrue\lang@porfalse
}
\DeclareOption{por}{%
	\iflang@eng\lang@mutopterr\fi
	\lang@engfalse\lang@portrue
}

\ProcessOptions\relax
\LoadClass[twoside,a4paper,10pt,twocolumn,english]{article}

% Default language: English
\iflang@eng
\else
\iflang@por
\else
\lang@engtrue\lang@porfalse
\fi
\fi


% Required Packages
\usepackage{indentfirst}
\usepackage[utf8]{inputenc}
\iflang@eng
\usepackage[english]{babel}
\fi
\iflang@por
\usepackage[portuguese,english]{babel}
\fi
\usepackage[T1]{fontenc}
\usepackage{ae,aecompl}
\usepackage{pslatex}
\usepackage[samesize]{cancel}
\usepackage{graphicx}
\usepackage{setspace}
\usepackage{amsmath}
\usepackage{amsfonts}
\usepackage{amssymb}
\usepackage{float}
\usepackage{mathptmx}
\usepackage{url}
\Urlmuskip=0mu plus 1mu % break url lines
\usepackage{calc}
\usepackage{tabto}
\usepackage{lettrine}
\usepackage{booktabs}

%%% PDF file setup
\usepackage[bookmarks,
bookmarksopen = true,
bookmarksnumbered = true,
breaklinks = true,
colorlinks = true,
linkcolor = black,
urlcolor  = black,
citecolor = black,
anchorcolor = green,
hyperindex = true,
hyperfigures]{hyperref}

%%% subsubsection formatting
\usepackage{enumitem}
\setlist{topsep=0pt,itemsep=4pt,partopsep=4pt, parsep=4pt}



% Page setup
\setlength{\hoffset}{-1in}
\setlength{\voffset}{-1in}
\setlength{\oddsidemargin}{2cm}
\setlength{\evensidemargin}{2cm}
\setlength{\topmargin}{0.7cm}
\setlength{\headheight}{1.0cm}
\setlength{\headsep}{0.34cm}
\setlength{\textheight}{25.7cm}
\setlength{\textwidth}{17.5cm}
\setlength{\footskip}{1.0cm}
\setlength{\columnsep}{0.5cm}

% Author and Affiliate Setup
\usepackage[noblocks]{authblk}
\renewcommand\AB@affilsepx{\protect\par\protect\Affilfont}
\iflang@eng
\renewcommand\Authands{ and }
\renewcommand\Authand{ and }
\fi
\iflang@por
\renewcommand\Authands{ e }
\renewcommand\Authand{ e }
\fi
\renewcommand{\Affilfont}{\fontsize{9}{12} \selectfont \itshape}
\renewcommand{\Authfont}{\fontsize{12}{14} \selectfont}

% Macro Declaration
\def\thisvolume#1{\gdef\@thevolume{#1}}        						% Volume
\def\thisnumber#1{\gdef\@thenumber{#1}}        					    % Number
\def\thismonth#1{\gdef\@themonth{#1}}             					% Month
\def\thisyear#1{\gdef\@theyear{#1}}             					% Year
\def\receptiondate#1{\gdef\@receptiondate{#1}}       				% Receipt date
\def\acceptancedate#1{\gdef\@acceptancedate{#1}}     				% Date accepted
\def\publicationdate#1{\gdef\@publicationdate{#1}}   				% Publication Date
\def\abstrak#1{\gdef\@intisari{#1}}        							% Abstrak dalam Indo
\def\katakunci#1{\gdef\@katakunci{#1}}        						% Kata kunci dalam Indo
\def\abstract#1{\gdef\@englishabstract{#1}}        					% Abstract in English
\def\keywords#1{\gdef\@englishkeywords{#1}}        					% Keywords in English
\def\resumo#1{\gdef\@portugueseabstract{#1}}        				% Resumen en inglés
\def\palavraschave#1{\gdef\@portuguesekeywords{#1}}        			% Palabras clave en inglés

% get the publish num
\def \inputpublishnum#1{\gdef\@thepublishnum{#1}}
\newcommand{\nomorterbit}{\@thepublishnum}

% Definition for contact data
\def \contactauthor#1{\gdef\@thecontactauthor{#1}}
\def\email#1{\gdef\@theemail{#1}}
\newcommand*{\contacto}{%
	\if@isblind
	\iflang@eng
	Version for reviewers.
	\fi
	\iflang@por
	Versão para revisores.
	\fi
	\else
	\iflang@eng
	\@thecontactauthor,
	\@theemail
	\fi
	\iflang@por
	\@thecontactauthor,
	\@theemail
	\fi
	\fi
	
}
\renewcommand*\footnoterule{}
\newcommand\blfootnote[1]{%
	\begingroup
	\renewcommand\thefootnote{}\footnote{#1}%
	\addtocounter{footnote}{-1}%
	\endgroup
}
\newcommand*{\printcontactdata}{%
	\blfootnote{\\ {\fontsize{8}{11} \selectfont
			\iflang@eng
			%Contact data:
			\fi
			\iflang@por
			%Dados de contato:
			\fi
			\contacto
	}}
}

% Header Definitions
\def\title#1{\gdef\@title{#1}\gdef\thetitle{#1}}
\def\titulo#1{\gdef\@titulo{#1}} 
\def\shorttitle#1{\gdef\@theshorttitle{#1}}
\def\firstauthor#1{\gdef\@thefirstauthor{#1}}
\newcommand*{\authorheader}{%
	\begingroup
	\ifnum\value{authors}<4 % One author
	\if@isblind
	\iflang@eng
	AUTHOR
	\fi
	\iflang@por
	AUTOR
	\fi
	\else
	\MakeUppercase{\@thefirstauthor}
	\fi
	\else % 4 or more authors
	\if@isblind
	\iflang@eng
	1st. AUTHOR~{\itshape et al.}
	\fi
	\iflang@por
	1ro. AUTOR~{\itshape et al.}
	\fi
	\else
	{\MakeUppercase{\@thefirstauthor}~{\itshape et al.}}
	\fi
	\fi
	\endgroup
}
\newcommand{\vcenteredinclude}[1]{\begingroup
	\setbox0=\hbox{\includegraphics[height=\headheight]{#1}}%
	\parbox{\wd0}{\box0}\endgroup}


% Configuration of figure headings
\usepackage{hyperref}
\usepackage{caption}
\usepackage{subcaption}
\captionsetup[figure]{font=small,justification=centering}
\captionsetup[figure]{name=Gambar}
\DeclareCaptionFormat{myformat}{#1#2#3}%\rule{\linewidth}{.3pt}}
%\DeclareCaptionLabelFormat{myformat}{#1#2}
%\DeclareCaptionLabelSeparator{myformat}{.}
\captionsetup[figure]{format=myformat,labelsep=period}
\captionsetup[table]{font={small},justification=centering, labelsep=period}
\iflang@eng
\captionsetup[table]{name=Tabel}
\fi
\iflang@por
\captionsetup[table]{name=Tabela}
\captionsetup[figure]{name=Figura}
\fi
\usepackage{makecell} % break lines in cell tables
\renewcommand\theadalign{cc}
\renewcommand\theadgape{\Gape[4pt]}
\renewcommand\cellgape{\Gape[4pt]}
\addtolength{\belowcaptionskip}{-8pt}
\addtolength{\abovecaptionskip}{0pt}


% Work job cover
\newcommand*\varhrulefill[1][0.1pt]{\leavevmode\leaders\hrule height#1\hfill\kern0pt}
\renewcommand{\@maketitle}{%
\newpage
\null
\onecolumn
\begingroup
\vspace{-1.5cm}%
{\begin{center}%
		\noindent\varhrulefill[0.3mm] \par    
		\iflang@eng
		{\fontsize{20}{24} \selectfont \@title \par}
		\fi
		\iflang@por
		{\fontsize{20}{24} \selectfont \@titulo \par}
		\vspace{0.3cm}
		{\fontsize{14}{16}\itshape \selectfont \@title \par}
		\fi
		\noindent \par    
		{\setlength{\tabcolsep}{0in}
			\if@isblind
			\iflang@eng
			{\fontsize{12}{14} \selectfont Version for reviewers.}
			\fi
			\iflang@por
			{\fontsize{12}{14} \selectfont Versão para revisores.}
			\fi
			\else        
			\begin{tabular}[c]{c}%
				{\@author}
			\end{tabular}
			\fi
			%\vspace{0.1cm}
			{%\setstretch{0.85}
				\iflang@por
				{\fontsize{8}{10} \selectfont Data de recebimento do manuscrito: \@receptiondate}
				{\fontsize{8}{10} \selectfont Data de aceitação do manuscrito: \@acceptancedate}
				{\fontsize{8}{10} \selectfont Data de publicação: \@publicationdate}
				\fi
		}}%
\end{center}}% end of \parbox
%\vspace{0.3cm}
\noindent \par    
\vspace{0.4cm}
\iflang@eng
\noindent {\fontsize{9}{12} \selectfont {\bfseries{Abstract}}---\@englishabstract} \par
\vspace{0.3cm}
\noindent {\fontsize{9}{12} \selectfont {\bfseries{Keywords}}---\@englishkeywords} \par
\fi
\vspace{0.4cm}
\iflang@eng
\noindent {\fontsize{9}{12} \selectfont {\bfseries{Intisari}}---\@intisari} \par
\vspace{0.3cm}
\noindent {\fontsize{9}{12} \selectfont {\bfseries{Kata Kunci}}---\@katakunci} \par 
\vspace{0.5cm}
\fi

\iflang@por
\noindent {\fontsize{9}{12} \selectfont {\bfseries{Resumo}}---\@portugueseabstract} \par
\vspace{0.3cm}
\noindent {\fontsize{9}{12} \selectfont {\bfseries{Palavras-chave}}---\@portuguesekeywords} \par
\vspace{0.3cm}
\noindent {\fontsize{9}{12}\itshape \selectfont {\bfseries{Abstract}}---\@englishabstract} \par
\vspace{0.3cm}
\noindent {\fontsize{9}{12}\itshape \selectfont {\bfseries{Keywords}}---\@englishkeywords} \par
\noindent {\fontsize{9}{12}\itshape \selectfont {\bfseries{Abstrak}}---\@abstrak} \par
\vspace{0.3cm}
\noindent {\fontsize{9}{12}\itshape \selectfont {\bfseries{Kata Kunci}}---\@katakunci} \par
\fi
\vspace{0.2cm}
\noindent
\twocolumn
\endgroup
\vspace{0.5cm}
} % end of \@maketitle

%%% Header and footer settings
\usepackage{fancyhdr}
\pagestyle{fancy}
\renewcommand{\headrulewidth}{1pt}
\renewcommand{\footrulewidth}{1pt}
\fancyhead[LO]{{\fontsize{10}{10} \selectfont Jurnal Listrik, Instrumentasi, dan Elektronika Terapan (JuLIET), Vol.\@thevolume, No.~\@thenumber, \@themonth~\@theyear}}
\fancyhead[CO]{ }
\fancyhead[RO]{ \thepage  }
\fancyhead[LE]{ \thepage  }
%\fancyhead[CE]{{\fontsize{7}{10} \selectfont \MakeUppercase{\@theshorttitle}}}
%\fancyhead[RE]{{\fontsize{7}{10} \selectfont \authorheader}}
\fancyhead[RE]{{\fontsize{10}{10} \selectfont Jurnal Listrik, Instrumentasi, dan Elektronika Terapan (JuLIET), Vol.\@thevolume, No.~\@thenumber, \@themonth~\@theyear}}
\fancyfoot[LO,RE]{ \nomorterbit }
\fancyfoot[CO,CE]{ }
\fancyfoot[RO]{ }
%\fancyfoot[RO,RE]{ }




% Section Format Settings
\renewcommand{\@seccntformat}[1]{\csname the#1\endcsname.~}

\renewcommand*{\thesection}{\Roman{section}}
\renewcommand{\section}{\@startsection{section}{1}{0mm}%
{-12pt}%
{6pt}%
{\setlength\parindent{0em} \fontsize{12}{14} \selectfont \bfseries\textsc}}%
\renewcommand \thesubsection{\Alph{subsection}}
\renewcommand{\subsection}{\@startsection{subsection}{2}{0mm}%
{-12pt}%
{6pt}%
{\setlength\parindent{0em} \fontsize{11}{13} \selectfont \textit}}%
\renewcommand \thesubsubsection{\arabic{subsubsection}}
\renewcommand{\subsubsection}{\@startsection{subsubsection}{3}{0mm}%
{-12pt}%
{6pt}%
{\setlength\parindent{0em} \fontsize{11}{13} \selectfont \textit}}

% Set bibliography style
\usepackage{cite}
\bibliographystyle{IEEETran}

% Definitions for capital letter
\newcommand{\firstword}[2]{\lettrine[findent=2pt]{\textbf{#1}}{}#2 }

\if@isblind
\makeatletter
\AtBeginDocument{
\hypersetup{
	pdfinfo={
		Title={\@title},
		Author={AUTHOR},
		Keywords={\@englishkeywords},
		Producer={AJCEAM/UFT},
		Subject={\@englishabstract}
	}
}
}
\makeatother
\else
\makeatletter
\AtBeginDocument{
\hypersetup{
	pdfinfo={
		Title={\@title},
		Author={\@thefirstauthor},
		Keywords={\@englishkeywords},
		Producer={AJCEAM/UFT},
		Subject={\@englishabstract}
	}
}
}
\makeatother
\fi