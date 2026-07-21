

metaloci.df <- get_metaloci.df()


# super plot --------------------------------------------------------------

# meta.df <- get_meta.df()
# project.df <- get_project.df(meta.df)
# metaloci.df <- get_metaloci.df()
# species.df <- get_species.df()




superplot <- function(edge.df, main='') {
  ## superplot expects a edge.df that contains organism metaloci in 'a' and 'b' with lwd and col attributes
  
  par()$din
  ## looks great at 6.5, 6.5
  
  
  genome.df <- get_genome.df()
  g.df <- genome.df
  g.df$center = g.df$tot_pos + g.df$length / 2
  
  g.df <- g.df[!duplicated(g.df$contig),]
  rownames(g.df) <- g.df$contig
  
  
  gagg.df <- dcast(genome.df, abbv + genbank + has_annotation ~ 'length', value.var='length', fun.aggregate = sum)
  gagg.df[!gagg.df$has_annotation & gagg.df$abbv %in% metaloci.df$abbv,]
  
  
  gagg.df <- merge(gagg.df, species.df[,c('abbv','phylum','class','order', 'family','genus','taxid')], by='abbv')
  rownames(gagg.df) <- gagg.df$abbv
  
  gagg.df        <- gagg.df[gagg.df$abbv %in% unique(metaloci.df$abbv),]
  
  gagg.df <- gagg.df[order(gagg.df$genus),]
  gagg.df <- gagg.df[order(gagg.df$family),]
  gagg.df <- gagg.df[order(gagg.df$order),]
  gagg.df <- gagg.df[order(gagg.df$class),]
  gagg.df <- gagg.df[order(gagg.df$phylum),]
  
  
  gap_size = 15000000
  text_radius = 1.15
  gagg.df$i <- 1:nrow(gagg.df)
  gagg.df$cum_gen <- cumsum(gagg.df$length) + gagg.df$i * gap_size
  gagg.df$cum_start <- gagg.df$cum_gen - gagg.df$length
  
  gagg.df$to      <- gagg.df$cum_gen
  gagg.df$to      <- gagg.df$to / max(gagg.df$to) * 2*pi
  
  gagg.df$from    <- gagg.df$cum_start / max(gagg.df$cum_gen) * 2*pi
  gagg.df$center  <- (gagg.df$cum_start + gagg.df$length / 2 ) / max(gagg.df$cum_gen) * 2*pi
  gagg.df$center.x <- sqrt(text_radius) * cos(gagg.df$center)
  gagg.df$center.y <- sqrt(text_radius) * sin(gagg.df$center)
  
  
  
  contig_lines <- function(a_contig, b_contig, lwd=NULL, col=NULL, tn=100, crad=0.25) {
    
    df <- data.frame(a_contig=as.vector(a_contig), b_contig=as.vector(b_contig))
    
    
    if (is.null(lwd)) {df$lwd = 1 } else {df$lwd = lwd}
    if (is.null(col)) {df$col = 'black'} else {df$col = col}
    
    df$a_abbv <- g.df[df$a_contig, 'abbv']
    df$b_abbv <- g.df[df$b_contig, 'abbv']
    
    df$a_radians <- (g.df[df$a_contig, 'center'] + gagg.df[df$a_abbv, 'cum_start']) / max(gagg.df$cum_gen) * 2*pi
    df$b_radians <- (g.df[df$b_contig, 'center'] + gagg.df[df$b_abbv, 'cum_start']) / max(gagg.df$cum_gen) * 2*pi
    df <- df[complete.cases(df),]
    df$c_radians = (df$a_radians + df$b_radians) / 2
    
    
    df$ax = cos(df$a_radians)
    df$ay = sin(df$a_radians)
    
    df$bx = cos(df$b_radians)
    df$by = sin(df$b_radians)
    
    df$cx = sqrt(crad) * cos(df$c_radians)
    df$cy = sqrt(crad) * sin(df$c_radians)
    
    t = seq( 0, 1, length=tn )
    
    for (i in 1:nrow(df)) {
      mat = matrix(c(df$ax[i], df$cx[i], df$bx[i], df$ay[i], df$cy[i], df$by[i]), ncol=2, byrow = F)
      lines(bezier::bezier(t, mat), lwd=df$lwd[i], col=df$col[i])
      
    }
    
  }
  
  par(mar=c(1,1,1,1), mfrow=c(1,1))
  plot(1,1, type='n', xlim=c(-1.2,1.2), ylim=c(-1.2,1.2), axes=F,
       main=main)
  
  
  draw_arcs <- function(show_annotation=T) {
    
    gagg.df$lwd = 10
    if (show_annotation) {
      gagg.df$lwd <- ifelse(gagg.df$has_annotation, 10, 3)
    }
    
    for (gi in 1:nrow(gagg.df)) {
      plotrix::draw.arc(x=0, y=0, radius = 1, gagg.df$from[gi], gagg.df$to[gi], 
                        lwd=gagg.df$lwd[gi], col=phylum_colors[gagg.df$phylum[gi]])
    }
  }
  
  
  
  gagg.df$adj.y <- 1-(gagg.df$center.y+sqrt(text_radius)) / (sqrt(text_radius)*2)
  gagg.df$adj.x <- 1-(gagg.df$center.x+sqrt(text_radius)) / (sqrt(text_radius)*2)
  for (i in 1:nrow(gagg.df)) {
    
    text(gagg.df$center.x[i], gagg.df$center.y[i], gagg.df$abbv[i], adj=c(gagg.df$adj.x[i], gagg.df$adj.y[i]))
  }
  # text(gagg.df$center.x[f], gagg.df$center.y[f], gagg.df$abbv[f], c(1,0.5))
  # text(gagg.df$center.x[!f], gagg.df$center.y[!f], gagg.df$abbv[!f], c(0,0.5))
  
  sp = list(gagg.df=gagg.df, genome.df=g.df, contig_lines=contig_lines, draw_arcs=draw_arcs)
  
}

# e.df <- c.df[c.df$evalue < 10**-30,]


## View 1 - permissive -----------------------------------------------------


e.df <- conservation.df

e.df <- e.df[e.df$a_type != "OtherRNA" & e.df$b_type != "OtherRNA",]
e.df <- e.df[e.df$a != e.df$b,]
e.df

e.df$a <- str_sub(e.df$a, 1, 5)
e.df$b <- str_sub(e.df$b, 1, 5)

e.df <- dcast(e.df, a + a_contig + b + b_contig ~ 'count', fun.aggregate = length)

e.df <- e.df[order(e.df$count),]


e.df$lwd = 0.05
e.df$lwd[e.df$count > 5] <- 0.15
e.df$lwd[e.df$count > 25] <- 0.35
e.df$lwd[e.df$count > 50] <- 0.5
e.df$lwd[e.df$count > 100] <- 1
# e.df$col = 'black'


superplot(e.df, main='View 1 - permissive edge filter')
sp$contig_lines(e.df$a_contig, e.df$b_contig, lwd=e.df$lwd, col='black')
sp$draw_arcs()


## View 2 - member repl'd -----------------------------------------------

e.df <- conservation.df

e.df <- e.df[e.df$a_type != "OtherRNA" & e.df$b_type != "OtherRNA",]
e.df <- e.df[e.df$a != e.df$b,]

proj_tab <- table(project.df$abbv)


l.df <- library.df
l.df$cond <- paste(l.df$abbv, l.df$bioproject, l.df$rg)
l.df <- l.df[!duplicated(l.df$cond),]

cond_tab <- table(l.df$abbv)

e.df$a <- str_sub(e.df$a, 1, 5)
e.df$b <- str_sub(e.df$b, 1, 5)

e.df <- e.df[e.df$a_members > cond_tab[e.df$a]*0.1 & e.df$b_members > cond_tab[e.df$b]*0.1,]


e.df


e.df <- dcast(e.df, a + a_contig + b + b_contig ~ 'count', fun.aggregate = length)

e.df <- e.df[order(e.df$count),]


e.df$lwd = 0.15
e.df$lwd[e.df$count > 5] <- 0.25
e.df$lwd[e.df$count > 25] <- 0.5
e.df$lwd[e.df$count > 50] <- 0.75
e.df$lwd[e.df$count > 100] <- 1
# e.df$col = 'black'


sp = superplot(e.df, main='View 2 - only replicated metaloci')

sp$contig_lines(e.df$a_contig, e.df$b_contig, lwd=e.df$lwd, col='black')
# sp$contig_lines(a_contig="JAYMDH010000005.1", b_contig='WWBZ02000016.1', lwd=3, col='orange')
sp$draw_arcs(show_annotation = T)


## View 3 - RNA_20-24 ------------------------------------------------------


e.df <- conservation.df

e.df <- e.df[e.df$a_type != "OtherRNA" & e.df$b_type != "OtherRNA",]
e.df <- e.df[e.df$a != e.df$b,]


e.df <- e.df[e.df$a_members > 1 | e.df$b_members > 1,]

candidates = str_glue("RNA_{make_dicer_sizes(20:24)}")

e.df <- e.df[e.df$a_type %in% candidates & e.df$b_type %in% candidates,]

e.df





e.df <- dcast(e.df, a + a_contig + b + b_contig ~ 'count', fun.aggregate = length)

e.df <- e.df[order(e.df$count),]

e.df$lwd = 0.15
e.df$lwd[e.df$count > 5] <- 0.25
e.df$lwd[e.df$count > 25] <- 0.5
e.df$lwd[e.df$count > 50] <- 0.75
e.df$lwd[e.df$count > 100] <- 1



sp = superplot(e.df, main='View3 - RNA_20-24')

sp$contig_lines(e.df$a_contig, e.df$b_contig, lwd=e.df$lwd, col='black')
# sp$contig_lines(a_contig="JAYMDH010000005.1", b_contig='WWBZ02000016.1', lwd=3, col='orange')
sp$draw_arcs()



