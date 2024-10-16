\name{TeX conversion}
\alias{fromTeX}
\alias{toTeX}
\title{
  Convert to/from TeX Coordinates
}
\description{
  Convert from TeX coordinates to millimetres or from a \pkg{grid}
  unit to TeX coordinates.
}
\usage{
fromTeX(x, pre)
toTeX(unit, pre)
}
\arguments{
  \item{x}{Numeric value to convert.}
  \item{unit}{\pkg{grid} unit to convert.}
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

