
initTeX <- function() {
    latex <- Sys.which("latex")
    if (nchar(latex) > 0) {
        versText <- system("latex --version", intern=TRUE)
        version <- versText[1]
        set("latexVersion", version)        
    }
}

texVersion <- function() {
    get("texVersion")
}

texAvailable <- function() {
    !is.null(texVersion())
}

################################################################################
## TeX state for keeping track of values during DVI sweep

TeXstate <- function() {
    state <- new.env()
    class(state) <- "TeXstate"
    state
}

TeXget <- function(name, state) {
    base::get0(name, envir=state, inherits=FALSE)
}

TeXmget <- function(names, state) {
    base::mget(names, envir=state, inherits=FALSE)
}

TeXset <- function(name, value, state) {
    assign(name, value, envir=state)
}

