
## Null TeX engine that CANNOT be used for typesetting
nullEngine <- TeXengine(name="null",
                        version=packageVersion("latex"),
                        command=NULL,
                        isEngine=function(dvi) FALSE)
registerEngine(nullEngine)

.onLoad <- function(libname, pkgname) {
    options(latex.engine=nullEngine)
    ## Check for {tinytex}
    initTinyTeX()
    ## Define and register XeTeX engine 
    initXeTeX()
    if (xetexAvailable()) {
        XeTeXengine <- TeXengine(name="XeTeX",
                                 version=xetexVersion(),
                                 command="xelatex",
                                 isEngine=isXeTeX,
                                 options="--no-pdf",
                                 preamble=xelatexPreamble,
                                 dviSuffix=".xdv")   
        registerEngine(XeTeXengine)
        options(latex.engine=XeTeXengine)
    }
    ## Define and register packages
    registerPackage(fontspecPackage())
}

.onAttach <- function(libname, pkgname) {
    if (tinytexAvailable()) {
        packageStartupMessage(paste0("  tinytex:  ", tinytexVersion()))
    } else {
        packageStartupMessage("  tinytex:  not installed")
    }
    if (xetexAvailable()) {
        packageStartupMessage(paste0("    xetex:  ", xetexVersion()))
    } else {
        packageStartupMessage("    xetex:  not found")
        packageStartupMessage(paste("         : ",
                                    "The XeTeX engine is NOT available."))
    }
    if (!(any(sapply(get("engines"), canTypeset)) ||
          tinytexAvailable())) {
        packageStartupMessage(paste("         : ",
                                    "Typesetting is NOT available."))
    }
}
