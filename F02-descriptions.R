

## thinking more locus-centric here



# ridgeline of lengths ----------------------------------------------------

a.df <- annotation.df
a.df <- a.df[a.df$size_1n %in% str_glue("({18:28},)"),]
a.df <- a.df[a.df$f_all,]

a.df <- a.df[a.df$project %in% project.df$project[project.df$f_pass],]


ps = unique(a.df$project)

height_factor = 1.5


plot(1,1,type='n',xlim=c(0,2000), ylim=c(0,length(ps)*height_factor), xlab='Locus length', ylab='', axes=F)
axis(1)

for (i in 1:length(ps)) {
  project = ps[i]
  
  aa.df <- a.df[a.df$project == project,]
  
  
  if (any(is.na(aa.df$Length))) next
  if (nrow(aa.df) < 5) next
  
  tab = table(aa.df$size_1n)
  names(tab) <- str_sub(names(tab), 2,3)
  main_size = names(tab[which.max(tab)])
  
  
  d = density(aa.df$Length)
  
  d$scaled.y <- d$y / max(d$y) + i*height_factor -1
  
    
  lines(d$x, d$scaled.y, xlim=xlim, type='l')
  polygon(d$x, d$scaled.y, col=scales::alpha(size_colors[main_size], 0.5))
}



# heatmap of lengths ----------------------------------------------------



locus_heat_and_length <- function() {
  
  
  a.df <- annotation.df
  a.df <- a.df[a.df$size_1n %in% str_glue("({18:28},)"),]
  a.df <- a.df[a.df$f_all,]
  
  a.df <- a.df[a.df$project %in% project.df$project[project.df$f_pass],]
  
  
  a.df$primary_size <- str_sub(a.df$size_1n, 2,3)
  a.df$primary_size
  
  d.df <- dcast(a.df, project ~ primary_size)
  head(d.df)
  
  
  rownames(d.df) <- d.df$project
  d.df$project <- NULL
  
  d.df <- d.df / rowSums(d.df)
  
  row.df <- d.df
  row.df$abbv <- str_sub(rownames(row.df), 1, 5)
  
  tab = table(a.df$project)
  row.df$count <- tab[rownames(row.df)]
  
  par(mar=c(5,8,5,1.5),
      mfrow=c(1,2))
  
  lp <- layermap(d.df, palette='oranges', 
                 zlim=c(0, 0.25),
                 row.df=row.df)
  
  lp <- lp_names(lp, 2, 'abbv')
  lp <- lp_names(lp, 3)
  lp <- lp_names(lp, 4, 'count')
  
  
  out.df <- data.frame()
  
  for (size in as.character(19:27)) {
    
    aa.df <- a.df[a.df$primary_size == size,]
    
    d = aa.df$Length
    
    d.df <- data.frame()  
        
    
  }
  
  ps <- unique(lp$plotting.df$rows)
  
  par(xpd=F,
      mar=c(5,1,5,9))
  
  # a.df$project <- factor(a.df$project, levels = ps)
  # 
  # boxplot(a.df$Length ~ a.df$project, horizontal = T,
  #         outline=F,
  #         ylim=c(0,3000),
  #         xlim = c(3,length(ps)-2),
  #         names=rep("", length(ps)),
  #         axes=F,
  #         staple=F)
  # axis(1)
  
  plot(1,1,type='n',xlim=c(0,2000), ylim=c(4,length(ps)*height_factor-3.5), xlab='Locus length', ylab='', axes=F)
  axis(1)

  for (i in 1:length(ps)) {
    project = ps[i]

    aa.df <- a.df[a.df$project == project,]


    if (any(is.na(aa.df$Length))) {points(0, i*height_factor -1); next}
    if (nrow(aa.df) < 5) {points(0, i*height_factor -1); next}

    tab = table(aa.df$size_1n)
    names(tab) <- str_sub(names(tab), 2,3)
    main_size = names(tab[which.max(tab)])


    d = density(aa.df$Length)

    d$scaled.y <- d$y / max(d$y) + i*height_factor -1


    lines(d$x, d$scaled.y, xlim=xlim, type='l')
    polygon(d$x, d$scaled.y, col=scales::alpha(size_colors[main_size], 0.5))
  }
  
}

locus_heat_and_length()





