
## Generate LaTeX file from TeX string

author <- function(tex,
                   engine=getOption("latex.engine"),
                   packages=NULL,
                   texFile=NULL) {
    engine <- getEngine(engine)
    pkgs <- resolvePackages(packages)
    texDoc <- c("\\documentclass{standalone}",
                engine$preamble,
                packagePreamble(pkgs),
                "\\begin{document}",
                packagePrefix(pkgs),
                tex,
                packageSuffix(pkgs),
                "\\end{document}")
    class(texDoc) <- "TeXdocument"
    if (!is.null(texFile)) {
        writeLines(texDoc, texFile)
        class(texFile) <- "TeXfile"
        attr(texDoc, "texFile") <- texFile
    }
    invisible(texDoc)
}
