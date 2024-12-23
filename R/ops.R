
## Functions for sweeping through operations within DVI file

op_ignore <- function(op, state) { }

## 0..127
## set_char_<i>
op_set_char <- op_ignore

## 128..131
## set1
## set2
## set3
## set4
op_set <- op_ignore

setRule <- function(op, put=FALSE, state) {
    h <- TeXget("h", state)
    v <- TeXget("v", state)
    updateBBoxHoriz(h, state)
    updateBBoxVert(v, state)
    a <- blockValue(op$blocks$op.opparams.a)
    b <- blockValue(op$blocks$op.opparams.b)
    updateBBoxHoriz(h + b, state)
    updateBBoxVert(v - a, state)
    ## Need to create glyph object if there have been any glyphs prior to this
    addGlyphObjs(state)
    addRuleObj(a, b, state)
    if (!put)
        TeXset("h", TeXget("h", state) + b, state)
}

## 132
## set_rule
op_set_rule <- function(op, state) setRule(op, FALSE, state)

## 133..136
## put1
## put2
## put3
## put4
op_put <- op_ignore

## 137
## put_rule
op_put_rule <- function(op, state) setRule(op, TRUE, state)

## 138
## nop

## 139
## bop
op_bop <- function(op, state) {
    ## Initialise locations
    TeXset("h", 0, state)
    TeXset("v", 0, state)
    TeXset("w", 0, state)
    TeXset("x", 0, state)
    TeXset("y", 0, state)
    TeXset("z", 0, state)
    ## Init text left/right
    TeXset("textleft", Inf, state)
    TeXset("textright", -Inf, state)
    ## Init bbox
    TeXset("top", Inf, state)
    TeXset("bottom", -Inf, state)
    TeXset("left", Inf, state)
    TeXset("right", -Inf, state)
    ## Init baseline
    TeXset("baseline", NA, state)
    ## Init anchors
    TeXset("hAnchors", NULL, state)
    TeXset("vAnchors", NULL, state)
    ## Init cumulative structures
    initDVIobjs(state)
    TeXset("glyphs", list(), state)
    ## Stack for push/pop
    TeXset("stack", list(), state)
    TeXset("i", 0, state)
    ## Font number
    TeXset("f", NA, state)
    ## Default colour
    TeXset("colour", NA, state)
    ## Default text direction
    TeXset("dir", 0, state)
}

## 140
## eop
op_eop <- function(op, state) {
    ## Need to create glyph object if there have been any glyphs prior to this
    addGlyphObjs(state)
}

## 141
## push
op_push <- function(op, state) {
    ## Maintain stack
    i <- TeXget("i", state)
    stack <- TeXget("stack", state)
    stack[[i + 1]] <- TeXmget(c("h", "v", "w", "x", "y", "z"), state)
    TeXset("i", i + 1, state)
    TeXset("stack", stack, state)
}

## 142
## pop
op_pop <- function(op, state) {
    ## Maintain stack
    i <- TeXget("i", state)
    stack <- TeXget("stack", state)
    values <- stack[[i]]
    mapply(TeXset, names(values), values, MoreArgs=list(state))
    TeXset("i", i - 1, state)
    TeXset("stack", stack[-i], state)
}

## 143..146
## right1
## right2
## right3
## right4
op_right <- function(op, state) {
    ## Update location
    b <- blockValue(op$blocks$op.opparams)
    dir <- TeXget("dir", state)
    if (dir == 0) {
        TeXset("h", TeXget("h", state) + b, state)
    } else {
        TeXset("v", TeXget("v", state) + b, state)
    }
}

## 147..151
## w0
## w1
## w2
## w3
## w4
op_w <- function(op, state) {
    ## Update location
    b <- op$blocks$op.opparams
    if (!is.null(b)) {
        TeXset("w", blockValue(b), state)
    }
    dir <- TeXget("dir", state)
    if (dir == 0) {
        TeXset("h", TeXget("h", state) + TeXget("w", state), state)
    } else {
        TeXset("v", TeXget("v", state) + TeXget("w", state), state)
    }
}

## 152..156
## x0
## x1
## x2
## x3
## x4
op_x <- function(op, state) {
    ## Update location
    b <- op$blocks$op.opparams
    if (!is.null(b)) {
        TeXset("x", blockValue(b), state)
    }
    dir <- TeXget("dir", state)
    if (dir == 0) {
        TeXset("h", TeXget("h", state) + TeXget("x", state), state)
    } else {
        TeXset("v", TeXget("v", state) + TeXget("x", state), state)
    }
}

## 157..160
## down1
## down2
## down3
## down4
op_down <- function(op, state) {
    ## Update location
    a <- blockValue(op$blocks$op.opparams)
    dir <- TeXget("dir", state)
    if (dir == 0) {
        TeXset("v", TeXget("v", state) + a, state)
    } else {
        TeXset("h", TeXget("h", state) - a, state)
    }
}

## 161..165
## y0
## y1
## y2
## y3
## y4
op_y <- function(op, state) {
    ## Update location
    a <- op$blocks$op.opparams
    if (!is.null(a)) {
        TeXset("y", blockValue(a), state)
    }
    dir <- TeXget("dir", state)
    if (dir == 0) {
        TeXset("v", TeXget("v", state) + TeXget("y", state), state)
    } else {
        TeXset("h", TeXget("h", state) - TeXget("y", state), state)
    }
}

## 166..170
## z0
## z1
## z2
## z3
## z4
op_z <- function(op, state) {
    ## Update location
    a <- op$blocks$op.opparams
    if (!is.null(a)) {
        TeXset("z", blockValue(a), state)
    }
    dir <- TeXget("dir", state)
    if (dir == 0) {
        TeXset("v", TeXget("v", state) + TeXget("z", state), state)
    } else {
        TeXset("h", TeXget("h", state) - TeXget("z", state), state)
    }
}