# Locus adjacency ---------------------------------------------------------


a.df <- annotation.df
a.df <- a.df[a.df$size_1n %in% str_glue("({18:28},)"),]
a.df <- a.df[a.df$f_all,]

a.df <- a.df[a.df$project %in% project.df$project[project.df$f_pass],]


a.df$primary_size <- str_sub(a.df$size_1n, 2,3)
a.df$primary_size


ps = unique(a.df$project)



p.df <- project.df[project.df$project %in% ps,]



for (abbv in unique(p.df$abbv)) {
  message(abbv)
  
  gff_file = Sys.glob(str_glue("../+genomes/{abbv}.*genomic.gff*"))
  
  
  if (length(gff_file) == 0) {message("^^^ annotation not found"); next}
  
  flank_length = 1000
  bin_count    = 50
  
  my_filter <- list(type=c("mRNA"))
  g.gr <- GRanges(rtracklayer::readGFF(gff_file, filter=my_filter))
  start(g.gr) = start(g.gr) - flank_length
  end(g.gr) = end(g.gr) + flank_length
  
  for (project in p.df$project[p.df$abbv %in% abbv]) {
    
    abbv = 'Bebas'
    project = 'Bebas.PRJNA647702'
    
    message("...", project)
    # loci_gff_file = file.path("/Volumes/fungal_srnas/+annotations", project, "tradeoff/loci.gff3")
    bam_file = file.path("/Volumes/fungal_srnas/+annotations", project, "align/alignment.bam")
    
    # if (!file.exists(loci_gff_file)) message("^^^ locus annotation not found")
    
    aa.df <- a.df[a.df$project == project,]
    # a.gr <- GRanges(readGFF(loci_gff_file))
    # a.gr
    a.gr <- GRanges(aa.df$Locus)
    
    gg.gr <- suppressWarnings(g.gr[overlapsAny(g.gr, a.gr)])
    param <- ScanBamParam(which = gg.gr, what = c('pos', 'strand'))
    
    alns = scanBam(bam_file, param=param)
    
    out.df = data.frame()
    
    for (i in 1:length(alns)) {
      cat(".")
      pos = alns[[i]]$pos - start(gg.gr[i])
      gene_length = width(gg.gr[i]) - flank_length * 2
      gene_size_factor = flank_length / gene_length
      
      
      pos5 = pos[pos < flank_length]
      posB = pos[pos >= flank_length & pos <= flank_length + gene_length] - flank_length
      pos3 = pos[pos > flank_length + gene_length] - flank_length - gene_length
      
      pos5 = round(pos5 / flank_length * bin_count)
      posB = round(posB / gene_length * bin_count)
      pos3 = round(pos3 / flank_length * bin_count)
      
      norm_pos = c(pos5, posB+bin_count, pos3+bin_count*2)
      
      
      weights = ifelse( norm_pos < bin_count | norm_pos > bin_count*2, 1, flank_length/gene_length)
      
      d = density(norm_pos, weights= weights)
      
      d$rounded_x <- round(d$x*2)/2
      d$scaled_y <- d$y / max(d$y)
      
      f = d$rounded_x >= 0 & d$rounded_x <= bin_count*3 & !duplicated(d$rounded_x)
      df <- data.frame(x=d$rounded_x[f], y=d$scaled_y[f])
      
      df$aln_num = i
      
      out.df <- rbind(out.df, df)
      
      # plot(d, xlim=c(0, bin_count*3), axes=F, ylab='', xlab='')
      # abline(v=c(bin_count,bin_count*2))
      
    }
    
    
    out.df <- dcast(out.df, aln_num ~ y, value.var='x', f)
    
    
    
    
  }
    
}







# Another try at the metaplot ---------------------------------------------


a.df <- annotation.df
a.df <- a.df[a.df$size_1n %in% str_glue("({18:28},)"),]
a.df <- a.df[a.df$f_all,]

a.df <- a.df[a.df$project %in% project.df$project[project.df$f_pass],]


a.df$primary_size <- str_sub(a.df$size_1n, 2,3)
a.df$primary_size


ps = unique(a.df$project)



p.df <- project.df[project.df$project %in% ps,]

dir.create("F02-meta_matricies", showWarnings = FALSE)

