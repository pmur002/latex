
library(grid)
library(dvi)
library(latex)

## Make debugging information available
options(tinytex.verbose=TRUE, latex.quiet=FALSE)

## Existing DVI (so engine unknown AND packages unknown)
dviXeTeX <- readDVI(system.file("DVI", "test-xetex.xdv", package="dvi"))

## Font file paths based on my machine
if (Sys.getenv("USER") == "pmur002") {
    
    ## Fall back to dummy fontLib
    ## (glyph positioning is compromised)
    grid.newpage()
    tools::assertWarning(grid.dvi(dviXeTeX))

    if (require("ttx")) {
        options(ttx.quiet=FALSE)
        ## Glyph positioning should be fine
        TTX <- FontLibrary(ttx::ttxGlyphWidth,
                           ttx::ttxGlyphHeight,
                           ttx::ttxGlyphBounds)
        grid.newpage()
        ## Still warn about guessing DVI engine
        tools::assertWarning(grid.dvi(dviXeTeX, fontLib=TTX))
    }
    
}

## Generate DVI
if (latex:::canTypeset()) {
    ## Fall back to dummy fontLib
    ## (glyph positioning is compromised)
    tex <- author("This is a test: $x - \\mu$")
    if (.Platform$OS.type == "windows") {
        ## For testing on github Windows runners, avoid tmp dir
        ## for files that a TeX engine will run on
        dviFile <- typeset(tex, texFile="test.tex")
    } else {
        dviFile <- typeset(tex)
    }
    dvi <- readDVI(dviFile)
    grid.newpage()
    tools::assertWarning(grid.dvi(dvi))
}


if (latex:::canTypeset()) {
    if (require("ttx")) {
        options(ttx.quiet=FALSE)
        if (.Platform$OS.type == "windows") {
            ## For testing on github Windows runners, avoid tmp dir
            ## for files that 'ttx' will run on
            cacheDir <- file.path(getwd(), "TTXfonts")
            if (!dir.exists(cacheDir)) {
                dir.create(cacheDir)
            }
            options(ttx.cacheDir=cacheDir)
        }
        if (!exists("TTX")) {
            TTX <- FontLibrary(ttx::ttxGlyphWidth,
                               ttx::ttxGlyphHeight,
                               ttx::ttxGlyphBounds)
        }
        ## No warnings!
        grid.newpage()
        grid.dvi(dvi, fontLib=TTX)
    }
}

if (latex:::canTypeset()) {
    if (latex:::xetexAvailable()) {
        ## Explicit render engine that does NOT match typeset() engine
        tex <- author("This is a test: $x - \\mu$", engine="xetex")
        dviFile <- typeset(tex, engine="xetex", texFile="test.tex")
        dvi <- readDVI(dviFile)
        grid.newpage()
            tools::assertWarning(grid.dvi(dvi, engine="null", fontLib=TTX))
    }
}

