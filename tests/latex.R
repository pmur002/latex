
library(dvi)
library(latex)

dvi <- readDVI(system.file("DVI", "test-xe.xdv", package="dvi"))
               
## Fall back to dummy engine AND to dummy fontLib
tools::assertWarning(grid.dvi(dvi))
