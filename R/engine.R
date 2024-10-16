
set("engines", list())

## Create a TeX engine
TeXengine <- function(name,
                      command,
                      options=NULL,
                      preamble="",
                      dviSuffix=".dvi") {
    engine <- list(name=tolower(name),
                   command=command,
                   options=options,
                   preamble=preamble,
                   dviSuffix=dviSuffix)
    class(engine) <- "TeXengine"
    engine
}

## Register an engine with {latex}
registerEngine <- function(engine) {
    if (!inherits(engine, "TeXengine"))
        stop("Invalid engine")
    engines <- get("engines")
    registered <- names(engines)
    if (length(registered) &&
        engine$name %in% registered) {
        warning("TeX engine already registered")
    } else {
        newEngine <- list(engine)
        names(newEngine) <- engine$name
        set("engines",
            c(get("engines"), newEngine))
    }
}

## Given DVI object with engine (possibly a guess) and
## TeXengine object (possibly NULL)
## resolve on the engine to use
## Fail if DVI object (not a guess) conflicts with TeXengine (non-NULL)
resolveEngine <- function(dvi, engine) {
    dviEngine <- attr(dvi, "engine")
    dviGuessEngine <- attr(dvi, "guessEngine")
    engines <- get("engines")
    if (is.null(engine)) {
        if (dviEngine %in% names(engines)) {
            engines[[dviEngine]]
        } else {
            warning(paste0("'dvi' engine (", dviEngine, ") not available; ",
                           "falling back to dummy engine"))
            engines$dummy
        }
    } else {
        if (dviEngine == engine$name) {
            engine
        } else if (dviGuessEngine) {
            warning(paste0("Overriding 'dvi' engine guess (", dviEngine, ") ",
                           "with 'engine' (", engine$name, ")"))
            engine
        } else {
            stop(paste0("'dvi' engine (", dviEngine, ") ",
                        "does not match 'engine' (", engine$name, ")"))
        }
    }
}


