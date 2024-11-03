
## Generate DVI from TeX string

canTypeset <- function(engine=getOption("latex.engine")) {
    !is.null(engine$command)
}

typeset <- function(tex,
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
        sig <- buildSignature(engine)
        options <- c(engine$options,
                     paste0('--output-comment="', sig, '"'),
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
typeset.TeXdocument <- function(tex,
                                engine=NULL,
                                tinytex=getOption("latex.tinytex"),
                                texFile=NULL,
                                ...) {
    engine <- resolveEngine(tex, engine)
    if (is.null(texFile)) {
        texFile <- tempfile(fileext=".tex")
    }
    texDir <- dirname(texFile)
    dviFile <- paste0(gsub("[.]tex", "", texFile), engine$dviSuffix)
    writeLines(tex, texFile)
    latex(texFile, texDir, engine, tinytex)
    attr(dviFile, "engine") <- engine
    class(dviFile) <- "DVIfile"
    invisible(dviFile)    
}

## 'x' is the name of a file containing TeX code
typeset.character <- function(tex,
                              engine=NULL,
                              tinytex=getOption("latex.tinytex"),
                              ## Did R generate the TeX file? (assume no)
                              sig=FALSE, 
                              ...) {
    if (length(tex) != 1) 
        stop("'tex' must be the name of exactly one TeX file")
    engine <- resolveEngine(readLines(tex), engine)
    texDir <- dirname(tex)
    dviFile <- paste0(gsub("[.]tex", "", tex), engine$dviSuffix)
    latex(tex, texDir, engine, tinytex, sig=sig)
    attr(dviFile, "engine") <- engine
    class(dviFile) <- "DVIfile"
    invisible(dviFile)
}
                    
## What engine was used to typeset the TeX code?
typesetEngine <- function(x) {
    UseMethod("typesetEngine")
}

typesetEngine.DVIfile <- function(x) {
    attr(x, "engine")
}

typesetEngine.DVI <- function(x) {
    commentStr <- commentString(x)
    commentLine <- commentLine(commentStr)
    if (length(commentLine)) {
        ## If latex::typeset() produced the DVI then engine should be
        ## in comment of DVI preamble
        sig <- splitSignature(commentStr)
        engineName <- gsub(engineCommentName, "", sig[2], fixed=TRUE)
        engineVersion <- gsub(engineCommentVersion, "", sig[3], fixed=TRUE)
        getEngine(engineName)
    } else {
        warning("Guessing typesetting engine from DVI pre op comment")
        ## Try to guess from DVI pre op comment
        engines <- get("engines")
        isEngine <- sapply(engines, function(y) y$isEngine(x))
        if (any(isEngine)) {
            if (sum(isEngine) > 1) {
                warning(paste0("More than one engine identified ",
                               "(", paste(sapply(engines[isEngine],
                                                 function(x) x$name),
                                          collapse=", "), ");",
                               "using the first match ",
                               "(", engines[[which(isEngine)[1]]]$name, ")"))
            }
            engines[[which(isEngine)[1]]]
        } else {
            warning(paste0("Unable to identify engine from DVI pre op comment ",
                           "(", commentStr, ");",
                           "falling back to null engine"))
            engines[["null"]]
        }
    }    
}
