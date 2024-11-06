
library(grid)
library(latex)

## Make debugging information available
options(tinytex.verbose=TRUE, latex.quiet=FALSE)

fontpath <- system.file("fonts", "Montserrat", "static", package="grDevices")

tex <- paste0("\\setmainfont{Montserrat-Medium.ttf}",
              "[Path=", gsub("~", "\\string~", fontpath), "/]\n",
              "This is a test")

if (latex:::canTypeset()) {
    if (.Platform$OS.type == "windows") {
        ## For testing on github Windows runners, avoid tmp dir
        ## for files that a TeX engine will run on
        texFile <- "test-fontspec.tex"
    } else {
        texFile <- NULL
    }

    ## Fall back to dummy fontLib
    ## (glyph positioning is compromised)
    grid.newpage()
    grid.latex(tex, packages=fontspecPackage(), texFile=texFile)

    if (require("ttx")) {
        ## Glyph positioning should be fine
        TTX <- FontLibrary(ttx::ttxGlyphWidth,
                           ttx::ttxGlyphHeight,
                           ttx::ttxGlyphBounds)
        grid.newpage()
        grid.latex(tex, packages=fontspecPackage(), fontLib=TTX,
                   texFile=texFile)
    }
}
        
