
library(grid)
library(latex)

## Make debugging information available
options(tinytex.verbose=TRUE, latex.quiet=FALSE)

fontpath <- system.file("fonts", "Montserrat", "static", package="grDevices")

tex <- paste0("\\setmainfont{Montserrat-Medium.ttf}",
              "[Path=", gsub("~", "\\\\string~", fontpath), "/]\n",
              "This is a test")

if (latex:::canTypeset()) {

    if (.Platform$OS.type == "windows") {
        ## For testing on github Windows runners, avoid tmp dir
        ## for files that a TeX engine will run on
        texFile <- "test-package.tex"
    } else {
        texFile <- NULL
    }
    
    if (require("ttx")) {
        options(ttx.quiet=FALSE)
        TTX <- FontLibrary(ttx::ttxGlyphWidth,
                           ttx::ttxGlyphHeight,
                           ttx::ttxGlyphBounds)
        options(latex.fontLib=TTX)
        
        ## Package as LaTeXpackage object
        grid.newpage()
        grid.latex(tex, packages=fontspecPackage(), texFile=texFile)

        ## Package as package alias
        grid.newpage()
        grid.latex(tex, packages="fontspec", texFile=texFile)
        
        ## TODO:
        ## Package in author, but not in render
        ## Package in render, but not in author
        ## ...
    }
}