## View 4 - RNA_26-29 ------------------------------------------------------



e.df <- conservation.df

e.df <- e.df[e.df$a_type != "OtherRNA" & e.df$b_type != "OtherRNA",]
e.df <- e.df[e.df$a != e.df$b,]

e.df <- e.df[e.df$a_members > 1 | e.df$b_members > 1,]

candidates = str_glue("RNA_{make_dicer_sizes(26:29)}")

e.df <- e.df[e.df$a_type %in% candidates & e.df$b_type %in% candidates,]

e.df


e.df <- dcast(e.df, a + a_contig + b + b_contig ~ 'count', fun.aggregate = length)

e.df <- e.df[order(e.df$count),]

e.df$lwd = 0.15
e.df$lwd[e.df$count > 5] <- 0.25
e.df$lwd[e.df$count > 25] <- 0.5
e.df$lwd[e.df$count > 50] <- 0.75
e.df$lwd[e.df$count > 100] <- 1



sp = superplot(e.df, main='View4 - RNA_26-29')

sp$contig_lines(e.df$a_contig, e.df$b_contig, lwd=e.df$lwd, col='black')
# sp$contig_lines(a_contig="JAYMDH010000005.1", b_contig='WWBZ02000016.1', lwd=3, col='orange')
sp$draw_arcs()


## View 5 - OtherRNA ------------------------------------------------------


e.df <- conservation.df

e.df <- e.df[e.df$a_type == "OtherRNA" & e.df$b_type == "OtherRNA",]
e.df <- e.df[e.df$a != e.df$b,]

e.df <- e.df[e.df$a_members > 1 | e.df$b_members > 1,]



e.df


e.df <- dcast(e.df, a + a_contig + b + b_contig ~ 'count', fun.aggregate = length)

e.df <- e.df[order(e.df$count),]

e.df$lwd = 0.15
e.df$lwd[e.df$count > 5] <- 0.25
e.df$lwd[e.df$count > 25] <- 0.5
e.df$lwd[e.df$count > 50] <- 0.75
e.df$lwd[e.df$count > 100] <- 1



sp = superplot(e.df, main="View5 - OtherRNAs only")

sp$contig_lines(e.df$a_contig, e.df$b_contig, lwd=e.df$lwd, col='black')
# sp$contig_lines(a_contig="JAYMDH010000005.1", b_contig='WWBZ02000016.1', lwd=3, col='orange')
sp$draw_arcs()


## View 6 - non-genic ------------------------------------------------------

# context.df <- get_context.df()
# c.df <- context.df
# c.df$name <- str_replace(c.df$ID, "metalocus", c.df$abbv)


e.df <- conservation.df

e.df <- e.df[e.df$a_type != "OtherRNA" & e.df$b_type != "OtherRNA",]
e.df <- e.df[e.df$a != e.df$b,]

e.df <- e.df[e.df$a_members > 1 | e.df$b_members > 1,]



e.df


e.df$a_context <- metaloci.df$context[match(e.df$a, metaloci.df$name)]
e.df$b_context <- metaloci.df$context[match(e.df$b, metaloci.df$name)]
#
# e.df$a_context <- c.df$category[match(e.df$a, c.df$name)]
# e.df$b_context <- c.df$category[match(e.df$b, c.df$name)]

e.df <- e.df[e.df$a_context %in% c('intergenic','near-genic'),]
e.df <- e.df[e.df$b_context %in% c('intergenic','near-genic'),]


e.df <- dcast(e.df, a + a_contig + b + b_contig ~ 'count', fun.aggregate = length)

e.df <- e.df[order(e.df$count),]

e.df$lwd = 0.15
e.df$lwd[e.df$count > 5] <- 0.25
e.df$lwd[e.df$count > 25] <- 0.5
e.df$lwd[e.df$count > 50] <- 0.75
e.df$lwd[e.df$count > 100] <- 1


abbv_with_context <- unique(metaloci.df$abbv[!is.na(metaloci.df$context)])
abbv_no_context = unique(metaloci.df$abbv[!metaloci.df$abbv %in% abbv_with_context])

sp = superplot(e.df, main='View 6 - non-genic loci', hides=abbv_no_context)

sp$contig_lines(e.df$a_contig, e.df$b_contig, lwd=e.df$lwd, col='black')
# sp$contig_lines(a_contig="JAYMDH010000005.1", b_contig='WWBZ02000016.1', lwd=3, col='orange')
sp$draw_arcs()



## View 7 - hairpins -------------------------------------------------------

e.df <- conservation.df
e.df <- e.df[e.df$a_type != "OtherRNA" & e.df$b_type != "OtherRNA",]
e.df <- e.df[e.df$a != e.df$b,]

e.df$a_ruling <- metaloci.df$hp_cat[match(e.df$a, metaloci.df$name)]
e.df$b_ruling <- metaloci.df$hp_cat[match(e.df$b, metaloci.df$name)]


table(e.df$a_ruling)
table(e.df$b_ruling)

# na.df <- new_annotation.df
# na.df$key <- str_c(na.df$project, na.df$annotation, na.df$ID, sep='.')
# na.df$ml_name <- str_replace(na.df$metalocus, "metalocus", na.df$abbv)
#   
#   
# hp.df <- hairpin.df
# hp.df$key <- str_c(hp.df$project, hp.df$cond, hp.df$name, sep='.')
# hp.df$metalocus <- na.df$ml_name[match(hp.df$key, na.df$key)]
# 
# hp.df <- hp.df[!is.na(hp.df$metalocus),]
# 
# hp.df$ruling_desc[hp.df$ruling == 'x x xx xx x -'] <- "near_miRNA"
# hp.df$ruling_desc[hp.df$ruling == 'x x xx xx x x'] <- "miRNA"
# 
# e.df$a_ruling <- hp.df$ruling_desc[match(e.df$a, hp.df$metalocus)]
# e.df$b_ruling <- hp.df$ruling_desc[match(e.df$b, hp.df$metalocus)]


# e.df$a_ruling[is.na(e.df$a_ruling)] <- '-'
# e.df$b_ruling[is.na(e.df$b_ruling)] <- '-'



resolve_ruling <- function(x) {
  if (length(unique(x)) == 1) return(unique(x))
  
  
  # if ("(insufficient)" %in% x & "-" %in% x) return('(insufficient)')
  
  if ("bad_duplex" %in% x) return("bad_duplex")
  if ("bad_hairpin" %in% x) return("bad_hairpin")
  if ("(overruled)" %in% x) return('(overruled)')
  if ("miRNA" %in% x) return("miRNA")
  if ("near_miRNA" %in% x) return("near_miRNA")
  return("-")
}

e.df <- e.df[!(e.df$a_ruling == '(undescribed)' & e.df$b_ruling == '(undescribed)'),]

e.df$ruling <- apply(e.df[,c('a_ruling','b_ruling')], 1, resolve_ruling)
e.df <- e.df[e.df$ruling != '-',]

# e.df <- e.df[e.df$ruling == 'miRNA',]

e.df <- e.df[!e.df$ruling %in% c('bad_hairpin')]

table(e.df$a)
table(e.df$b)
table(e.df$ruling)

e.df$lwd = 1
e.df$lwd[e.df$ruling == 'miRNA'] <- 4

e.df$col = 'grey'
e.df$col[e.df$ruling == 'bad_duplex'] <- 'gold'
e.df$col[e.df$ruling == 'imprecise'] <- 'purple'
e.df$col[e.df$ruling == 'miRNA'] <- 'red'


sp = superplot(e.df, main='View 7 - miRNAs')

sp$contig_lines(e.df$a_contig, e.df$b_contig, lwd=e.df$lwd, col=e.df$col)
# sp$contig_lines(a_contig="JAYMDH010000005.1", b_contig='WWBZ02000016.1', lwd=3, col='orange')
sp$draw_arcs()




# View 8 - struc RNAs -----------------------------------------------------



# context.df <- get_context.df()
# c.df <- context.df
# c.df$name <- str_replace(c.df$ID, "metalocus", c.df$abbv)


e.df <- conservation.df

e.df <- e.df[e.df$a_type != "OtherRNA" & e.df$b_type != "OtherRNA",]
e.df <- e.df[e.df$a != e.df$b,]

e.df <- e.df[e.df$a_members > 1 | e.df$b_members > 1,]




e.df$a_context <- metaloci.df$context[match(e.df$a, metaloci.df$name)]
e.df$b_context <- metaloci.df$context[match(e.df$b, metaloci.df$name)]
#
# e.df$a_context <- c.df$category[match(e.df$a, c.df$name)]
# e.df$b_context <- c.df$category[match(e.df$b, c.df$name)]

e.df <- e.df[!e.df$a_context %in% c('intergenic','near-genic'),]
e.df <- e.df[!e.df$b_context %in% c('intergenic','near-genic'),]

e.df <- e.df[!str_detect(e.df$a_context, "mRNA"),]
e.df <- e.df[!str_detect(e.df$b_context, "mRNA"),]


e.df <- dcast(e.df, a + a_contig + b + b_contig ~ 'count', fun.aggregate = length)

e.df <- e.df[order(e.df$count),]

e.df$lwd = 0.15
e.df$lwd[e.df$count > 5] <- 0.25
e.df$lwd[e.df$count > 25] <- 0.5
e.df$lwd[e.df$count > 50] <- 0.75
e.df$lwd[e.df$count > 100] <- 1



sp = superplot(e.df, main='View 7 - tRNA and rRNA loci')

sp$contig_lines(e.df$a_contig, e.df$b_contig, lwd=e.df$lwd, col='black')
# sp$contig_lines(a_contig="JAYMDH010000005.1", b_contig='WWBZ02000016.1', lwd=3, col='orange')
sp$draw_arcs()



# View 9 - RNA_20-24 not struc -------------------------------------------


e.df <- conservation.df

