
## Do nothing for now
dummyGrobs <- function(x) {
    textGrob("I tried rendering with the dummy engine\nand all I got was this lousy text.",
             x$x, x$y, hjust=x$hjust, vjust=x$vjust)
}

## Define (and register) dummy TeX engine
dummyEngine <- TeXengine(name="dummy",
                         command=NULL,
                         buildGrobs=dummyGrobs)

registerEngine(dummyEngine)
