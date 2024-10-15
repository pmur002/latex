\name{TeXengine}
\alias{TeXengine}
\alias{registerEngine}
\title{
  Define a TeX engine.
}
\description{
  Define and register a TeX engine for authoring, typesetting,
  and rendering LaTeX documents.
}
\usage{
TeXengine(name,
          command,
          options=NULL,
          buildGrobs,
          preamble="",
          dviSuffix=".dvi")
registerEngine(engine)
}
\arguments{
  \item{name}{Character name for the engine.}
  \item{command}{Command used to typeset LaTeX documents and produce DVI
    files.}
  \item{options}{Character vector of options to \code{command}.}
  \item{buildGrobs}{Function to generate grob tree from DVI object for
    rendering.}
  \item{preamble}{Preamble for authoring LaTeX documents.}
  \item{dviSuffix}{Suffix for files produced by typesetting LaTeX
    documents.}
  \item{engine}{A \code{"TeXengine"} object.}
}
\value{
  \code{TeXengine()} returns a \code{"TeXengine"} object.
}
\author{
  Paul Murrell
}
\keyword{ dplot }

