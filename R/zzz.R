
## Dummy TeX engine that CANNOT be used for typesetting
dummyEngine <- TeXengine(name="dummy",
                         command=NULL)
registerEngine(dummyEngine)

.onLoad <- function(libname, pkgname) {
    options(latex.engine=dummyEngine)
    ## Check for TeX
    initTeX()
    ## Check for {tinytex}
    initTinyTeX()
    if (texAvailable() || tinytexAvailable()) {
        ## Generic LaTeX engine that will use whatever engine 'latex' uses
        LaTeXengine <- TeXengine(name="LaTeX",
                                 command="latex",
                                 options="--output-format=dvi",
                                 preamble="\\usepackage{unicode-math}",
                                 dviSuffix=".dvi")
        registerEngine(LaTeXengine)
        options(latex.engine=LaTeXengine)
    } 
    ## Define and register XeTeX engine 
    initXeTeX()
    if (xetexAvailable()) {
        XeTeXengine <- TeXengine(name="XeTeX",
                                 command="xelatex",
                                 options="--no-pdf",
                                 preamble=xelatexPreamble,
                                 dviSuffix=".xdv")   
        registerEngine(XeTeXengine)
        options(latex.engine=XeTeXengine)
    }
}

.onAttach <- function(libname, pkgname) {
    if (texAvailable()) {
        packageStartupMessage(paste0("    latex:  ", texVersion()))
    } else {
        packageStartupMessage("    latex:  not found")
    }
    if (tinytexAvailable()) {
        packageStartupMessage(paste0("  tinytex:  ", tinytexVersion()))
    } else {
        packageStartupMessage("  tinytex:  not installed")
    }
    if (!(texAvailable() || tinytexAvailable())) {
        packageStartupMessage(paste("         : ",
                                    "Typesetting is NOT available."))
    }
    if (xetexAvailable()) {
        packageStartupMessage(paste0("  xelatex:  ", xetexVersion()))
    } else {
        packageStartupMessage("  xelatex:  not found")
        packageStartupMessage(paste("         : ",
                                    "The XeTeX engine is NOT available."))
    }
}
