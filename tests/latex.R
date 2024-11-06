
library(grid)
library(dvi)
library(latex)

## Make debugging information available
options(tinytex.verbose=TRUE, latex.quiet=FALSE)

if (latex:::canTypeset()) {
    
    if (.Platform$OS.type == "windows") {
        ## For testing on github Windows runners, avoid tmp dir
        ## for files that a TeX engine will run on
        texFile <- "test.tex"
    } else {
        texFile <- NULL
    }
    
    ## Fall back to dummy fontLib
    ## (glyph positioning is compromised)
    grid.newpage()
    tools::assertWarning(grid.latex("This is a test: $x - \\mu$",
                                    texFile=texFile))
    
    if (require("ttx")) {
        options(ttx.quiet=FALSE)        
        ## Glyph positioning should be fine
        TTX <- FontLibrary(ttx::ttxGlyphWidth,
                           ttx::ttxGlyphHeight,
                           ttx::ttxGlyphBounds)
        grid.newpage()
        grid.latex("This is a test: $x - \\mu$", fontLib=TTX, texFile=texFile)
    }
}

