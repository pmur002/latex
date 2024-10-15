
## Conversions
## to mm
fromTeX <- function(x) {
    factor <- get("scale")*get("num")/get("den")*1000/get("mag")/10^4
    x*factor
}
## from 'grid' units
toTeX <- function(x) {
    factor <- get("scale")*get("num")/get("den")*1000/get("mag")/10^4
    convertX(x, "mm", valueOnly=TRUE)/factor
}

