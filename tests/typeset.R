
library(latex)

## Make debugging information available
options(ttx.quiet=FALSE, tinytex.verbose=TRUE, latex.quiet=FALSE)

if (latex:::canTypeset()) {
    ## author() engine defaults 
    ## Typeset engine taken from author() engine
    tex <- author("This is a test: $x - \\mu$")
    typeset(tex)

    if (latex:::xetexAvailable()) {
        ## Explicit typeset engine that matches author() engine
        tex <- author("test", engine="xetex")
        typeset(tex, engine="xetex")

        ## Explicit typeset engine that does NOT match author() engine
        tex <- author("test", engine="null")
        tools::assertWarning(typeset(tex, engine="xetex"))
        
        ## Manual TeX (so author engine unknown)
        ## Typeset engine defaults
        tex <- readLines(system.file("TeX", "manual.tex", package="latex"))
        tools::assertWarning(typeset(tex))

        ## Manual TeX (so author engine unknown)
        ## AND explicit typeset engine 
        tex <- readLines(system.file("TeX", "manual.tex", package="latex"))
        tools::assertWarning(typeset(tex, engine="xetex"))
    }
}
