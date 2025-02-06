

metaloci.df <- get_metaloci.df()


get_conservation_df <- function() {
  
  conservation.df <- data.frame()
  gr.ls = list()
  for (a in unique(metaloci.df$abbv)) {
    gr <- readGFFAsGRanges(file.path("../metaloci", paste(a, ".meta.gff3", sep='')))
    gr$name <- str_replace(gr$ID, "metalocus", a)
    gr.ls[[a]] <- gr
  }
  
  for (a in unique(metaloci.df$abbv)) {
    
    for (b in unique(metaloci.df$abbv)) {
      
      if (a == b) next
      
      message(paste(a, "x", b))
      
      # a.gr <- gr.ls[[a]]
      # b.gr <- gr.ls[[b]]
      intersection_file = file.path("../conservation/02out-gffs", paste(a, '_to_', b, '.gff3', sep=''))
      
      if (!file.exists(intersection_file)) {next}
      
      i.gr <- readGFFAsGRanges(intersection_file)
      
      i.df <- as.data.frame(findOverlaps(i.gr, gr.ls[[b]]))
      
      i.df$a = i.gr$ID[i.df$queryHits]
      
      f = match(i.df$a, gr.ls[[a]]$ID)
      
      i.df$a_type     <- gr.ls[[a]]$type[f]
      i.df$a          <- gr.ls[[a]]$name[f]
      i.df$a_contig   <- as.data.frame(gr.ls[[a]])$seqnames[f]
      i.df$a_start    <- gr.ls[[a]]@ranges@start[f]
      i.df$a_length   <- gr.ls[[a]]@ranges@width[f]
      i.df$a_members  <- gr.ls[[a]]$member_loci[f]
      i.df$a_projects <- gr.ls[[a]]$member_projects[f]
        
      
      i.df$b = gr.ls[[b]]$ID[i.df$subjectHits]
      
      f = match(i.df$b, gr.ls[[b]]$ID)
      
      i.df$b_type     <- gr.ls[[b]]$type[f]
      i.df$b          <- gr.ls[[b]]$name[f]
      i.df$b_contig   <- as.data.frame(gr.ls[[b]])$seqnames[f]
      i.df$b_start    <- gr.ls[[b]]@ranges@start[f]
      i.df$b_length   <- gr.ls[[b]]@ranges@width[f]
      i.df$b_members  <- gr.ls[[b]]$member_loci[f]
      i.df$b_projects <- gr.ls[[b]]$member_projects[f]
      
      
      i.df$pident    <- i.gr$pident[i.df$queryHits]
      i.df$evalue    <- i.gr$evalue[i.df$queryHits]
      
      
      if (any(is.na(i.df$a_type))) stop()
      
      conservation.df <- rbind(conservation.df, i.df)
      
    }
  }
  
  for (c in c('evalue','pident','a_members','b_members','a_length','b_length')) {
    conservation.df[[c]] <- as.numeric(conservation.df[[c]])
  }
  
  return(conservation.df)
}

conservation.df <- get_conservation_df()





# super plot --------------------------------------------------------------

# meta.df <- get_meta.df()
# project.df <- get_project.df(meta.df)
# metaloci.df <- get_metaloci.df()
# species.df <- get_species.df()