project_mats = list()
for (abbv in unique(p.df$abbv)) {
  message(abbv)
  
  gff_file = Sys.glob(str_glue("../+genomes/{abbv}.*genomic.gff*"))
  if (length(gff_file) == 0) {message("^^^ gene annotation not found"); next}
  
  flank_length = 1000
  bin_count    = 50
  
  my_filter <- list(type=c("mRNA"))
  g.gr <- GRanges(rtracklayer::readGFF(gff_file, filter=my_filter))
  start(g.gr) = start(g.gr) - flank_length
  end(g.gr) = end(g.gr) + flank_length
  
  
  meta_file = str_glue("../clustering_annotations/{abbv}.meta.gff3")
  
  if (!file.exists(meta_file)) {message("^^^ meta annotation not found"); next}
  
  m.gr <- GRanges(rtracklayer::readGFF(meta_file))
  m.gr <- m.gr[m.gr$sizecall %in% make_dicer_sizes(19:23),]
  # m.gr <- m.gr[m.gr@strand@values == '*',]
  m.gr <- m.gr[m.gr$member_loci > 1,]
  
  stop("i switched this to just look at replicated loci - worth a shot.")
  
  
  
  
  i.gr <- suppressWarnings(g.gr[overlapsAny(g.gr, m.gr)])
  
  for (project in p.df$project[p.df$abbv == abbv]) {
    message("...", project)
    
    bw_file = file.path("../+annotations", project, "coverage/all.bw")
    if (!file.exists(meta_file)) {message("^^^ meta annotation not found"); next}
    # project_mats[[project]] = matrix(ncol=3000)
    
    om = matrix(ncol=3000)
    
    print(length(i.gr))
    
    
    for (i in 1:length(i.gr)) {
      cat('.')
      cov <- import.bw(bw_file, which=i.gr[i])

      gene_width = width(i.gr[i]) - flank_length * 2
      
      
      # x = 1:gene_width
      # y = rep(cov$score, width(cov))
      
      x5 = 1:(flank_length-1)
      xB = (1:gene_width) / gene_width * flank_length + flank_length
      x3 = (flank_length * 2) : (flank_length * 3)
      
      x = c(x5, xB, x3)
      y = rep(cov$score, width(cov))
      
      if (i.gr[i]@strand@values == "-") {
        x = rev(x)
      }
      
      # intx <- round(x)
      # f <- !duplicated(intx)
      # intx <- intx[f]
      # y    <- y[f]
      
      
      k = ksmooth(x,y, bandwidth=100)
      k$intx <- round(k$x)
      k$f <- !duplicated(k$intx)
      
      intx <- k$intx[k$f]
      inty <- k$y[k$f]
      
      
      # plot(x, y, type='l')
      # lines(intx, inty, type='l', col='blue', lwd=2)
      # abline(v=c(1000,2000), lwd=2, col='red')

      
      om <- rbind(om, k$y[k$f])
      # project_mats[[project]] <- rbind(project_mats[[project]], k$y[k$f])
      
      # plot(cov.df@ranges@start, cov.df$score, type='l')
      
    }
    
    write.table(om, 
                file=file.path('F02-meta_matricies', str_glue("{project}.txt")),
                quote=F, sep='\t')
    # om <- project_mats[[project]]
    # som <- t(scale(t(om)))
    
    
    
    # plot(1:3000, colMeans(om, na.rm = T), type='l', main=project)
    # plot(1:3000, apply(om, 2, median, na.rm = T), type='l', main=project)
    
  }

}








# meta_packing ------------------------------------------------------------

## how many of all loci are found for each project

## how many of these are sRNA loci?
## how many are packed?



p.df <- project.df
p.df <- p.df[p.df$f_pass,]

a.df <- annotation.df
a.df <- a.df[a.df$project %in% p.df$project,]
a.df <- a.df[a.df$f_all,]

tab = table(a.df$project)
tab = as.data.frame(tab)

df <- data.frame(tab)
names(df) <- c('project', 'count')
df$abbv <- str_sub(df$project, 1, 5)
df$genus <- species.df$genus[match(df$abbv, species.df$abbv)]

df$genus_order <- match(df$genus, phylogeny$tip.label)

df$genus_order[df$genus == "Nosema"] <- max(df$genus_order, na.rm=T) + 1
df$class <- species.df$class[match(df$abbv, species.df$abbv)]


