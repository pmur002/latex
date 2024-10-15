
makeContent.DVIgrob <- function(x, ...) {
    x$engine$buildGrobs(x)
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
    pkgs <- resolvePackages(packages)
    gTree(dvi=dvi, x=x, y=y, hjust=hjust, vjust=vjust,
          engine=eng, fontLib=fontLib, packages=pkgs,
          gp=gp, name=name, vp=vp,
          cl="DVIgrob")
}

dviGrob.character <- function(dvi, ...) {
    dviGrob(readDVI(dvi), ...)
}

grid.dvi <- function(...) {
    grid.draw(dviGrob(...))
}