e.df <- e.df[e.df$a_type != "OtherRNA" & e.df$b_type != "OtherRNA",]
e.df <- e.df[e.df$a != e.df$b,]


# e.df <- e.df[e.df$a_projects > 1 | e.df$b_projects > 1,]
e.df <- e.df[e.df$a_members > 1 | e.df$b_members > 1,]

candidates = str_glue("RNA_{make_dicer_sizes(20:24)}")

e.df <- e.df[e.df$a_type %in% candidates & e.df$b_type %in% candidates,]

e.df


e.df$a_context <- metaloci.df$context[match(e.df$a, metaloci.df$name)]
e.df$b_context <- metaloci.df$context[match(e.df$b, metaloci.df$name)]

passing_metaloci = metaloci.df$name[metaloci.df$member_loci > 1]


e.df <- e.df[e.df$a %in% passing_metaloci | e.df$b %in% passing_metaloci ,]

for (feature in c("tRNA","rRNA", 'spliceosomal',"mRNA", "near-genic", "intergenic")) {
  e.df$context[str_detect(e.df$a_context, feature) | str_detect(e.df$b_context, feature)] <- feature
}
table(e.df$context)




plot_edges <- function(key, col, lwd=NULL) {
  
  e.df <- e.df[str_detect(e.df$context, key),]
  
  e.df <- dcast(e.df, a + a_contig + b + b_contig ~ 'count')
  
  e.df <- e.df[order(e.df$count),]
  
  if (is.null(lwd)) {
    e.df$lwd = 0.25
    # e.df$lwd[e.df$count > 5] <- 0.25
    e.df$lwd[e.df$count > 25] <- 0.5
    e.df$lwd[e.df$count > 50] <- 0.75
    e.df$lwd[e.df$count > 100] <- 1
  } else {
    e.df$lwd = lwd
  }
  
  sp$contig_lines(e.df$a_contig, e.df$b_contig, lwd=e.df$lwd, col=col)
  
}

sp = superplot(e.df, main='Genic') #main=str_glue('View9a - RNA_20-24'))
plot_edges("rRNA", 'red')
plot_edges("spliceosomal", 'purple3')
plot_edges("tRNA", 'blue')
plot_edges("mRNA", 'seagreen')
sp$draw_arcs()

sp = superplot(e.df, main='Non-genic') # main=str_glue('View9b - RNA_20-24'))
plot_edges("near-genic", 'goldenrod')
plot_edges("intergenic", 'black')
sp$draw_arcs()




plot(1,1, type='n', xlim=c(0,3), ylim=c(0,5), axes=F)
segments(rep(1,4), 1:4, rep(2,4), 1:4, lwd=c(0.25,0.5, 0.75, 1))
text(2, 1:4, c("[0,25)", "[25,50)", "[50,100)", "[100,)"), pos=4)



# View 10 - hairpins again ------------------------------------------------



e.df <- conservation.df
# e.df <- e.df[e.df$a_type != "OtherRNA" & e.df$b_type != "OtherRNA",]
e.df <- e.df[e.df$a != e.df$b,]

e.df$a_cat <- metaloci.df$hp_cat[match(e.df$a, metaloci.df$name)]
e.df$b_cat <- metaloci.df$hp_cat[match(e.df$b, metaloci.df$name)]

e.df$a_context <- metaloci.df$context[match(e.df$a, metaloci.df$name)]
e.df$b_context <- metaloci.df$context[match(e.df$b, metaloci.df$name)]

e.df <- e.df[e.df$a_context %in% c('intergenic','near-genic') | e.df$b_context %in% c('intergenic','near-genic'),]

table(e.df$a_cat)
table(e.df$b_cat)

# e.df <- e.df[e.df$a_cat == 'miRNA',]

passing_metaloci = metaloci.df$name[metaloci.df$member_loci > 1]


e.df <- e.df[e.df$a %in% passing_metaloci | e.df$b %in% passing_metaloci ,]


sp = superplot(e.df, main=str_glue('Hairpin-derived RNAs'))

f = e.df$a_cat == 'imprecise' | e.df$b_cat == 'imprecise'
sp$contig_lines(e.df$a_contig[f], e.df$b_contig[f], col=hairpin_colors['imprecise'], lwd=0.5)


# f = e.df$a_cat == 'miRNA' | e.df$b_cat == 'miRNA'
# sp$contig_lines(e.df$a_contig[f], e.df$b_contig[f], col=hairpin_colors['miRNA'], lwd=3.5)



sp$draw_arcs()



### non visualized


e.df <- conservation.df
e.df$a_cat <- metaloci.df$hp_cat[match(e.df$a, metaloci.df$name)]
e.df$b_cat <- metaloci.df$hp_cat[match(e.df$b, metaloci.df$name)]


e.df <- e.df[e.df$a_cat == 'miRNA',]




# assessing annotations ---------------------------------------------------

get_gff.df <- function() {
  gff.df <- data.frame()
  for (gff_file in Sys.glob('../+genomes/*.gff')) {
    message(gff_file)
    g.df <- readGFF(gff_file)
    
    abbv = str_sub(basename(gff_file), 1, 5)
    
    tab = as.data.frame(table(g.df$type))
    names(tab) <- c('type','count')
    tab$abbv = abbv
    
    gff.df = rbind(gff.df, tab)
    
  }
}

g.df <- gff.df
g.df <- dcast(g.df, abbv ~ type, value.var='count')
g.df[is.na(g.df)] <- 0
rownames(g.df) <- g.df$abbv

g.df[c('Scscl', 'Bocin'),]
g.df






# Inside out --------------------------------------------
p = plot(phy,
         type='unrooted', 
         show.tip.label =F,
         edge.color='grey20',
         cex=0.4)

nodelabels(node=1:length(phy$tip.label), pch=19, 
           col=phylum_colors[species.df$phylum[match(phy$tip.label, species.df$genus)]])
tiplabels(phy$tip.label, 1:length(phy$tip.label),  bg=NA, frame='n', cex=0.8)



pp <- get("last_plot.phylo", envir = .PlotPhyloEnv)
node <- (pp$Ntip + 1):length(pp$xx)

tip.df <- data.frame(x= pp$xx, y=pp$yy)
tip.df$tip[node] <- F
tip.df <- tip.df[is.na(tip.df$tip),]
tip.df$label <- phy$tip.label





edge.df <- expand.grid(tip.df$label,tip.df$label)
names(edge.df) <- c('from','to')
edge.df$val <- NA

edge.df$val[edge.df$from == "Gigaspora" & edge.df$to == 'Trichophyton'] <- 10

edge.df$x.from <- tip.df$x[match(edge.df$from, tip.df$label)]
edge.df$x.to   <- tip.df$x[match(edge.df$to,   tip.df$label)]
edge.df$y.from <- tip.df$y[match(edge.df$from, tip.df$label)]
edge.df$y.to   <- tip.df$y[match(edge.df$to,   tip.df$label)]
edge.df$x.bz1  <- 0.2
edge.df$y.bz1  <- 1

e.df <- edge.df[!is.na(edge.df$val),]

segments(e.df$x.from, e.df$y.from, e.df$x.to, e.df$y.to, lwd=e.df$val
)

bezierGR







# graph strategy ----------------------------------------------------------


conserv <- function(filtered=F, save=F) {
  library(igraph)
  
  
  igraph_pch <- phylum_pch[n.df$phylum]
  igraph_pch[igraph_pch == 21] = 'circle'
  igraph_pch[igraph_pch == 22] = 'square'
  igraph_pch[igraph_pch == 23] = 'csquare'
  igraph_pch[igraph_pch == 24] = 'csquare'
  
  test_same_phyl <- function(x, level) {
    x = species.df[match(x, species.df$abbv), level]
    !identical(x[1],x[2])
  }
  
  
  
  q.df <- conservation.df
  
  
  dim(q.df)
  
  q.df <- q.df[q.df$q.sizing == 'typical' & q.df$t.sizing == 'typical',]
  # q.df <- q.df[q.df$q.replication != 'none' & 
  # q.df$t.replication != 'none',]
  q.df <- q.df[q.df$q.replication  == 'binom+project+sizing',]
  dim(q.df)
  
  # if (filtered) q.df <- q.df[q.df$q.replication == q.df$t.replication & q.df$t.replication == 'binom+project+sizing',]
  
  if (filtered) q.df <- q.df[q.df$q.replication == q.df$t.replication & q.df$t.replication != 'none',]
  
  dim(q.df)
  
  
  tab <- table(query=q.df$q.abbv, target=q.df$t.abbv)
  tab <- as.data.frame(tab)
  
  tab <- tab[tab$Freq > 0,]
  
  e.df <- tab
  names(e.df)[1:2] <- c('from', 'to')
  e.df$edge.width <- log(e.df$Freq) / log(max(e.df$Freq)) * 20
  e.df$trans_phylum <- apply(e.df[,c('from','to')], 1, test_same_phyl, level='phylum')
  e.df$trans_class <- apply(e.df[,c('from','to')], 1, test_same_phyl, level='class')
  
  e.df$col <- scales::alpha('grey',0.7)
  e.df$col[e.df$trans_class] <- scales::alpha('firebrick3',0.7)
  e.df$col[e.df$trans_phylum] <- scales::alpha('blue',0.7)
  
  
  
  
  n.df <- data.frame(abbv=unique(metalocus.df$abbv))
  n.df <- merge(n.df, species.df[,c("abbv",'phylum','class','order','family','genus')], by='abbv')
  
  for (o in c('genus','family','order','class','phylum')) {
    n.df <- n.df[order(n.df[[o]]),]
  }
  
  file_name=str_glue("04-cons_filter={filtered}.svg")
  if (save) svglite(file_name, 7.2,7.2)
  
  g <- graph_from_data_frame(e.df, directed=F, vertices = n.df)
  
  # layout <- layout_nicely(g)
  # layout <- layout_as_tree(g)
  layout <- layout_in_circle(g)
  # layout <- layout_with_lgl(g)
  # layout <- layout_on_sphere(g)
  # layout <- layout_with_sugiyama(g)
  # layout <- layout_as_star(g)
  # layout <- layout_randomly(g)
  # layout <- layout_with_kk(g)
  # layout <- layout_with_gem(g)
  # layout <- layout_with_graphopt(g)
  plot(g, layout = layout, margin=rep(0,4),
       vertex.color= class_colors[n.df$class],
       vertex.label.family='Arial',
       vertex.label.font=2,
       vertex.label.cex=0.5,
       # vertex.label.dist = 1.5,
       vertex.size = 10,
       vertex.shape = igraph_pch[n.df$phylum],
       edge.color=e.df$col,
       edge.width=e.df$edge.width,
       edge.curved=0.3)
  
  if (save) dev.off()
  if (save) ADsvg(file_name)
}

