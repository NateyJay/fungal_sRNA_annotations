

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
