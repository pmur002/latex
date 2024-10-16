
## Generate DVI from TeX string

canTypeset <- function(engine=getOption("latex.engine")) {
    !is.null(engine$command)
}

typeset <- function(x,
                    engine=getOption("latex.engine"),
                    tinytex=getOption("latex.tinytex"),
                    ...) {
    UseMethod("typeset")
}

latex <- function(file, dir, engine, tinytex, sig=TRUE) {
    engine <- getEngine(engine)
    if (!canTypeset(engine)) {
        stop(paste0("The ", engine$name,
                    " engine does not support typesetting"))
    }
    if (tinytex && !tinytexAvailable()) {
        stop("{tinytex} requested, but not available")
    }
    if (sig) {
        signature <- paste0(engine$name, " from R package latex_",
                            packageVersion("latex"))
        options <- c(engine$options,
                     paste0('--output-comment="', signature, '"'),
                     paste0("--output-directory=", dir))
    } else {
        options <- c(engine$options,
                     paste0("--output-directory=", dir))
    }
    if (tinytex) {
        ## Have to run TWICE, once to generate .pdf (that we do not need)
        ## and once to generate .dvi (that will only work if .pdf exists).
        ## Have to only try() because tinytex::latexmk() will only
        ## produce .dvi without error if engine="latex" (hard coded)
        ## (it will still generate .dvi with other engines, it will
        ##  just error out)
        tinytex::latexmk(file,
                         engine=engine$command)
        try(tinytex::latexmk(file,
                             engine=engine$command,
                             engine_args=options),
            silent=TRUE)
    } else {
        system(paste0(engine$command, " ",
                      paste(options, collapse=" "), " ", file))
    }
}

## 'x' is a "TeXdocument" from author()
typeset.TeXdocument <- function(x,
                                engine=getOption("latex.engine"),
                                tinytex=getOption("latex.tinytex"),
                                texFile=NULL,
                                ...) {
    if (is.null(texFile)) {
        texFile <- tempfile(fileext=".tex")
    }
    texDir <- dirname(texFile)
    dviFile <- paste0(gsub("[.]tex", "", texFile), engine$dviSuffix)
    writeLines(x, texFile)
    latex(texFile, texDir, engine, tinytex)
    invisible(dviFile)    
}

## 'x' is the name of a "TeXfile" from author()
typeset.TeXfile <- function(x,
                            engine=getOption("latex.engine"),
                            tinytex=getOption("latex.tinytex"),
                            ...) {
    texDir <- dirname(x)
    ## TeX file may not have .tex suffix
    dviFile <- paste0(gsub("[.]tex", "", x), engine$dviSuffix)
    latex(x, texDir, engine, tinytex)
    invisible(dviFile)
}
                    
## 'x' is the name of any file containing a TeX document
typeset.character <- function(x,
                              engine=getOption("latex.engine"),
                              tinytex=getOption("latex.tinytex"),
                              ## Did R generate the TeX file? (assume no)
                              latex=FALSE, 
                              ...) {
    texDir <- dirname(x)
    ## TeX file may not have .tex suffix
    dviFile <- paste0(gsub("[.]tex", "", x), engine$dviSuffix)
    latex(x, texDir, engine, tinytex, sig=latex)
    invisible(dviFile)
}
                    

