
library(latex)

state <- TeXstate()

TeXget("param", state)

TeXset("param", 1, state)

TeXget("param", state)