df <- df[rev(order(df$count)),]
# df <- df[order(df$abbv),]
df <- df[order(df$genus_order),]

count_occurences <- function(x) {
  out = c()
  for (i in 1:length(x)) {
    
    out = c(out, sum(x[1:i] == x[i]))
    
    
  }
  return(out)
}


df$abbv_num <- count_occurences(df$abbv)

c.df <- dcast(df, abbv ~ abbv_num, value.var = 'count')
c.df
rownames(c.df) <- c.df$abbv
c.df$abbv <- NULL

row.df <- c.df
row.df$abbv <- str_sub(rownames(c.df), 1, 5)
row.df$class <- species.df$class[match(row.df$abbv, species.df$abbv)]


lp <- layermap(c.df,
               row.df=row.df,
               row_groups = 'class', 
               palette='reds')
lp <- lp_names(lp, 2)


lp_plot_values(lp)




# meta loci per organism --------------------------------------------------



ml.df <- metaloci.df
ml.df$degradation_product <- ifelse(metaloci.df$type == 'OtherRNA', "OtherRNA", "sRNA")
ml.df$clustered <- ifelse(ml.df$meta_defined_locus == 'True', "clustered", "solitary")

tab <-table(abbv=ml.df$abbv, deg=ml.df$degradation_product, clust=ml.df$clustered)

df <- data.frame(tab)
df <- dcast(df, abbv ~ deg + clust)

rownames(df) <- df$abbv
df$abbv <- NULL

row.df <- species.df[rownames(df),]
col.df <- as.data.frame(str_split_fixed(names(df), "_", 2))
rownames(col.df) <- names(df)
names(col.df) <- c('RNA', 'meta-clustering')



par(mar=c(5,15,10,2))
lp <- layermap(df, palette='oslo', reverse_palette = F,
               row.df =row.df,
               row_groups = 'class',
               col.df = col.df,
               column_groups = 'RNA')

lp <- lp_names(lp, 3, 'meta-clustering')
lp <- lp_names(lp, 2)

lp <- lp_group(lp, 3, 'RNA', gap=3, col=c(OtherRNA='grey20', sRNA='lightblue'))

lp_plot_values(lp)




# 02-A counts of metaloci ----------------------------------------------------

# metaloci.df <- get_metaloci.df()

make_metalocus_bars <- function(save=F) {
  ml.df <- metaloci.df
  # ml.df$degradation_product <- ifelse(metaloci.df$type == 'OtherRNA', "OtherRNA", "sRNA")
  ml.df$clustered <- ifelse(ml.df$meta_defined_locus == 'True', "clustered", "solitary")
  ml.df <- ml.df[ml.df$type != 'OtherRNA',]
  
  p.df <- project.df
  p.df$annotation_count <- str_count(p.df$conditions, ",") + 1
  proj_tab <- table(p.df$abbv)
  rep_tab <- dcast(p.df, abbv ~ 'annotation_count', value.var='annotation_count', fun.aggregate = sum)
  
  
  tab <-table(abbv=ml.df$abbv, clust=ml.df$clustered)
  tab = data.frame(tab)
  tab <- dcast(tab, abbv ~ clust)
  rownames(tab) <- tab$abbv
  
  tab$project_count <- proj_tab[tab$abbv]
  tab$rep_count <- rep_tab$annotation_count[match(tab$abbv, rep_tab$abbv)]
  
  # tab <- tab[order(tab$project_count),]
  tab <- tab[order(tab$rep_count),]
  
  
  ptab <- tab[,c('clustered', 'solitary')] / rowSums(tab[,c('clustered', 'solitary')])
  
  col = c('darkslategrey', 'lavenderblush2')
  
  file_name = "F02-metalocus_replication.svg"
  if (save) svglite(file_name, 4.7, 6.0)
  
  par(mfrow=c(1,3))
  par(mar=c(4,6,4,1.5))
  par(mgp=c(2,0.75,0))
  
  barplot(t(ptab), horiz=T, las=1,
          xlab='Prop.',
          col = col)
  
  par(xpd=T)
  text(1.2, 1:nrow(tab)*1.2-0.6, tab$rep_count)
  par(xpd=F)
  
  par(mar=c(4,0.5,4,2))
  barplot(t(tab[,c('clustered', 'solitary')]), horiz=T,
          names.arg = rep("", nrow(ptab)),
          xlab='Meta Loci',
          col = col)
  
  plot.new()
  
  legend('left', c('replicated', 'only one'), fill=col, inset=0.01)
  
  if (save) dev.off()
  if (save) ADsvg(file_name)
}

