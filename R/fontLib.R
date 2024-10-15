
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

metricUnits <- function(x) {
    attr(x, "unitsPerEm")
}

glyphWidth <- function(index, file, size, fontLib) {
    width <- fontLib$glyphWidth(index, file)
    unitsPerEm <- metricUnits(width)
    ## round() to get whole number metrix (at 1000 scale)
    ## floor() to match what PDF_StrWidthUTF8() does
    cex <- 1
    widthPts <- floor(size + .5)*cex*
        (round(width/(unitsPerEm/1000)))/1000
    toTeX(unit(widthPts, "bigpts"))
}

glyphHeight <- function(index, file, size, fontLib) {
    height <- fontLib$glyphHeight(index, file)
    unitsPerEm <- metricUnits(height)
    ## round() to get whole number metrix (at 1000 scale)
    ## floor() to match what PDF_StrWidthUTF8() does
    cex <- 1
    heightPts <- floor(size + .5)*cex*
        (round(height/(unitsPerEm/1000)))/1000
    toTeX(unit(heightPts, "bigpts"))
}

glyphBounds <- function(index, file, size, fontLib) {
    bounds <- fontLib$glyphBounds(index, file)
    unitsPerEm <- metricUnits(bounds)
    ## round() to get whole number metrix (at 1000 scale)
    ## floor() to match what PDF_StrWidthUTF8() does
    cex <- 1
    boundsPts <- floor(size + .5)*cex*
        (round(bounds/(unitsPerEm/1000)))/1000
    toTeX(unit(boundsPts, "bigpts"))
}
