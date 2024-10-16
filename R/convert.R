
## Conversions
## to mm
fromTeX <- function(x, pre) {
    factor <- with(pre, scale*num/den*1000/mag/10^4)
    x*factor
}

## from 'grid' units
toTeX <- function(unit, pre) {
    factor <- with(pre, scale*num/den*1000/mag/10^4)
    convertX(unit, "mm", valueOnly=TRUE)/factor
}

