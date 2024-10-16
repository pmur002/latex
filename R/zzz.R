
## Define and register dummy TeX engine
dummyEngine <- TeXengine(name="dummy",
                         command=NULL)
registerEngine(dummyEngine)

.onLoad <- function(libname, pkgname) {
    ## Define and register XeTeX engine 
    initXeTeX()
    if (xetexAvailable()) {
        XeTeXengine <- TeXengine(name="XeTeX",
                                 command="xelatex",
                                 options="--no-pdf",
                                 preamble=xelatexPreamble,
                                 dviSuffix=".xdv")   
        registerEngine(XeTeXengine)
    }
}