make_metalocus_bars(T)


## Just the passing ones

par(mar=c(4,5,4,2), mfrow=c(1,1))
barplot(t(tab[,c('clustered'),drop=F]), horiz=T,
        xlab='Meta Loci',
        col = col,las=1)

# checking stranding ------------------------------------------------------



ml.df <- metaloci.df
# ml.df$degradation_product <- ifelse(metaloci.df$type == 'OtherRNA', "OtherRNA", "sRNA")
ml.df$clustered <- ifelse(ml.df$meta_defined_locus == 'True', "clustered", "solitary")
ml.df <- ml.df[ml.df$type != 'OtherRNA',]
ml.df$pstrand <- abs(ml.df$fracTop -0.5) * 2

ml.df$abbv <- factor(ml.df$abbv, levels=rev(unique(ml.df$abbv)))



par(mar=c(4,5,5,2), mfrow=c(1,1))
boxplot(ml.df$pstrand ~ ml.df$abbv, horizontal=T, las=1, outline=F,
        ylab='', xlab='Percent stranded')

tab = table(ml.df$strand, ml.df$abbv)
tab




# checking lengths --------------------------------------------------------


ml.df <- metaloci.df
# ml.df$degradation_product <- ifelse(metaloci.df$type == 'OtherRNA', "OtherRNA", "sRNA")
ml.df$clustered <- ifelse(ml.df$meta_defined_locus == 'True', "clustered", "solitary")
ml.df <- ml.df[ml.df$type != 'OtherRNA',]

ml.df$abbv <- factor(ml.df$abbv, levels=rev(unique(ml.df$abbv)))



par(mar=c(4,5,5,2), mfrow=c(1,1))
boxplot(ml.df$length ~ ml.df$abbv, horizontal=T, las=1, outline=F,
        ylab='', xlab='Meta locus length', ylim = c(0,5000))

tab = table(ml.df$strand, ml.df$abbv)
tab



# sRNA expression ---------------------------------------------------------



# metaloci.df <- get_metaloci.df()

ml.df <- metaloci.df

for (abbv in unique(ml.df$abbv)) {
  
  m.df <- ml.df[ml.df$abbv == abbv,]

  plot(1,1, type='n', xlim=c(0, 100), ylim=c(0,1), xlab='RPM', ylab='Prop',
       las=1,
       main=abbv)
  
  lines(ecdf(m.df$rpm[m.df$type == "OtherRNA"]), verticals=T, do.points=F)
  lines(ecdf(m.df$rpm[m.df$type != "OtherRNA"]), verticals=T, do.points=F,
        col='blue', lwd=2)
  
  
}





# meta loci distance to gene ----------------------------------------------

p.df <- project.df

# ml.df$degradation_product <- ifelse(metaloci.df$type == 'OtherRNA', "OtherRNA", "sRNA")
# ml.df$clustered <- ifelse(ml.df$meta_defined_locus == 'True', "clustered", "solitary")
# ml.df <- ml.df[ml.df$type != 'OtherRNA',]




