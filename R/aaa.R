
## Parsing DVI requires maintaining various state parameters
## like current location and current font

latex_state <- new.env()

get <- function(name) {
    base::get0(name, envir=latex_state, inherits=FALSE)
}

mget <- function(names) {
    base::mget(names, envir=latex_state, inherits=FALSE)
}

set <- function(name, value) {
    assign(name, value, envir=latex_state)
}

## Signatures to put in TeX code when authoring and DVI output when typesetting
engineCommentHeader <- "R package latex_"
engineCommentName <- "engine name: "
engineCommentVersion <- "engine version: "
engineCommentSep <- "; "

buildSignature <- function(engine) {
    paste0(engineCommentHeader, packageVersion("latex"), engineCommentSep,
           engineCommentName, engine$name, engineCommentSep,
           engineCommentVersion, engine$version)
}

splitSignature <- function(sig) {
    strsplit(sig, engineCommentSep)[[1]]
}
