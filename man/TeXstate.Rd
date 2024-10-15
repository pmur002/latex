\name{TeXstate}
\alias{TeXstate}
\alias{TeXget}
\alias{TeXset}
\title{
  Create TeX State
}
\description{
  Create a TeX state and set/get values within that state.
}
\usage{
TeXstate()
TeXget(name, state)
TeXset(name, value, state)
}
\arguments{
  \item{name}{Character name for a state value.}
  \item{value}{R object for state value.}
  \item{state}{A \code{"TeXstate"} object.}
}
\value{
  \code{TeXstate()} returns a \code{"TeXstate"} object.
}
\author{
  Paul Murrell
}
\keyword{ dplot }

