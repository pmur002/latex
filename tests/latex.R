
library(dvi)
library(latex)

dvi <- readDVI(system.file("DVI", "test-xe.xdv", package="dvi"))

## Font file paths based on my machine
if (Sys.getenv("USER") == "pmur002") {
    
    ## Fall back to dummy engine AND to dummy fontLib
    ## (glyph positioning is compromised)
    tools::assertWarning(grid.dvi(dvi))

    if (require("ttx")) {
        ## Just fall back to dummy engine
        ## (glyph positioning should be fine)
        TTX <- FontLibrary(ttx::ttxGlyphWidth,
                           ttx::ttxGlyphHeight,
                           ttx::ttxGlyphBounds)
        tools::assertWarning(grid.dvi(dvi, fontLib=TTX))
    }
    
}
