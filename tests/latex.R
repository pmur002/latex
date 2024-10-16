
library(grid)
library(dvi)
library(latex)

if (latex:::canTypeset()) {
    ## Fall back to dummy fontLib
    ## (glyph positioning is compromised)
    grid.newpage()
    tools::assertWarning(grid.latex("This is a test: $x - \\mu$"))

    if (require("ttx")) {
        ## Glyph positioning should be fine
        TTX <- FontLibrary(ttx::ttxGlyphWidth,
                           ttx::ttxGlyphHeight,
                           ttx::ttxGlyphBounds)
        grid.newpage()
        grid.latex("This is a test: $x - \\mu$", fontLib=TTX)
    }
}

