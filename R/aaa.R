
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
commentHeader <- "R package latex_"
commentSep <- "; "
commentEngineName <- "engine name: "
commentEngineVersion <- "engine version: "
commentPackages <- "packages: "

buildSignature <- function(engine, packages) {
    paste0(commentHeader, packageVersion("latex"), commentSep,
           commentEngineName, engine$name, commentSep,
           commentEngineVersion, engine$version, commentSep,
           commentPackages, packages)
}

splitSignature <- function(sig) {
    strsplit(sig, commentSep)[[1]]
}

signatureEngine <- function(sig) {
    sig <- splitSignature(sig)
    list(name=gsub(commentEngineName, "", sig[2], fixed=TRUE),
         version=gsub(commentEngineVersion, "", sig[3], fixed=TRUE))
}

signaturePackages <- function(sig) {
    sig <- splitSignature(sig)
    gsub(commentPackages, "", sig[4], fixed=TRUE)
}
