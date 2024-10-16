
library(grid)
library(dvi)
library(latex)

## Existing DVI 
dviXeTeX <- readDVI(system.file("DVI", "test-xetex.xdv", package="dvi"))

## Font file paths based on my machine
if (Sys.getenv("USER") == "pmur002") {
    
    ## Fall back to dummy fontLib
    ## (glyph positioning is compromised)
    grid.newpage()
    tools::assertWarning(grid.dvi(dviXeTeX))

    if (require("ttx")) {
        ## Glyph positioning should be fine
        TTX <- FontLibrary(ttx::ttxGlyphWidth,
                           ttx::ttxGlyphHeight,
                           ttx::ttxGlyphBounds)
        grid.newpage()
        grid.dvi(dviXeTeX, fontLib=TTX)
    }
    
}

## Generate DVI
if (latex:::canTypeset()) {
    tex <- author("This is a test: $x - \\mu$")
    dviFile <- typeset(tex)
    dvi <- readDVI(dviFile)
    grid.newpage()
    grid.dvi(dvi)

    if (require("ttx")) {
        grid.newpage()
        grid.dvi(dvi, fontLib=TTX)
    }
}