## 171..234
## fnt_num_<i-170>
op_fnt_num <- function(op, state) {
    ## Maintain font number
    ## + 1 for 1-based indexing
    f <- blockValue(op$blocks$op.opcode) - 171 + 1 
    TeXset("f", f, state)
}

## 235..238
## fnt1
## fnt2
## fnt3
## fnt4
op_fnt <- function(op, state) {
    k <- op$block$op.opparams
    f <- blockValue(k)
    TeXset("f", f, state)
}

## 239..242
## xxx1
## xxx2
## xxx3
## xxx4
op_special <- function(op, state) {
    specialString <- paste(blockValue(op$blocks$op.opparams.string),
                           collapse="")
    packageSpecial(TeXget("packages", state), specialString, state)
}

## 243..246
## fnt_def_1
## fnt_def_2
## fnt_def_3
## fnt_def_4
op_font_def <- op_ignore

## 247
## pre
op_pre <- function(op, state) {
    ## Set up scaling for conversions, e.g., fromTeX()
    num <- blockValue(op$blocks$op.opparams.num)
    den <- blockValue(op$blocks$op.opparams.den)
    mag <- blockValue(op$blocks$op.opparams.mag)
    TeXset("num", num, state)
    TeXset("den", den, state)
    TeXset("mag", mag, state)
    comment <- paste(blockValue(op$blocks$op.opparams.comment.string),
                     collapse="")
    ## Initialise packages
    packageInit(TeXget("packages", state), state)
}

## 248
## post
op_post <- function(op, state) {
    packageFinal(TeXget("packages", state), state)
}

## 249
## post_post

## 250..251
## Undefined

## XeTeX
## 252
## x_fnt_def
op_x_font_def <- function(op, state) {
    mag <- TeXget("mag", state)
    engine <- TeXget("engine", state)
    fontLib <- TeXget("fontLib", state)
    ## Create font definition and save it
    fonts <- TeXget("fonts", state)
    fontnum <- blockValue(op$blocks$op.opparams.fontnum) + 1
    ## Avoid redefining the same font 
    if (is.null(fonts[[fontnum]]) ||
        !(identical_font(op, fonts[[fontnum]]$op))) {
        fontnameChars <-
            blockValue(op$blocks$op.opparams.fontinfo.marker.fontname.block)
        fontname <- paste(fontnameChars, collapse="")
        fontindex <- blockValue(op$blocks$op.opparams.fontinfo.marker.fontindex)
        fontsize <- blockValue(op$block$op.opparams.ptsize)
        fonts[[fontnum]] <- list(file=fontname,
                                 index=fontindex,
                                 size=72.27*fromTeX(fontsize, state)/25.4*
                                     mag/1000,
                                 op=op)
        TeXset("fonts", fonts, state)
    }
}

setGlyphs <- function(op, state) {
    h <- TeXget("h", state)
    v <- TeXget("v", state)
    ## Default baseline to first set char
    ## (may be overridden by, e.g., 'preview')
    if (is.na(TeXget("baseline", state)))
        TeXset("baseline", v, state)
    ## Current font
    fonts <- TeXget("fonts", state)
    f <- TeXget("f", state)
    font <- fonts[[f]]
    colour <- TeXget("colour", state)
    fontLib <- TeXget("fontLib", state)
    ## NOTE:
    ##   No concept of text direction (in XDV)
    ##   We have an ARRAY of glyphs
    nGlyphs <- blockValue(op$blocks$op.opparams.n)
    glyphIds <- blockValue(op$blocks$op.opparams.glyphs.id)
    glyphLocs <- paste0("op.opparams.glyphs.xy", 1:(2*nGlyphs))
    glyphWidth <- 0
    for (i in 1:nGlyphs) {
        id <- glyphIds[i]
        glyphX <- blockValue(op$blocks[[glyphLocs[2*i - 1]]])
        glyphY <- blockValue(op$blocks[[glyphLocs[2*i]]])
        x <- h + glyphX
        y <- v - glyphY
        xx <- fromTeX(x, state)
        yy <- fromTeX(y, state)
        glyph <- glyph(xx, yy, id, f, font$size, colour=colour[1])
        ## Update bounding box of drawing
        ## BUT do NOT update h/v
        bbox <- TeXglyphBounds(id, font$file, font$size, fontLib, state)
        width <- TeXglyphWidth(id, font$file, font$size, fontLib, state)
        updateBBoxHoriz(x + bbox[1], state) ## left
        updateBBoxHoriz(x + bbox[2], state) ## right
        updateBBoxVert(y - bbox[3], state) ## bottom
        updateBBoxVert(y - bbox[4], state) ## top
        updateTextLeft(x, state)
        updateTextRight(x + width[1], state)
        addGlyph(glyph, state)
        ## Keep track of total glyph width
        glyphWidth <- glyphWidth + width[1]
    }
    ## Update h at the end for all glyphs
    TeXset("h", h + glyphWidth, state)
}

## 253
## x_glyph_array
op_x_glyph <- function(op, state) {
    setGlyphs(op, state)
}

## 254
## x_glyph_str
op_x_glyph_str <- function(op, state) {
    ## Just ignore string part of op
    setGlyphs(op, state)
}

## upTeX
## 255
## dir
op_dir <- function(op, state) {
    dir <- blockValue(op$blocks$op.opparams)
    TeXset("dir", dir, state)
}

################################################################################

## Functions for extracting specific pieces of DVI

commentString <- function(dvi) {
    codes <- opCodes(dvi)
    params <- opParams(dvi)
    commentParams <- params[[which(codes == 247)]]
    paste(commentParams$comment.string, collapse="")
}
