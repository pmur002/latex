
## Generate LaTeX file from TeX string

engineComment <- function(engine) {
    paste0("%% ", buildSignature(engine))
}

## Was the TeX code authored by this package?
commentLine <- function(tex) {
    grep(engineCommentHeader, tex, fixed=TRUE, value=TRUE)
}

author <- function(tex,
                   engine=getOption("latex.engine"),
                   packages=NULL) {
    engine <- getEngine(engine)
    pkgs <- resolvePackages(packages)
    texDoc <- c("\\documentclass{standalone}",
                engine$preamble,
                packagePreamble(pkgs),
                "\\begin{document}",
                ## Record engine used for authoring
                engineComment(engine),
                packagePrefix(pkgs),
                tex,
                packageSuffix(pkgs),
                "\\end{document}")
    attr(texDoc, "engine") <- engine
    class(texDoc) <- "TeXdocument"
    texDoc
}

## What engine was used to author the TeX code?
authorEngine <- function(tex) {
    UseMethod("authorEngine")
}

authorEngine.character <- function(tex) {
    commentLine <- commentLine(tex)
    if (length(commentLine)) {
        sig <- splitSignature(tex[commentLine])
        engineName <- gsub(engineCommentName, "", sig[2], fixed=TRUE)
        engineVersion <- gsub(engineCommentVersion, "", sig[3], fixed=TRUE)
        getEngine(engineName)
    } else {
        NULL
    }
}

authorEngine.TeXdocument <- function(tex) {
    attr(tex, "engine")
}

