
library(latex)

if (latex:::canTypeset()) {
    tex <- author("This is a test: $x - \\mu$")
    typeset(tex)
}