conserv(filtered=F, save=F)
# conserv(filtered=T, save=F)
conserv(filtered=T, save=F)






# locus graph -----------------------------------------------------------------

library(syntenyPlotteR)

library(ggraph)
library(tidygraph)

### the idea here is to build node-to-node connections based on the level of evidence



node.df <- metalocus.df

edge.df <- conservation.df
head(edge.df)
edge.df <- edge.df[str_detect(edge.df$q.replication, "binom") &
                     str_detect(edge.df$t.replication, "binom"), ]

edge.df <- edge.df[,c('q.metalocus', 't.metalocus', 'length','evalue')]
names(edge.df)[1:2] <- c('from','to')

sort_paste <- function(x) {
  paste(sort(x), collapse=' ')
}

edge.df$sorted <- apply(edge.df[,c('from','to')], 1, sort_paste)
edge.df$support <- 'uni'
edge.df$support[duplicated(edge.df$sorted)] <- 'bi'

edge.df <- edge.df[order(edge.df$support),]
head(edge.df)
edge.df <- edge.df[!duplicated(edge.df$sorted),]
edge.df$sorted <- NULL

table(edge.df$support)

plot_net <- function(species = c("Bocin", "Scscl")) {
  
  e.df <- edge.df[str_sub(edge.df$from,1,5) %in% species &
                    str_sub(edge.df$to,1,5) %in% species,]
  # e.df <- e.df[e.df$support == 'bi',]
  
  node_list <- unique(e.df$from, e.df$to)
  
  n.df <- node.df[node.df$metalocus %in% e.df$from |
                    node.df$metalocus %in% e.df$to,]
  
  n.df$node_idx <- match(node_list, n.df$metalocus)
  
  message(str_glue("{nrow(n.df)} nodes"))
  message(str_glue("{nrow(e.df)} edges"))
  message(str_glue("   {sum(e.df$support=='bi')} bi-directional"))
  message(str_glue("   {sum(e.df$support=='uni')} uni-directional"))
  
  
  table(e.df$from)
  table(e.df$to)
  
  
  
  graph <- as_tbl_graph(e.df, nodes=n.df, node_key='node_idx', directed=F) |>
    mutate(indegree = centrality_degree(mode = 'in')) |>
    mutate(outdegree = centrality_degree(mode = 'out'))
  
  layout <- create_layout(graph, layout = 'linear')
  
  ggraph(layout) + 
    # geom_edge_link(aes(colour = factor(support)), show.legend = FALSE)+
    # geom_edge_fan(aes(alpha = after_stat(index)), show.legend = FALSE) +
    # geom_edge_link() +
    geom_edge_arc() + 
    geom_node_point(aes(size = Common), colour='seagreen')
  
  
}
plot_net()













graph <- as_tbl_graph(highschool) |> 
  mutate(Popularity = centrality_degree(mode = 'in'))

# plot using ggraph
ggraph(graph, layout = 'auto') + 
  geom_edge_fan(aes(alpha = after_stat(index)), show.legend = FALSE) + 
  geom_node_point(aes(size = Popularity)) + 
  facet_edges(~year) + 
  theme_graph(foreground = 'steelblue', fg_text_colour = 'white')


graph <- tbl_graph(flare$vertices, flare$edges)
set.seed(1)
ggraph(graph, 'circlepack', weight = size) + 
  geom_edge_link() + 
  geom_node_point(aes(colour = depth)) +
  coord_fixed()



# Example using the ggraph package in R
library(ggraph)
library(igraph)

# Load a sample graph (replace with your own data)
g <- make_ring(10)

# Perform a clustering (e.g., using a simple algorithm)
cl <- cluster_louvain(g)

# Visualize the graph, coloring nodes by cluster
ggraph(g, layout = 'fr') +
  geom_edge_link() +
  geom_node_point(aes(color = factor(cl$membership))) +
  theme_graph()


# Radial tree -------------------------------------------------------------

library(grid)
library(gridBase)

cart2polar <- function(x, y) {
  atan2(y, x)
}

plot_phylo <- function(edges=data.frame()) {
  p = species.phy
  f = match(p$tip.label, species.df$tree_species)
  p$abbv   <- species.df$abbv[f]
  p$phylum <- species.df$phylum[f] 
  p$color  <- phylum_colors[p$phylum]
  
  
  plot.phylo(p, type='fan', label.offset = 0.075,
             show.tip.label = F,
             node.color = p$color,
             pch=19,
             cex=0.8,
             x.lim=lim, y.lim=lim)
  
  l = get("last_plot.phylo", envir = .PlotPhyloEnv)
  nodelabels(node=1:length(p$tip.label), pch=21, cex=2, bg=p$color)
  
  
  tip.df <- data.frame(label=p$tip.label)
  tip.df$abbv <- species.df$abbv[match(tip.df$label, species.df$tree_species)]
  tip.df$x <- l$xx[1:nrow(tip.df)]
  tip.df$y <- l$yy[1:nrow(tip.df)]
  tip.df$adj.y <- acos(tip.df$y) / pi
  tip.df$adj.x <- ifelse(asin(tip.df$x) > 0, 0, 1)
  tip.df$polar     <- atan2(tip.df$y, tip.df$x)
  tip.df$polar_deg <- round(tip.df$polar / pi * 180,1)
  
  offset = 0.08
  tip.df$label.x = tip.df$x + cos(tip.df$polar) * offset
  tip.df$label.y = tip.df$y + sin(tip.df$polar) * offset
  
  
  for (i in 1:nrow(tip.df)) {
    row = tip.df[i,]
    if (row$polar_deg > 90 | row$polar_deg < -90) {
      srt = (row$polar_deg + 180) %% 360
      adj = 1
    } else {
      srt = row$polar_deg
      adj = 0
    }
    
    text(row$label.x, row$label.y, row$abbv, srt=srt, adj=adj, col=scales::alpha('black',0.5))
  }
  
  
  
  
  plot_arc <- function(abbv1, abbv2, lwd=1, col='black', cval=1) {
    
    
    abbvs = rep(tip.df$abbv,2)
    
    if (!abbv1 %in% abbvs) return()
    if (!abbv2 %in% abbvs) return()
    
    print(str_glue("{abbv1} to {abbv2}"))
    
    reverse_dist = (which(abbv2 == abbvs)[1] - which(abbv1 == abbvs)[2]) %% nrow(tip.df)
    forward_dist = (which(abbv1 == abbvs)[2] - which(abbv2 == abbvs)[1]) %% nrow(tip.df)
    
    if (forward_dist < reverse_dist) {
      direction = 'forward'
      direction_int = 1
      distance  = forward_dist
    } else {
      direction = 'reverse'
      direction_int = -1
      distance  = reverse_dist
    }
    
    print(str_glue("   -> {direction}"))
    
    # curvature = cval * direction_int * (1 - distance / nrow(tip.df) * 2)
    # curvature = cval * direction_int * -1 * (distance / nrow(tip.df) * 3) 
    
    curvature_range = seq(1.2, 1.5, length.out=nrow(tip.df)/2)
    curvature = curvature_range[distance] * direction_int *-1
    
    message(str_glue("curvature: {curvature}"))
    
    x1 = unit(tip.df$x[tip.df$abbv == abbv1], 'native')
    y1 = unit(tip.df$y[tip.df$abbv == abbv1], 'native')
    x2 = unit(tip.df$x[tip.df$abbv == abbv2], 'native')
    y2 = unit(tip.df$y[tip.df$abbv == abbv2], 'native')
    
    grid.curve(x1, y1, x2, y2,
               ncp=50,
               square = FALSE,
               curvature = curvature,
               gp=gpar(lwd=lwd, col=col))
  }
  
  
  par(mar=c(.2,.2,.2,.2))
  lim = c(-1.5,1.5)
  points(tip.df$x, tip.df$y, pch=21,bg=p$color, cex=2)#, axes=F, ann=F,  xlim=lim, ylim=lim)
  # text(tip.df$x, tip.df$y, tip.df$abbv, cex=0.9, pos='3')
  
  x1 = tip.df$x[1]; y1=tip.df$y[1]
  x2 = tip.df$x[12]; y2=tip.df$y[12]
  
  vps <- baseViewports()
  pushViewport(vps$plot)
  
  for (i in 1:nrow(edges)) {
    edge = edges[i,]
    plot_arc(edge$abbv1, edge$abbv2, col=edge$col, lwd=edge$lwd)
    
  }
  # 
  # plot_arc("Bocin", "Mucir", col='red')
  # plot_arc("Bocin", "Nobom")
  # plot_arc("Bocin", "Tamar")
  # plot_arc("Bocin", "Clros")
  # plot_arc("Bocin", "Blgra")
  # plot_arc("Bocin", "Rhsol")
  # plot_arc("Bocin", "Caalb", lwd=3, col='orange')
  
}





edge.df <- conservation.df
head(edge.df)
edge.df <- edge.df[str_detect(edge.df$q.replication, "binom") &
                     str_detect(edge.df$t.replication, "binom"), ]
