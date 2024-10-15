
## Parsing DVI requires maintaining various state parameters
## like current location and current font

latex_state <- new.env()

get <- function(name) {
    base::get0(name, envir=latex_state, inherits=FALSE)
}

mget <- function(names) {
    base::mget(names, envir=latex_state, inherits=FALSE)
}

set <- function(name, value) {
    assign(name, value, envir=latex_state)
}




