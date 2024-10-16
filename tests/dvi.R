
library(dvi)
library(latex)

## XeTeX engine is supplied (if available)
dviXeTeX <- readDVI(system.file("DVI", "test-xetex.xdv", package="dvi"))

## Font file paths based on my machine
if (Sys.getenv("USER") == "pmur002") {
    
    ## Fall back to dummy fontLib
    ## (glyph positioning is compromised)
    tools::assertWarning(grid.dvi(dviXeTeX))

    if (require("ttx")) {
        ## Glyph positioning should be fine
        TTX <- FontLibrary(ttx::ttxGlyphWidth,
                           ttx::ttxGlyphHeight,
                           ttx::ttxGlyphBounds)
        grid.dvi(dviXeTeX, fontLib=TTX)
    }
    
}