edge.df <- edge.df[edge.df$q.sizing == 'typical' &
                     edge.df$t.sizing == 'typical', ]

edge.df <- edge.df[,c('q.metalocus', 't.metalocus', 'length','evalue')]
names(edge.df)[1:2] <- c('from','to')

sort_paste <- function(x) {
  paste(sort(x), collapse=' ')
}

edge.df$sorted <- apply(edge.df[,c('from','to')], 1, sort_paste)
edge.df$support <- 'uni'
edge.df$support[duplicated(edge.df$sorted)] <- 'bi'

sort_paste_abbv <- function(x) {
  paste(sort(str_sub(x,1,5)), collapse=' ')
}
edge.df$sorted_abbv <- apply(edge.df[,c('from','to')], 1, sort_paste_abbv)
edge.df$abbv1 <- str_split_fixed(edge.df$sorted_abbv, " ", 2)[,1]
edge.df$abbv2 <- str_split_fixed(edge.df$sorted_abbv, " ", 2)[,2]
edge.df$val <- 1



e.df <- dcast(edge.df, abbv1 + abbv2 + support ~ 'freq', value.var = 'val', fun.aggregate = sum)
e.df$col <- ifelse(e.df$support == 'bi', 'red', 'black')
e.df$lwd <- e.df$freq / 20 * 3 + 1

plot_phylo(e.df[e.df$support == 'uni',])
plot_phylo(e.df[e.df$support == 'bi',])






# subset network ----------------------------------------------------------

library(RCy3)


edge.df <- conservation.df
head(edge.df)
edge.df <- edge.df[str_detect(edge.df$q.replication, "binom") &
                     str_detect(edge.df$t.replication, "binom"), ]
edge.df <- edge.df[edge.df$q.sizing == 'typical' &
                     edge.df$t.sizing == 'typical', ]

edge.df <- edge.df[,c('q.metalocus', 't.metalocus', 'length','evalue')]
names(edge.df)[1:2] <- c('source','target')

sort_paste <- function(x) {
  paste(sort(x), collapse=' ')
}

edge.df$sorted <- apply(edge.df[,c('source','target')], 1, sort_paste)
edge.df$support <- 'uni'
edge.df$support[duplicated(edge.df$sorted)] <- 'bi'









edge.df <- edge.df[grepl("Fugra|Blgra|Bocin|Scscl|Asapi", edge.df$sorted),]
node.df <- data.frame(id=unique(c(edge.df$source, edge.df$target)))
node.df$abbv <- str_sub(node.df$id, 1, 5)


colors = c(Fugra='grey',Blgra='gold',Bocin='tomato',Scscl='mediumseagreen',Asapi='purple')

createNetworkFromDataFrames(node.df,edge.df)
setNodeColorMapping(table.column='abbv',
                    table.column.values = names(colors),
                    colors=colors,
                    mapping.type='d')







# conservation clusters ---------------------------------------------------


e.df <- cluster.ls$edges
n.df <- cluster.ls$nodes
tab  <- cluster.ls$tab

tab


check_cluster <- function(cluster) {
  c.df <- context.df
  c.df[c.df$metalocus %in% n.df$metalocus[n.df$cluster == cluster],]
}

check_cluster('Cl_3')
check_cluster("Cl_8")
check_cluster("Cl_20")
check_cluster("Cl_10")

# 
# 
# ### I do not think I like this tool. It doesn't allow gff3 format, which seems like a ridiculous oversight. It smells problematic, and I shall not proceed.
# # weak documentation.
# 
# library(rGenomeTracks)
# library(rGenomeTracksData)
# 
# # Download h5 example
# ah <- AnnotationHub()
# query(ah, "rGenomeTracksData")
# h5_dir <-  ah[["AH95901"]]
# 
# # Create HiC track from HiC matrix
# h5 <- track_hic_matrix(
#   file = h5_dir, depth = 250000, min_value = 5, max_value = 200,
#   transform = "log1p", show_masked_bins = FALSE
# )
# 
# 
# 
# ?track_gtf
# 
# gtf <- track_gtf("/Volumes/Web/Assemblies/Bocin.GCF_000143535.2_ASM14353v4_genomic/Bocin.GCF_000143535.2_ASM14353v4_genomic.gff3")
# plot_gtracks(gtf + track_spacer())


## GVIZ
# library(Gviz)
# library(rtracklayer)
# 
# plot_metalocus <- function(metalocus = 'Bocin-182') {
#   
#   options(ucscChromosomeNames=F)
#   
#   # metalocus.df[metalocus.df$abbv == 'Bocin', c('metalocus','type','member_loci','rpm','strand')]
#   
#   # locus = metalocus.df[metalocus.df$metalocus == 'Bocin-8430',]
#   # locus = metalocus.df[metalocus.df$metalocus == 'Bocin-182',]
#   locus = metalocus.df[metalocus.df$metalocus == metalocus,]
#   
#   message(metalocus)
#   message(locus$rep_locus)
#   
#   
#   abbv = str_sub(metalocus, 1,5)
#   flank_length = 1000
#   start        = locus$start - flank_length
#   end          = locus$end + flank_length
#   w = GRanges(str_glue("{locus$seqid}:{start}-{end}"))
#   
#   
#   ## Gene track
#   
#   assembly_dir = Sys.glob(str_glue('/Volumes/Web/Assemblies/{abbv}*'))
#   
#   gene_gff_file = Sys.glob(str_glue('{assembly_dir}/*_genomic.gff3'))
#   gene.gr <- import.gff(gene_gff_file, 
#                         feature.type=c('exon'),
#                         which=w)
#   
#   grtrack <- GeneRegionTrack(gene.gr, 
#                              transcript = gene.gr$transcript_id,
#                              exon       = gene.gr$ID,
#                              symbol     = gene.gr$transcript_id,
#                              transcriptAnnotation = "transcript")
#   
#   
#   displayPars(grtrack) <- list(
#     collapse=T,
#     transcriptAnnotation = "transcript",
#     shape='arrow'
#   )
#   
#   
#   ## metaloci tracks
#   
#   mla_gff <- import.gff(str_glue("../metaloci/01out-meta_gffs/{abbv}.all.gff3"), 
#                         which=w)
#   mlm_gff <- import.gff(str_glue("../metaloci/01out-meta_gffs/{abbv}.meta.gff3"), 
#                         which=w)
#   
#   
#   mlatrack <- AnnotationTrack(mla_gff)
#   mlmtrack <- AnnotationTrack(mlm_gff, color='red')
#   
#   
#   ## sRNA track
#   
#   bw_to_vector <- function(file) {
#     
#     data <- import.bw(file, which=w)
#     data = as.data.frame(data)
#     out = as.vector(Rle(values=data$score, data$width))
#     return(out)
#   }
#   
#   
#   
#   cdata = GRanges(locus$seqid, IRanges(start:end, start:end))
#   
#   project    = str_split(locus$rep_locus,"-")[[1]][2]
#   annotation = str_split(locus$rep_locus,"-")[[1]][3]
#   
#   
#   
#   for (size in names(size_colors)) {
#     for (strand in c("+","-")) {
#       file=str_glue("{assembly_dir}/{project}/{annotation}/{size}{strand}.bigwig")
#       if (!file.exists(file)) next
#       v = bw_to_vector(file) 
#       cdata@elementMetadata[[paste0(size,strand)]] <- v
#       
#     }
#   }
#   
#   if (ncol(cdata@elementMetadata) == 0) {
#     message("no bigwigs found!")
#     return()
#   }
#   
#   bwtrack <- DataTrack(range=cdata,)
#   
#   displayPars(bwtrack) <- list(
#     groups=names(cdata@elementMetadata),
#     type='l',
#     col=rep(size_colors,each=2)
#   )
#   
#   # length(bwtrack)
#   # plotTracks(bwtrack)
#   
#   
#   ## Plotting
#   axistrack <- GenomeAxisTrack()
#   
#   plotTracks(list(axistrack, grtrack, bwtrack, mlmtrack), main =metalocus)
#   
# }
# 
# plot_metalocus()
# 
# 
# check_cluster()
# tab
# metaloci = n.df$metalocus[n.df$cluster == 'Cl_33']
# 
# for (metalocus in metaloci) {
#   plot_metalocus(m)
# }



