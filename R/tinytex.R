
initTinyTeX <- function() {
    useTinyTeX <- getOption("latex.tinytex")
    haveTinyTeX <- nchar(system.file(package="tinytex"))
    if (haveTinyTeX) {
        version <- packageVersion("tinytex")
        set("tinytexVersion", version)
    }
    if (is.null(useTinyTeX)) {
        ## On Windows, use TinyTeX if available 
        options("latex.tinytex"=FALSE)
        if (haveTinyTeX && .Platform$OS.type == "windows") {
                options("latex.tinytex"=TRUE)
        }
    }
}

tinytexVersion <- function() {
    get("texVersion")
}

tinytexAvailable <- function() {
    !is.null(texVersion())
}