plot_context_bars <- function(save=F) {
  
  ml.df <- metaloci.df
  colors = context_colors
  
  f = ml.df$type != 'OtherRNA'
  # f = ml.df$type != 'OtherRNA' & as.numeric(ml.df$member_loci) > 1
  
  ml.df$context <- str_replace(ml.df$context, "mRNA|tRNA|rRNA|spliceosomal", 'genic')
  ml.df <- ml.df[f,]
  
  
  tab = table(ml.df$abbv, ml.df$context)
  tab <- tab[rowSums(tab) > 0,]
  
  tab = tab[rev(rownames(tab)),]
  
  
  y = 1:nrow(tab) - 0.5
  xmax = 2500
  # par()$din 5.14, 7.3
  
  
  file_name="F02-metaloci_contexts.svg"
  if (save) svglite(file_name, 4.11, 6.47)
  
  layout(matrix(c(3,2,1,5,4), nrow=1), widths=c(0.5,0.2,1,0.2,1))
  par(mar=c(4,5,4,0))
  
  
  par(mar=c(4,0.2,4,2))
  b=barplot(t(tab[,c("intergenic","near-genic")]), horiz=T, las=1, col=colors, main='intergenic',
          xlim=c(0,xmax), names.arg = rep("", nrow(tab)), space=0.5)
  
  par(mar=c(4,0,4,0))
  plot(1,1,type='n', xlim=c(0,1), ylim=c(0.5, max(b)+0.5), axes=F, xlab='', ylab='')
  
  for (t in 1:nrow(tab)) {
    vals = unlist(tab[t,c('intergenic','near-genic')])
    if (sum(vals) == 0) next
    plotrix::floating.pie(0.5, b[t], x=vals, radius=0.3,
                          col=colors[1:2])
  }
  
  plot(1,1,type='n', xlim=c(0,1), ylim=c(0.5, max(b)+0.5), axes=F, xlab='', ylab='')
  text(1, b, rownames(tab), pos=2, cex=1.5)
  
  
  
  
  par(mar=c(4,0.2,4,2))
  b = barplot(t(tab[,c("unstranded_genic", "antisense_genic", "sense_genic")]), horiz=T, las=1, col=colors[3:5], main='genic', 
          xlim=c(0,xmax),names.arg = rep("", nrow(tab)), space=0.5)
  
  
  par(mar=c(4,0,4,0))
  plot(1,1,type='n', xlim=c(0,1), ylim=c(0.5, max(b)+0.5), axes=F, xlab='', ylab='')
  
  for (t in 1:nrow(tab)) {
    vals = unlist(tab[t,c("unstranded_genic", "antisense_genic", "sense_genic")])
    if (sum(vals) == 0) next
    plotrix::floating.pie(0.5, b[t], 
                          x=vals, 
                          radius=0.3,
                          col=colors[3:5])
  }

  if (save) dev.off()
  if (save) ADsvg(file_name)
  
}
plot_context_bars(F)

plot.new()
legend('topleft', names(context_colors), fill=context_colors, title='context')


# what gene types? --------------------------------------------------------

plot_gene_types <- function() {
  
  ml.df <- metaloci.df
  ml.df <- ml.df[ml.df$member_loci > 1,]
  ml.df <- ml.df[ml.df$sizecall != "N",]
  
  ml.df$context <- str_replace(ml.df$context, "sense_|antisense_|unstranded_", "")
  
  table(ml.df$context)
  
  
  tab <- table(ml.df$abbv, ml.df$context)
  # tab[,c('intergenic', 'near-genic', 'rRNA','tRNA','mRNA','spliceosomal')]
  tab <- tab[,names(deep_context_colors)]
  ptab <- tab / rowSums(tab)
  
  par(mar=c(5,10,4,10), mfrow=c(1,1))
  barplot(t(ptab), horiz=T, las=1, col=deep_context_colors, xlab='Prop.')
  par(xpd=T)
  legend('topright', names(deep_context_colors), fill=deep_context_colors, cex=0.8,
         inset=c(-0.9,0))
  par(xpd=F)
  
  
}

plot_gene_types()

# What sizes? -------------------------------------------------------------


ml.df <- metaloci.df


ml.df <- ml.df[ml.df$type != 'OtherRNA',c('abbv','sizecall','type', 'rpm')]

ml.df$scaled_rpm <- ml.df$rpm / str_count(ml.df$type, "_")
ml.df <- cbind(ml.df, str_split_fixed(ml.df$sizecall, "_", 3))

ml.df <- melt(ml.df[,c('abbv','scaled_rpm','1','2','3')], id.vars=c('scaled_rpm','abbv'))
ml.df <- ml.df[ml.df$value != '',]
ml.df <- dcast(ml.df, abbv ~ value, value.var='scaled_rpm', fun.aggregate = sum)


val.df <- ml.df
rownames(val.df) <- val.df$abbv
val.df$abbv <- NULL
val.df <- val.df / 1000000

par(mar=c(4,10,5,2), mfrow=c(1,1))
lp <- layermap(val.df, palette='reds',
               zlim=c(0, 0.25))
lp <- lp_names(lp, 2)
lp <- lp_names(lp, 3)