plot_metalocus <- function(metalocus = 'Bocin-182',
                           norm=c('rpm', 'count'),
                           scale=c('individual', 'group'),
                           pad = 1000,
                           save=F,
                           force=F) {
  norm <- match.arg(norm)
  scale <- match.arg(scale)
  
  sRNA_color = 'goldenrod1'
  
  
  
  if (save & !dir.exists("04-metalocus_plots/")) dir.create('04-metalocus_plots')
  file_name = str_glue("04-metalocus_plots/{metalocus}.{norm}.{scale}.svg")
  
  if (save & 
      file.exists(file_name) & 
      file.info(file_name)$size > 0 &
      ! force) return(paste("File found!"))
  
  if (save) graphics.off()
  
  
  dirs <- get_dir_paths()
  # ann_dir = '/Users/jax/fungal_annotations/annotations'
  # dirs$gen = '/Users/jax/fungal_annotations/Genomes'
  # dirs$gen = '/Volumes/fungal_srnas/Genomes'
  
  locus = metalocus.df[metalocus.df$metalocus == metalocus,]
  coord = paste0(locus$seqid, ":", locus$start, '-', locus$end)
  grcoord = GRanges(coord)
  start(grcoord) = start(grcoord) - pad
  end(grcoord) = end(grcoord) + pad
  
  message("")
  message('plotting metalocus')
  message(paste('  metalocus:', metalocus))
  message(paste('  coord:', coord))
  
  message(paste('  normalization:', norm))
  message(paste('  scale:', scale))
  
  
  

  
  grc <- GRanges(coord, strand=locus$strand, type='sRNA', source='yasma', Parent='')
  
  
  abbv  = str_sub(metalocus, 1,5)
  message(paste("  rep_locus:", locus$rep_locus))

  # ncbi_gff = Sys.glob(paste0(dirs$gen, abbv, "*_genomic.gff3"))[1]

  s.df = species.df[species.df$abbv == abbv,]
  ncbi_gff = str_glue("{dirs$gen}{abbv}.{s.df$accession}_{s.df$assembly_name}_genomic.gff3")
  rfam_gff = str_glue("../rfam/02out-rfam_gffs/{abbv}.rfam.gff3")
  te_gff   = str_glue("../TE_annotations/eg_out/{abbv}_EarlGrey/{abbv}_summaryFiles/{abbv}.filteredRepeats.gff")
  
  for (gff in c(ncbi_gff, rfam_gff, te_gff)) {
    if (!file.exists(gff)) return(paste("GFF not found:", gff))
  }
  
  other_metaloci <- m.df[m.df$seqid == locus$seqid & m.df$end > start(grcoord) & m.df$start < end(grcoord) & m.df$metalocus != metalocus,]
  if (nrow(other_metaloci) > 0) {
    mloc.gr <- GRanges(paste0(other_metaloci$seqid, ":", other_metaloci$start, "-", other_metaloci$end), 
                     Name=other_metaloci$metalocus, type='sRNA', source='yasma')
  } else {
    mloc.gr = GRanges()
  }
  ncbi.gr <- import.gff(ncbi_gff, 
                        feature.type	=c('gene','mRNA','exon'))
  rfam.gr <- import.gff(rfam_gff)
  te.gr   <- import.gff(te_gff)
  
  ## fixing problems with genbank/refseq chromosome names
  
  fix_seqlevels <- function(g) {
    
    if (seqlevels(grc) %in% lookup.df$genbankAccession) {
      target='genbankAccession'
      source='refseqAccession'
      
    } else if (seqlevels(grc) %in% lookup.df$refseqAccession) {
      target='refseqAccession'
      source='genbankAccession'
      
    } else {
      stop("Problem with seqlevels... locus does not appear to match any genomic reference names")
      
    }
    
    if (length(g) == 0) return(g)
    
    if (any(seqlevels(g) %in% lookup.df[[source]])) {
      seqlevels(g) <- lookup.df[[target]][match(seqlevels(g), lookup.df[[source]])]
      
    }
    
    return(g)
  }
  
  # if (seqlevels(grc) %in% seqlevels(ncbi.gr)) {
  #   if (seqlevels(ncbi.gr) %in% lookup.df$genbankAccession) {
  #     v = lookup.df$genbankAccession[match(seqlevels(grc), lookup.df$refseqAccession)]
  #     seqlevels(grc) <- v
  #     
  #     v = lookup.df$genbankAccession[match(seqlevels(mloc.gr), lookup.df$refseqAccession)]
  #     seqlevels(mloc.gr) <- v
  #     
  #   }
  # }
  
  ncbi.gr <- fix_seqlevels(ncbi.gr)
  te.gr   <- fix_seqlevels(te.gr)
  rfam.gr <- fix_seqlevels(rfam.gr)
  
  
  gr <- c(ncbi.gr, rfam.gr, te.gr, mloc.gr)
  # gr <- gr[order(gr),]
  gr <- sort(gr, ignore.strand=TRUE)
  gr <- c(grc, gr)
  # gr
  
  # mcols(gr) <- mcols(gr)[,c('type', 'ID', 'Parent', 'gene_biotype', 'source', 'locus_tag','Name')]
  # 
  # window = grcoord
  # window = resize(window, width=width(window)*2, fix='center')
  
  # gr[overlapsAny(gr, window),]
  # ncbi.gr[overlapsAny(ncbi.gr, window),]
  
  # if (length(gr) == 0) {
  #   ncbi.gr <- import.gff(Sys.glob(paste0(dirs$gen, abbv, "*_genomic.gff3"))[1], 
  #                         feature.type	=c('gene','mRNA','exon'))
  #   rfam.gr <- import.gff(str_glue("../rfam/02out-rfam_gffs/{abbv}.rfam.gff3"))
  #   te.gr <- import.gff(str_glue("../TE_annotations/eg_out/{abbv}_EarlGrey/{abbv}_summaryFiles/{abbv}.filteredRepeats.gff"))
  #   gr <- c(ncbi.gr, rfam.gr, te.gr)
  #   
  #   # before = gr[precede(grcoord, wgr),]
  #   # after = gr[follow(grcoord, wgr),]
  #   # distance(after, grcoord)
  #   # 
  #   # context = list(before = list(biotype=mcols(before)$gene_biotype,
  #   #                              dist = distance(before, grcoord)),
  #   #                after = list(biotype=mcols(after)$gene_biotype,
  #   #                             dist = distance(after, grcoord))
  #   #                )
  # } else {
  #   context = NULL
  # }
  
  # gr <- gr[gr$type != 'r']
  
  l.df <- locus.df[locus.df$metalocus == metalocus,]
  l.df$depth <- as.numeric(l.df$depth)
  l.df <- l.df[order(-l.df$depth),]
  p.df <- project.df[project.df$abbv == abbv & project.df$f_pass,]
  
  
  
  
  included_annotations <- paste0(l.df$project, ".", l.df$annotation)
  # other_annotations <- c()
  
  
  pas = c()
  
  
  
  for (p in p.df$project) {
    for (a in str_split(p.df$conditions[p.df$project == p], ",")[[1]]){
      pa = paste0(p,".",a)
      # if (!pa %in% included_annotations) {
        
      pas <- c(pas, pa)
        
      # }
      
    }
  }
  
  
  
  
  ## generating coverage for locus across all projects
  
  get_coverages <- function() {
    
    message('reading in coverages...')
    
    bw.ls = list(ymax_vec = c())
    
    
    for (i in 1:nrow(p.df)) {
      
      project = p.df$project[i]
      annotations = str_split(p.df$conditions[i], ",")[[1]]
      
      for (annotation in annotations) {
        
        pa = paste0(project,'.', annotation)
        
        message(paste(" ", pa, ifelse(pa %in% included_annotations, "<-", '')))
        x = rep(0, (locus$end+pad) - (locus$start-pad))
        bw.ls[[pa]] = list('typical+'=x, 'other+'=x, 'typical-'=x, 'other-'=x)
        
        params_file = paste0(dirs$ann, "/",project,"/tradeoff_", annotation,"/params.json")
        if (!file.exists(params_file)) {print(paste(params_file, 'not found')); next}
        params = jsonlite::read_json(params_file)
        
        libraries = unlist(params$conditions[[annotation]])
        
        bamfile = paste0(dirs$ann, "/", project, "/align/alignment.bam")
        if (!file.exists(bamfile)) {print(paste(bamfile, 'not found')); next}
        
        aln.df <- read.delim(paste0(dirs$ann, "/", project, "/align/library_stats.txt"))
        aln.df <- melt(aln.df, id.vars = c('library','project'))
        aln.df <- aln.df[str_sub(aln.df$variable, 1, 4) != 'xmap',]
        aln.df <- dcast(aln.df, library ~ 'depth', value.var='value', fun.aggregate = sum)
        aln_depth <- setNames(aln.df$depth,aln.df$library)
        total_aligned <- sum(aln_depth[libraries])
        
        param = ScanBamParam(which=grcoord, 
                             what=c('qname', 'qwidth', 'pos', 'strand'),
                             tagFilter= list(RG=libraries))
        b = scanBam(bamfile, param=param)[[1]]
        
        
        
        if (length(b$qname) == 0) next
        
        
        b.df <- data.frame(pos=b$pos, width = b$qwidth, strand=as.vector(b$strand))
        b.df$size <- ifelse(b.df$width %in% 19:25, 'typical','other')
        b.df <- dcast(b.df, pos + width + strand + size ~ 'count', value.var = 'width', fun.aggregate = length) 
        b.df$rpm <- b.df$count / total_aligned * 1000000
        
        b.df$val = switch(norm,
                          rpm = b.df$rpm,
                          count = b.df$count)
        
        for (bi in 1:nrow(b.df)) {
          index = b.df$pos[bi] - locus$start + pad
          range = index:(index+b.df$width[bi])
          range = range[range > 0]
          ss = paste0(b.df$size[[bi]],b.df$strand[bi])
          val = rep(b.df$val[bi], length(range))
          
          bw.ls[[pa]][[ss]][range] <- bw.ls[[pa]][[ss]][range] + val
          
        }
        
        bw.ls[[pa]]$sizes = table(b$qwidth)
        
        v = c()
        for (strand in c("+", "-")) {
          for (sizing in c("other", "typical")) {
            ss = paste0(sizing, strand)
            v = c(v, max(abs(bw.ls[[pa]][[ss]][pad:(width(grcoord)-pad)]), na.rm=T))
          }
        }
        bw.ls$ymax_vec[pa] = max(v, na.rm=T)
        
      }
    }
    
    return(bw.ls)
  }
  
  bw.ls <- get_coverages()
  
  get_entry_name <- function(gro) {
    
    if (gro$source == 'yasma') {
      return(list(accession=metalocus, name=locus$type))
      
    } else if (gro$source == "Rfam") {
      return(list(accession=gro$ID, name=as.vector(gro$type)))
      
    } else if (gro$source == "Earl_Grey") {
      return(list(accession=gro$ID, name=as.vector(gro$type)))
      
    } else if (gro$type == 'gene') {
      return(list(accession=as.vector(mcols(gro)$locus_tag), name=gro$Name))
      
    } else {
      return(list(accession=gro$ID, name=as.vector(gro$type)))
      
    }
    
  }
  
  size_pie <- function(xpos, ypos, s, inner=0.2, outer=0.5) {
    if (sum(s) == 0) return()
    if (length(s) == 0) return()
    # outer=1
    # inner=0.5
    
    # plot(0,0)
    # s = sizes
    s <- s[names(s)[!is.na(names(s))]]  
    
    s = c(blank=sum(s)*0.07, s, blank=sum(s)*0.07)
    s = s / sum(s) * 2 * pi  
    # s = rev(s)
    s = cumsum(s)+pi*0.5
    
    
    # p.df <- data.frame(rad=seq(0,2*pi,length.out=200))
    # p.df$piece <- NA
    
    
    
    cols = c(size_colors, 'blank'=NA)
    
    get_xy <- function(w) {
      rad_start = s[min(w)-1]
      rad_stop  = s[max(w)]
      rads = seq(rad_start, rad_stop, 0.1)
      rads = c(rads, rad_stop)
      
      # aspect_ratio = (par()$usr[4] - par()$usr[3]) / (par()$usr[2] - par()$usr[1]) * par()$din[1] / par()$din[2]
      aspect_ratio = get_aspect_ratio()
      
      ix = cos(rads) * inner + xpos
      ox = cos(rads) * outer + xpos
      iy = sin(rads) * inner * aspect_ratio + ypos
      oy = sin(rads) * outer * aspect_ratio + ypos
      
      ## donut
      x = c(ox, rev(ix), ox[1])
      y = c(oy, rev(iy), oy[1])
      
      ## pie
      # x = c(ox, 0, ox[1])
      # y = c(oy, 0, oy[1])
      
      return(data.frame(x=x,y=y))
    }
    
    for (i in seq_along(s)) {
      piece = names(s)[i]
      if (piece=='blank') next
      
      coords = get_xy(i)
      polygon(x=coords$x, y=coords$y, col=cols[piece], border=F)
      
    }
    
    
    marked_pieces = as.character(19:25)
    w = which(names(s) %in% marked_pieces)
    
    if (length(w) == 0) return()
    coords = get_xy(w)
    polygon(x=coords$x, y=coords$y, col=NA, border=T, lwd=1.2)
    
    
    
  }
  
  draw_coverages <- function() {
    
    usr.width = (par()$usr[2]-par()$usr[1])
    
    message("drawing coverages...")
    y.height = 0.4
    y.inc    = 0.6
    y.offset = -y.inc
    x = (locus$start-pad):(locus$end+pad-1)
    
    color_scale = hcl.colors(100, 'reds', rev=T)
    
    projects = unique(str_split_fixed(pas, "\\.", 3)[,2])
    # p.df = data.frame(project=str_split_fixed(pas, "\\.", 3)[,2])
    # p.df$m <- match(p.df$project, unique(p.df$project))
    # p.df$color = c('black','grey')[as.numeric(p.df$m %% 2==0)+1]
    # 
    # p.df$y = ylim+y.offset* ((1:nrow(p.df)))
    # # p.df <- p.df[p.df$bar,]
    # p.df <- cbind(
    #   dcast(p.df, project + color ~ 'y.min', value.var = 'y', fun.aggregate = min, na.rm=T),
    #   y.max=dcast(p.df, project ~ 'y.max', value.var = 'y', fun.aggregate = max, na.rm=T)[,2])
    # project_bar_x = min(x) - (par()$usr[2]-par()$usr[1])*0.03
    # segments(project_bar_x, p.df$y.min-y.inc/2, project_bar_x, p.df$y.max+y.inc/2, col=p.df$color, lwd=2)
    
    for (pa in pas) {
      ymax = switch(scale,
                    group = round(max(bw.ls$ymax_vec, na.rm=T), 1),
                    individual = round(bw.ls$ymax_vec[pa],1))
      
      
      
      for (strand in c("+", "-")) {
        for (sizing in c("other", "typical")) {
          
          ss = paste0(sizing, strand)
          y = bw.ls[[pa]][[ss]] * strand_mod[strand]
          
          ## removing mountain peaks above max
          y[y > ymax] <- ymax
          y[y < -ymax] <- -ymax
          
          ## identifying removable verticies (no change from last)
          f = !(y == c(-1, y[1:(length(y)-1)]) & y == c(y[2:length(y)], -1))
          
          y = y[f]
          xx = x[f]
          
          # lf = y == ymax
          # lwd = rep(1, l)
          
          y = y / ymax / 2 * y.height
          if (all(is.na(y))) y = rep(0, length(xx))
          lines(xx,  ylim + y.offset + y, col=sizing_color[sizing], lwd=c(1,2,3,4))
          
        }
      }
      
      # text_col = ifelse(pa %in% included_annotations, 'black', 'grey80')
      text_col = ifelse(match(str_split(pa,'\\.')[[1]][2], projects) %%2 == 0,
                        'black', 'grey70')
      # text_col = project_color_palette[project]
      text(min(x),ylim+y.offset, pa, adj=c(0,1), col=text_col, cex=0.6)
      # if (pa %in% included_annotations) points(min(x),ylim+y.offset+y.height/2, pch=19, col='red')
      if (pa %in% included_annotations) points(min(x)- usr.width*0.02, ylim+y.offset, pch=19)
      
      segments(min(x),ylim+y.offset, max(x), ylim+y.offset)
      
      # axis(2, at=ylim+y.offset + c(-y.height/2, 0, y.height/2), las=1, cex.axis=0.5 , labels = c(ymax,0,ymax))
      
      col = color_scale[round(ymax / max(bw.ls$ymax_vec, na.rm=T)*100)]
      
      par(xpd=T)
      points(min(x) - (par()$usr[2]-par()$usr[1])*0.06, ylim+y.offset, bg=col, pch=22, cex=1.5)
      text(min(x) - (par()$usr[2]-par()$usr[1])*0.06, ylim+y.offset, ymax, pos=2, cex=0.7)
      
      sizes = bw.ls[[pa]]$sizes
      sizes['non'] = 0
      for (n in names(sizes)) {
        if (!n %in% names(size_colors)) {
          sizes['non'] <- sizes['non'] + sizes[[n]]
        }
      }
      sizes <- sizes[names(size_colors)]
      sizes[is.na(sizes)] <- 0
      
      ## making size-pie-charts
      x.pie = max(x) + (par()$usr[2]-par()$usr[1])*0.03
      y.pie = ylim+y.offset
      outer = (par()$usr[2]-par()$usr[1])*0.022
      inner = outer/3.5
      # plotrix::floating.pie(xpos=x.pie, 
      #                       ypos=y.pie, 
      #                       x=sizes, 
      #                       radius=outer, 
      #                       col=size_colors,
      #                       startpos = pi*0.5)
      size_pie(x.pie, y.pie, s=sizes, outer=outer, inner=inner)
      
      y.offset = y.offset-y.inc
      
    }
    
    
    x1 = min(x) - usr.width * 0.1
    x2 = min(x) - usr.width * 0.00
    y1 = ylim
    y2 = ylim+0.2
    
    i=0
    for (xn in seq(x1, x2, length.out=100)) {
      i = i + 1
      rect(xn, y1, x2, y2, col=color_scale[i], border=NA)
    }
    rect(x1, y1, x2, y2, col=NA, border='black',lwd=1)
    text(x1, mean(c(y1,y2)), 0, pos=2, cex=0.5, offset=0.3)
    text(x2, mean(c(y1,y2)), round(max(bw.ls$ymax_vec, na.rm=T),1), pos=4, cex=0.5, offset=0.3)
    text(mean(c(x1,x2)), mean(c(y1, y2)), pos=3, str_glue("{norm}, {scale}"), cex=0.7)
    
    par(xpd=F)
    
    return(ylim+y.offset)
  }
  
  draw_gene_cartoons <- function( y, y.inc=0.3, bar.height = 0.1) {
    message("drawing gene cartoons...")
    
    par(xpd=T)
    mcols(gr) <- mcols(gr)[,c('type', 'ID', 'Parent', 'gene_biotype', 'source', 'locus_tag','Name')]
    
    window = grcoord
    window = resize(window, width=width(window)*2, fix='center')
    
    gr <- gr[overlapsAny(gr, window),]
    
    
    
    row_selector <- c(0)
    x.gap = (par()$usr[2] - par()$usr[1])*0.05
    
    
    grf = which(!gr$type %in% c('mRNA','exon'))
    for (i in grf) {
      entry.gr <- gr[i,]
      message(paste('  gene', i, entry.gr$type))
      gene = entry.gr$ID
      
      if (!is.na(entry.gr$Name) & entry.gr$Name == metalocus) {
        y.row = y #- y.inc
        
      } else {
        row_i = which(start(entry.gr) > row_selector + x.gap)[1]
        if (is.na(row_i)) {
          row_selector <- c(row_selector, end(entry.gr)) 
          row_i = length(row_selector) 
        }
        row_selector[row_i] = end(entry.gr)
        y.row = y - (row_i+2) * y.inc
      }
      
      if (!is.na(entry.gr$gene_biotype) & entry.gr$gene_biotype %in% c('rRNA','tRNA','snRNA','snoRNA','spliceosomal', 'ncRNA')) {
        entry.gr$type = entry.gr$gene_biotype
      }
      
      if (entry.gr$type == 'gene') {
        col = 'grey' 
      } else if (entry.gr$type == 'sRNA') {
        col = sRNA_color 
      } else if (entry.gr$type %in% c('rRNA','tRNA','snRNA','snoRNA','spliceosomal', 'ncRNA')) {
        col = 'maroon'
      } else {
        col = 'skyblue2'
      }
      
      
      if (entry.gr$type == 'gene') {
        mRNA.gr <- gr[gr$type == 'mRNA',]
        mRNA.gr <- mRNA.gr[unlist(mRNA.gr$Parent) == gene,]
        
        if (length(mRNA.gr) == 0) {
          
          segments(start(entry.gr),y.row, end(entry.gr), y.row, col='black', lwd=3)
          next
        }
        
        mRNA.gr <- mRNA.gr[1,]
        
        exon.gr <- gr[gr$type == 'exon',]
        exon.gr <- exon.gr[unlist(exon.gr$Parent) == mRNA.gr$ID]
        
        exon.gr$cap <- NA
        exon.gr$cap[start(exon.gr) == start(mRNA.gr) & as.vector(strand(exon.gr) == "-")] <- "<"
        exon.gr$cap[end(exon.gr) == end(mRNA.gr) & as.vector(strand(exon.gr) == "+")] <- ">"
        
        if (any(mRNA.gr@ranges != exon.gr@ranges)) {
        
          f = start(mRNA.gr) == start(exon.gr)
          if (any(f)) start(mRNA.gr) = end(exon.gr)[f]
          
          f = end(mRNA.gr) == end(exon.gr)
          if (any(f)) end(mRNA.gr) = start(exon.gr)[f]
          
          if (length(exon.gr) > 1) {
            segments(start(mRNA.gr),y.row, end(mRNA.gr), y.row, col='black', lwd=3)
          }
        }
        
        
      } else {
        exon.gr <- entry.gr
        exon.gr$cap <- switch(as.vector(strand(entry.gr)),
                              `+`=">",
                              `-`='<',
                              `*`=NA)
      }
      
      
      # col = 'grey70'
      
      
      for (ei in 1:length(exon.gr)) {
        message(paste('    exon', ei))
        
        arrow.length = min(c((par()$usr[2]-par()$usr[1]) * 0.03,
                             width(exon.gr[ei,])/2))
        
        if (is.na(exon.gr$cap[ei])) {
          rect(start(exon.gr)[ei],y.row-bar.height, end(exon.gr)[ei], y.row+bar.height, col=col)
          
        } else if (exon.gr$cap[ei] == "<") {
          polygon(c(start(exon.gr)[ei], start(exon.gr)[ei]+arrow.length, 
                    end(exon.gr)[ei], end(exon.gr)[ei],start(exon.gr)[ei]+arrow.length),
                  c(y.row, y.row+bar.height, y.row+bar.height, y.row-bar.height, y.row-bar.height),
                  col=col)
          
        } else if (exon.gr$cap[ei] == ">") {
          polygon(c(end(exon.gr)[ei], end(exon.gr)[ei]-arrow.length, 
                    start(exon.gr)[ei], start(exon.gr)[ei], end(exon.gr)[ei]-arrow.length),
                  c(y.row, y.row+bar.height, y.row+bar.height, y.row-bar.height, y.row-bar.height),
                  col=col)
        }
      }
      
      info = get_entry_name(entry.gr)
      text.x = mean(c(min(start(exon.gr)), max(end(exon.gr))))
      name_str = str_glue("{info$name}\n{info$accession}")
      
      if (info$accession == info$name) name_str = info$accession
      
      # text(text.x, y.row, name_str, adj=c(0.5,-.2), cex=0.5)
      text(text.x, y.row+bar.height, name_str, adj=c(0.5,0), cex=0.5)
      
      
    }
    
    par(xpd=F)
    return(y-(length(row_selector)+3) * y.inc)
    
  }
  
  ### Plotting
  
  strand_mod = c(`+`=1, `-`=-1)
  sizing_color = c(typical=sRNA_color, other='grey60')
  
  
  if (save) svglite(file_name, 6.3, 11.3)
  
  par(mfrow=c(1,1), 
      mar=c(5,5,5,5),
      mgp=c(3, 0.75, 0))
  
  ylim = 20
  plot(1,1,type='n', xlim=c(locus$start-pad, locus$end+pad), ylim=c(0,ylim),axes=F, ylab='', xlab='')
  
  y = draw_coverages()
  
  y = draw_gene_cartoons(y)
  
  # } 
  # else if (!is.null(context)) {
  #   yy = ylim+y.offset
  #   
  #   arrows(min(x) + (max(x)-min(x))*0.3, yy, min(x), yy, angle=20, length=0.1, lwd=2, type='closed')
  #   text(min(x), yy, str_glue("{context$before$biotype}\n{context$before$dist}nt"), adj=c(0,1))
  #   arrows(max(x) - (max(x)-min(x))*0.3, yy, max(x), yy, angle=20, length=0.1, lwd=2, type='closed')
  #   text(max(x), yy, str_glue("{context$after$biotype}\n{context$after$dist}nt"), adj=c(1,1))
  #   
  #   y = yy 
  #   
  # }
  
  par(xpd=T)
  axis(1, cex.axis=0.7, pos=y, at=axisTicks(c(start(grcoord)-width(grcoord)*0.2, end(grcoord)+width(grcoord)*0.2), log=F))
  
  x.leg = par()$usr[2] + (par()$usr[2]-par()$usr[1])*0.03
  legend(x.leg, ylim, legend=names(size_colors), fill=size_colors, bty='n', cex=0.7,
         xjust=0, yjust=1,
         title='Size')
  
  mtext(3, at=par()$usr[1], text=str_glue("metalocus: {metalocus}\nevidence: {locus$rep_evidence}\nscore: {locus$rep_score}"),
        adj=0, cex=0.5,
        line=1.2)
  
  par(xpd=F)
  text(start(grcoord)+width(grcoord)*0.5, y-1.2, paste0(locus$seqid," position (nt)"), cex=0.8)
  
  if (save) dev.off()
  if (save) ADsvg(file_name)
}

