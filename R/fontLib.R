
## Create a "font library", which is a list of functions for
## querying fonts and glyphs

FontLibrary <- function(glyphWidth,
                        glyphHeight,
                        glyphBounds) {
    fontLib <- list(glyphWidth=glyphWidth,
                    glyphHeight=glyphHeight,
                    glyphBounds=glyphBounds)
    class(fontLib) <- "FontLibrary"
    fontLib
}
                      