superplot <- function(edge.df, main='') {
  ## superplot expects a edge.df that contains organism metaloci in 'a' and 'b' with lwd and col attributes
  
  genome.df <- get_genome.df()
  g.df <- genome.df
  g.df$center = g.df$tot_pos + g.df$length / 2
  
  g.df <- g.df[!duplicated(g.df$contig),]
  rownames(g.df) <- g.df$contig
  
  
  gagg.df <- dcast(genome.df, abbv ~ 'length', value.var='length', fun.aggregate = sum)
  
  gagg.df <- merge(gagg.df, species.df[,c('abbv','phylum','class','order', 'family','genus','taxid')], by='abbv')
  rownames(gagg.df) <- gagg.df$abbv
  
  gagg.df        <- gagg.df[gagg.df$abbv %in% metaloci.df$abbv,]
  
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
  
  # gagg.df$from    <- gagg.df$cum_gen - gagg.df$length
  gagg.df$from    <- gagg.df$cum_start / max(gagg.df$cum_gen) * 2*pi
  gagg.df$center  <- (gagg.df$cum_start + gagg.df$length / 2 ) / max(gagg.df$cum_gen) * 2*pi
  gagg.df$center.x <- sqrt(text_radius) * cos(gagg.df$center)
  gagg.df$center.y <- sqrt(text_radius) * sin(gagg.df$center)
  
  
  
  # e.df <- edge.df
  # 
  # if (is.null(e.df$col)) e.df$col = 'black'
  # if (is.null(e.df$lwd)) e.df$lwd = 1
  

  # e.df$a_radians <- (g.df$center[match(e.df$a_contig, g.df$contig)] + gagg.df$cum_start[match(e.df$a, gagg.df$abbv)]) / max(gagg.df$cum_gen) * 2*pi
  # e.df$b_radians <- (g.df$center[match(e.df$b_contig, g.df$contig)] + gagg.df$cum_start[match(e.df$b, gagg.df$abbv)]) / max(gagg.df$cum_gen) * 2*pi
  # 
  # e.df$ax <- cos(e.df$a_radians)
  # e.df$ay <- sin(e.df$a_radians)
  # 
  # e.df$bx <- cos(e.df$b_radians)
  # e.df$by <- sin(e.df$b_radians)
  
  

  
  # e.df$cont_radians = apply(e.df[,c("a_radians", 'b_radians')], 1, mean)
  # e.df$cx <- sqrt(0.25) * cos(e.df$cont_radians)
  # e.df$cy <- sqrt(0.25) * sin(e.df$cont_radians)
  
  
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
    # contig_lines(a_contigs="JAYMDH010000005.1", b_contigs='WWBZ02000016.1', lwd=3, col='green')
    
  }
  
  # segments(e.df$ax, e.df$ay, e.df$bx, e.df$by, lwd =e.df$lwd)
  
  par(mar=c(1,1,1,1))
  plot(1,1, type='n', xlim=c(-1.2,1.2), ylim=c(-1.2,1.2), axes=F,
       main=main)
  
  # for (i in 1:nrow(e.df)) {
  #   mat = matrix(c(e.df$ax[i], e.df$cx[i], e.df$bx[i], e.df$ay[i], e.df$cy[i], e.df$by[i]), ncol=2, byrow = F)
  #   lines(bezier::bezier(t, mat), lwd=e.df$lwd[i], col=e.df$col[i])
  # }
  # mat = matrix(c(e.df$))
  # bezier()
  
  draw_arcs <- function() {
    for (gi in 1:nrow(gagg.df)) {
      plotrix::draw.arc(x=0, y=0, radius = 1, gagg.df$from[gi], gagg.df$to[gi], lwd=10, col= phylum_colors[gagg.df$phylum[gi]])
    }
  }
  
  # f = gagg.df$center.x < 0
  
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
sp$draw_arcs()


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

context.df <- get_context.df()
c.df <- context.df
c.df$name <- str_replace(c.df$ID, "metalocus", c.df$abbv)


e.df <- conservation.df

e.df <- e.df[e.df$a_type != "OtherRNA" & e.df$b_type != "OtherRNA",]
e.df <- e.df[e.df$a != e.df$b,]

e.df <- e.df[e.df$a_members > 1 | e.df$b_members > 1,]



e.df

e.df$a_context <- c.df$category[match(e.df$a, c.df$name)]
e.df$b_context <- c.df$category[match(e.df$b, c.df$name)]

e.df <- e.df[e.df$a_context %in% c('intergenic','near-genic'),]
e.df <- e.df[e.df$b_context %in% c('intergenic','near-genic'),]


e.df <- dcast(e.df, a + a_contig + b + b_contig ~ 'count', fun.aggregate = length)

e.df <- e.df[order(e.df$count),]

e.df$lwd = 0.15
e.df$lwd[e.df$count > 5] <- 0.25
e.df$lwd[e.df$count > 25] <- 0.5
e.df$lwd[e.df$count > 50] <- 0.75
e.df$lwd[e.df$count > 100] <- 1



