
initTeXstate <- function() {
    state <- TeXstate()
    TeXset("scale", 1, state)
    ## Extra slot for dummy font
    TeXset("fonts", vector("list", 256), state)
    TeXset("glyphs", list(), state)
    TeXset("dir", 0, state)
    state
}

makeContent.DVIgrob <- function(x, ...) {
    state <- initTeXstate()
    TeXset("packages", x$packages, state)
    TeXset("fontLib", x$fontLib, state)
    TeXset("engine", x$engine, state)
    
    ## Generate objs from DVI
    invisible(lapply(x$dvi, DVItoObj, state))

    textGrob("Expect more ...")
}

################################################################################
## User API

dviGrob <- function(dvi, ...) {
    UseMethod("dviGrob")
}

dviGrob.DVI <- function(dvi,
                        x=0.5, y=0.5,
                        default.units="npc",
                        hjust="centre", vjust="centre",
                        engine=NULL,
                        fontLib=NULL,
                        packages=NULL,
                        ...,
                        name="DVIgrob",
                        gp=gpar(),
                        vp=NULL) {
    if (!(is.null(engine) || inherits(engine, "TeXengine")))
        stop("Invalid TeX engine")
    if (!(is.null(fontLib) || inherits(fontLib, "FontLibrary")))
        stop("Invalid Font Library")
    if (!is.unit(x))
        x <- unit(x, default.units)
    if (!is.unit(y))
        y <- unit(y, default.units)
    eng <- resolveEngine(dvi, engine)
    lib <- resolveFontLib(fontLib)
    pkgs <- resolvePackages(packages)
    gTree(dvi=dvi, x=x, y=y, hjust=hjust, vjust=vjust,
          engine=eng, fontLib=lib, packages=pkgs,
          gp=gp, name=name, vp=vp,
          cl="DVIgrob")
}

dviGrob.character <- function(dvi, ...) {
    dviGrob(readDVI(dvi), ...)
}

grid.dvi <- function(...) {
    grid.draw(dviGrob(...))
}

