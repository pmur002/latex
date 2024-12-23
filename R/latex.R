
latexGrob <- function(tex,
                      x=0.5, y=0.5, default.units="npc",
                      hjust="centre", vjust="centre",
                      engine=getOption("latex.engine"),
                      fontLib=NULL,
                      packages=NULL,
                      tinytex=getOption("latex.tinytex"),
                      texFile=NULL,
                      ...,
                      name="LaTeXgrob",
                      gp=gpar(),
                      vp=NULL) {
    engine <- getEngine(engine)
    lib <- resolveFontLib(fontLib)
    pkgs <- resolvePackages(packages)
    texDoc <- author(tex, engine=engine, packages=pkgs)
    dviFile <- typeset(texDoc, engine=engine, tinytex=tinytex, texFile=texFile)
    dvi <- readDVI(dviFile)
    dviGrob(dvi,
            x=x, y=y, default.units=default.units,
            hjust=hjust, vjust=vjust,
            engine=engine, package=pkgs, fontLib=lib,
            ...,
            name=name, gp=gp, vp=vp)
}

grid.latex <- function(...) {
    grid.draw(latexGrob(...))
}
