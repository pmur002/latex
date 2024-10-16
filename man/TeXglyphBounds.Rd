\name{TeX glyph metrics}
\alias{TeXglyphWidth}
\alias{TeXglyphHeight}
\alias{TeXglyphBounds}
\title{
  Calculate TeX Glyph Metrics
}
\description{
  Calculate glyph metrics in TeX coordinates.
}
\usage{
TeXglyphWidth(index, file, size, fontLib, pre)
TeXglyphHeight(index, file, size, fontLib, pre)
TeXglyphBounds(index, file, size, fontLib, pre)
}
\arguments{
  \item{index}{A glyph index.}
  \item{file}{A font file.}
  \item{size}{The font size (pts).}
  \item{fontLib}{A \code{"FontLibrary"}.}
  \item{pre}{A named list with components \code{scale},
    \code{num}, \code{den}, and \code{mag} (values from a DVI preamble).}
}
\value{
  A numeric vector.
}
\author{
  Paul Murrell
}
\keyword{ dplot }

