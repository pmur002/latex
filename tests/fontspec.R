
library(grid)
library(latex)

## Make debugging information available
options(ttx.quiet=FALSE, tinytex.verbose=TRUE, latex.quiet=FALSE)

fontpath <- system.file("fonts", "Montserrat", "static", package="grDevices")

tex <- paste0("\\setmainfont{Montserrat-Medium.ttf}",
              "[Path=", fontpath, "/]",
              "This is a test")

if (latex:::canTypeset()) {
    ## Fall back to dummy fontLib
    ## (glyph positioning is compromised)
    grid.newpage()
    grid.latex(tex, packages=fontspecPackage())

    if (require("ttx")) {
        ## Glyph positioning should be fine
        TTX <- FontLibrary(ttx::ttxGlyphWidth,
                           ttx::ttxGlyphHeight,
                           ttx::ttxGlyphBounds)
        grid.newpage()
        grid.latex(tex, packages=fontspecPackage(), fontLib=TTX)
    }
}
        
