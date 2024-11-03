\name{TeXengine}
\alias{TeXengine}
\alias{registerEngine}
\title{
  Define a TeX Engine.
}
\description{
  Define and register a TeX engine for authoring, typesetting,
  and rendering LaTeX documents.
}
\usage{
TeXengine(name,
          version,
          command,
          isEngine,
          options=NULL,
          preamble="",
          dviSuffix=".dvi")
registerEngine(engine)
}
\arguments{
  \item{name}{Character name for the engine.}
  \item{version}{Character version for the engine.}
  \item{command}{Command used to typeset LaTeX documents and produce DVI
    files.}
  \item{isEngine}{Function that accepts \code{"DVI"} object and returns
    boolean indicating whether the engine generated the DVI.}
  \item{options}{Character vector of options to \code{command}.}
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