plot_metalocus()
plot_metalocus(metalocus='Cocin-2090')


plot_metalocus(metalocus='Cocin-99', save=T)
plot_metalocus(metalocus= "Nocer-930")
plot_metalocus(metalocus= 'Necra-2394')
plot_metalocus(metalocus= 'Fugra-5030')

plot_metalocus('Scscl-39')

unique(m.df$abbv)
m.df[m.df$abbv == 'Scscl',][3,]

plot_metalocus("Nocer-48")
plot_metalocus('Pustr-4')
plot_metalocus('Pyory-1197')
plot_metalocus('Mulus-88')
plot_metalocus('Necra-1051')
plot_metalocus("Fugra-1681")

plot_metalocus(metalocus = "Bocin-5134")


plot_metalocus(metalocus = "Bocin-459")
plot_metalocus("Bocin-35", save=T, force=T)

 plot_metalocus(metalocus = 'Bocin-180')
plot_metalocus("Bocin-101", save=F, force=T)
plot_metalocus("Bocin-126")
plot_metalocus("Bocin-422", pad=1000)
plot_metalocus("Bocin-551")
plot_metalocus("Bocin-689")

plot_metalocus()
plot_metalocus(scale='group')
plot_metalocus(norm='count')
plot_metalocus(scale='group', norm='count')

