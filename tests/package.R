
library(grid)
library(latex)

## Make debugging information available
options(ttx.quiet=FALSE, tinytex.verbose=TRUE, latex.quiet=FALSE)

fontpath <- system.file("fonts", "Montserrat", "static", package="grDevices")

tex <- paste0("\\setmainfont{Montserrat-Medium.ttf}",
              "[Path=", fontpath, "/]",
              "This is a test")

if (latex:::canTypeset()) {
    if (require("ttx")) {
        TTX <- FontLibrary(ttx::ttxGlyphWidth,
                           ttx::ttxGlyphHeight,
                           ttx::ttxGlyphBounds)
        options(latex.fontLib=TTX)
        
        ## Package as LaTeXpackage object
        grid.newpage()
        grid.latex(tex, packages=fontspecPackage())

        ## Package as package alias
        grid.newpage()
        grid.latex(tex, packages="fontspec")
        
        ## TODO:
        ## Package in author, but not in render
        ## Package in render, but not in author
        ## ...
    }
}