sp = superplot(e.df, main='View 6 - non-genic loci')

sp$contig_lines(e.df$a_contig, e.df$b_contig, lwd=e.df$lwd, col='black')
# sp$contig_lines(a_contig="JAYMDH010000005.1", b_contig='WWBZ02000016.1', lwd=3, col='orange')
sp$draw_arcs()



# View 7 - hairpins -------------------------------------------------------

e.df <- conservation.df
e.df <- e.df[e.df$a_type != "OtherRNA" & e.df$b_type != "OtherRNA",]
e.df <- e.df[e.df$a != e.df$b,]

na.df <- new_annotation.df
na.df$key <- str_c(na.df$project, na.df$annotation, na.df$ID, sep='.')
na.df$ml_name <- str_replace(na.df$metalocus, "metalocus", na.df$abbv)
  
  
hp.df <- hairpin.df
hp.df$key <- str_c(hp.df$project, hp.df$cond, hp.df$name, sep='.')
hp.df$metalocus <- na.df$ml_name[match(hp.df$key, na.df$key)]

hp.df <- hp.df[!is.na(hp.df$metalocus),]

hp.df$ruling_desc[hp.df$ruling == 'x x xx xx x -'] <- "near_miRNA"
hp.df$ruling_desc[hp.df$ruling == 'x x xx xx x x'] <- "miRNA"

e.df$a_ruling <- hp.df$ruling_desc[match(e.df$a, hp.df$metalocus)]
e.df$b_ruling <- hp.df$ruling_desc[match(e.df$b, hp.df$metalocus)]


e.df$a_ruling[is.na(e.df$a_ruling)] <- '-'
e.df$b_ruling[is.na(e.df$b_ruling)] <- '-'

resolve_ruling <- function(x) {
  if (length(unique(x)) == 1) return(unique(x))
  
  if ("miRNA" %in% x) return("miRNA")
  if ("near_miRNA" %in% x) return("near_miRNA")
  return("-")
}



e.df$ruling <- apply(e.df[,c('a_ruling','b_ruling')], 1, resolve_ruling)
e.df <- e.df[e.df$ruling != '-',]

e.df <- e.df[e.df$ruling == 'miRNA',]

table(e.df$a)
table(e.df$b)

sp = superplot(e.df, main='View 7 - miRNAs')

sp$contig_lines(e.df$a_contig, e.df$b_contig, lwd=e.df$lwd, col='black')
# sp$contig_lines(a_contig="JAYMDH010000005.1", b_contig='WWBZ02000016.1', lwd=3, col='orange')
sp$draw_arcs()


get_eps_file = function(ml) {
  abbv = str_sub(ml, 1, 5)
  # ml = str_replace(ml, abbv, "metalocus")
  
  na.df <- new_annotation.df[new_annotation.df$name == ml,]
  na.df$key <- str_c(na.df$project, na.df$annotation, na.df$ID, sep='.')
  
  
  hp.df <- hairpin.df
  hp.df$key <- str_c(hp.df$project, hp.df$cond, hp.df$name, sep='.')
  
  hp.df[hp.df$key %in% na.df$key,]
  
  hp.df <- hairpin.df[hairpin.df$project %in%]
  
}

# cytoscape ---------------------------------------------------------------


library(RCy3)
cytoscapePing ()
cytoscapeVersionInfo ()


node.df <- species.df
node.df <- node.df[node.df$abbv %in% metaloci.df$abbv,]
node.df$id <- node.df$abbv


edge.df <- c.df
head(edge.df)

edge.df$source <- str_sub(edge.df$a, 1,5)
edge.df$target <- str_sub(edge.df$b, 1,5)
edge.df <- dcast(edge.df, source + target ~ 'weight', fun.aggregate = length)
edge.df$weight <- edge.df$weight / 300
edge.df$weight[edge.df$weight > 300] <- 300

createNetworkFromDataFrames(node.df,edge.df, title="all edges")

layoutNetwork('attributes-layout')

?layoutNetwork