plot_metalocus("Bocin_25645")
plot_metalocus("Bocin_25645", norm='group')

m.df <- metalocus.df
m.df <- m.df[m.df$replication == 'binom+project+sizing',]
m.df <- m.df[order(m.df$bin_padj),]
head(m.df[m.df$abbv == 'Bocin',])
head(m.df[m.df$abbv == 'Fugra',])

plot_metalocus("Fugra-1681")
plot_metalocus("Fugra-1717")
plot_metalocus('Asapi-9')


cluster.ls$nodes[cluster.ls$nodes$cluster == 'Cl_20',]


# [x] clean up code
# [x] show yaxes as colored boxes
# [x] why do some have zero, even though proven
# [ ] display other locus attributes (confirmation status)
# [ ] highlight locus of interest among others
# [ ] show local locus name for each annotation?


# plotting them all -------------------------------------------------------


# m.df <- metalocus.df
# m.df <- m.df[m.df$replication == 'binom+project+sizing',]

m.df <- metalocus.df
m.df <- m.df[m.df$rep_score > 0 & m.df$sizing == 'typical',]

table(m.df$abbv)

for (abbv in unique(m.df$abbv) ){
# for (abbv in 'Bocin') {
  gff_files = get_gff_files(abbv)
  
  if (!file.exists(gff_files$ncbi)) next
  if (!file.exists(gff_files$rfam)) next
  if (!file.exists(gff_files$te))   next
  
  for (i in 1:sum(m.df$abbv == abbv)) {
    metalocus = m.df$metalocus[m.df$abbv == abbv][i]
    tryCatch(plot_metalocus(metalocus, save=T), error=function(e) {message(paste0("error caught!\n",e))})
  }
  
}



# playing with size profiles ----------------------------------------------

library(philentropy)


b.ls <- bw.ls
b.ls$ymax_vec <- NULL

size.df <- data.frame()
for (ann in names(b.ls)) {
  df <- as.data.frame(b.ls[[ann]]$sizes)
  names(df) <- c('size','freq')
  df$annotation <- ann
  size.df <- rbind(size.df, df)
}

size.df <- dcast(size.df, annotation ~ size, value.var='freq', fun.aggregate=sum)
rownames(size.df) <- size.df$annotation
size.df$annotation <- NULL

size.df <- size.df / rowSums(size.df)

m <- JSD(as.matrix(size.df))
# m <- distance(as.matrix(size.df), method = "kolmogorov-smirnov")
which.min(rowMeans(m))
lp <- layermap(sqrt(m), cluster_rows = F)
lp_plot_values(lp)
lp <- lp_names(lp, 3)
lp <- lp_annotate(lp, 4, as.vector(rowMeans(m)))



## notes from friday. JSD sounds like a very useful comparison. simply computes distance between two sets of numbers.

## how to tell if they are significantly similar? (i.e. from the same population)

counts_a <- c(0, 0, 5, 10, 40, 30, 10, 5, 0, 0)  # raw counts per size
counts_b <- c(0, 0, 2, 8, 35, 35, 12, 6, 2, 0)

sizes <- 15:24  # your size range

sample_a <- rep(sizes, counts_a)
sample_b <- rep(sizes, counts_b)

ks.test(rep(as.numeric(names(size.df)), size.df[4,]), 
        rep(as.numeric(names(size.df)), size.df[5,]))
