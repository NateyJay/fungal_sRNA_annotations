

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
  
  p.df <- project.df[!is.na(p.df$f_pass) & p.df$f_pass,]
  p.df$annotation_count <- str_count(p.df$conditions, ",") + 1
  proj_tab <- table(p.df$abbv)
  rep_tab <- dcast(p.df, abbv ~ 'annotation_count', value.var='annotation_count', fun.aggregate = sum)
  
  ml.df <- ml.df[ml.df$abbv %in% p.df$abbv,]
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

make_metalocus_bars(F)


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
  ml.df <- ml.df[ml.df$member_loci > 1,]
  colors = context_colors
  
  f = ml.df$type != 'OtherRNA'
  # f = ml.df$type != 'OtherRNA' & as.numeric(ml.df$member_loci) > 1
  
  ml.df$context <- str_replace(ml.df$context, "mRNA|tRNA|rRNA|spliceosomal", 'genic')
  ml.df <- ml.df[f,]
  
  
  tab = table(ml.df$abbv, ml.df$context)
  tab <- tab[rowSums(tab) > 0,]
  
  tab = tab[rev(rownames(tab)),]
  
  
  y = 1:nrow(tab) - 0.5
  # xmax = 2500
  xmax=1500
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
plot_context_bars(T)

plot.new()
legend('topleft', names(context_colors), fill=context_colors, title='context')


# what gene types? --------------------------------------------------------

plot_gene_types <- function(save=F) {
  
  
  
  ml.df <- metaloci.df
  ml.df <- ml.df[ml.df$sizecall != "N",]
  ml.df <- ml.df[ml.df$member_loci > 1,]
  
  ml.df$context <- str_replace(ml.df$context, "sense_|antisense_|unstranded_", "")
  
  table(ml.df$context)
  
  
  tab <- table(ml.df$abbv, ml.df$context)
  tab <- tab[rev(unique(ml.df$abbv)),]
  tab <- tab[rowSums(tab) > 0,]
  # tab[,c('intergenic', 'near-genic', 'rRNA','tRNA','mRNA','spliceosomal')]
  tab <- tab[,names(deep_context_colors)]
  ptab <- tab / rowSums(tab)
  
  file_name="F02-metaloci_gene_types.svg"
  if (save) svglite(file_name, 4.11, 6.47)
  
  par(mar=c(5,5,4,10), mfrow=c(1,1))
  barplot(t(ptab), horiz=T, las=1, col=deep_context_colors, xlab='Prop.')
  par(xpd=T)
  legend('topright', names(deep_context_colors), fill=deep_context_colors, cex=0.8,
         inset=c(-1.3,0))
  par(xpd=F)
  
  if (save) dev.off()
  if (save) ADsvg(file_name)
  
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





# metalocus replication  ---------------------------------------------

m.df <- metaloci.df

## how many are replicated?
table(m.df$member_projects)


## how many are replicated and likely real??
tab = table(member_projects=m.df$member_projects, sizing=m.df$sizing)
tab = tab[as.character(1:max(as.numeric(row.names(tab)))),]
tab[,c('other','atypical','typical')]
apply(tab[as.character(rownames(tab)) >= 2,], 2, sum)

barplot(t(tab[,1]))
barplot(t(tab[,2]))

m.df[m.df$member_projects==12 & m.df$sizing == 'atypical',]
m.df[m.df$member_projects>20 & m.df$sizing == 'typical',]

## over 50% project replication?

tab = table(rep50=m.df$frac_replicated >= 0.5, sizing=m.df$sizing)
tab
barplot(tab, beside=T)

## in what organisms?
f = m.df$total_projects >= 2
tab = table(abbv=m.df$abbv[f], confident=m.df$frac_replicated[f] >= 0.5 & m.df$sizing[f]=='typical')
tab
barplot(tab[rev(rownames(tab)), "TRUE"], horiz=T, las=1, cex.names=1, xlab='sRNA genes')
par(xpd=T)
text(0, (nrow(tab):1)*1.2-.6, rep_tab[rownames(tab)], pos=2, cex=0.8, offset=0.2)
par(xpd=F)


## gini across organisms
f = m.df$replication != 'None' & m.df$sizing == 'typical'
tab = table(abbv=m.df$abbv[f])
y <- cumsum( sort(tab) ) / sum(tab)
x <- 1:length(y) / length(y)

plot(x, y, type='l', las=1, ylab='Cumu. prop. of loci', xlab='Cumu. prop. of species', lwd=2)
abline(a=0,b=1, col='red', lwd=2)



# how many are there? -----------------------------------------------------

l.df <- library.df
l.df <- l.df[!duplicated(paste(l.df$abbv, l.df$bioproject)),]
tab <- table(l.df$abbv)
sum(tab > 1)

m.df <- metaloci.df
m.df <- m.df[m.df$sizing == 'typical',]
tab = table(m.df$abbv, m.df$replication)

colSums(tab)




# metalocus stranding ---------------------------------------------------

m.df <- metaloci.df

# m.df <- m.df[!is.na(m.df$frac_replicated),]
# m.df <- m.df[m.df$frac_replicated >= 0.5 & m.df$sizing == 'typical',]
# dim(m.df)

m.df <- m.df[m.df$sizing == 'typical',]
head(m.df)
table(m.df$abbv, m.df$replication)

m.df <- m.df[m.df$replication != "None",]

m.df$stranded <- m.df$strand != '*'

tab = table(abbv=m.df$abbv, stranded=m.df$stranded)
barplot(t(tab), horiz=T, las=1, legend.text = unique(m.df$stranded))




# metalocus context -------------------------------------------------------

m.df <- metalocus.df

c.df <- context.df
head(c.df)
m.df$context <- c.df$context[match(m.df$metalocus, c.df$metalocus)]
m.df$simplified_context <- c.df$simplified[match(m.df$metalocus, c.df$metalocus)]

m.df <- m.df[!is.na(m.df$context),]
m.df <- m.df[m.df$replication != "None",]

m.df$context <- str_replace(m.df$context, "tRNA|rRNA|spliceosomal", "structural")
m.df$simplified_context <- str_replace(m.df$simplified_context, "tRNA|rRNA|spliceosomal", "structural")

table(m.df$abbv, m.df$context)
table(m.df$abbv, m.df$simplified_context)

colors <- c(intergenic='grey',
                    `near-genic`= 'gold',
                    unstranded_genic = 'cyan',
                    antisense_genic = 'purple',
                    sense_genic = 'firebrick')


## trying again

c.df <- context.df
c.df$replication <- metalocus.df$replication[match(c.df$metalocus, metalocus.df$metalocus)]

c.df <- c.df[c.df$replication != "None" & c.df$s_type != "OtherRNA",]

head(c.df)

table(c.df$stranding, c.df$relationship)

f = c.df$relationship == 'intersect'
tab = table(c.df$stranding[f], c.df$type[f])
tab = tab[c("sense", "unstranded", "antisense"),]

barplot(tab, beside=T, col=c("red", "grey", "blue"), las=1, ylab='replicated loci', main='intersecting genes')
legend('topright', rownames(tab), fill=c('red','grey','blue'))


f = c.df$type == 'mRNA'
tab = table(c.df$stranding[f], c.df$relationship[f])
tab = tab[c("sense", "unstranded", "antisense"), c("near_upstream", "intersect", "near_downstream")]

barplot(tab, beside=T, col=c("red", "grey", "blue"), las=1, ylab='replicated loci', main='near and intersecting mRNAs')
legend('topright', rownames(tab), fill=c('red','grey','blue'))



deep_context_colors <- c(intergenic='grey',
                         `near-genic`= 'gold',
                         rRNA = 'lightblue2',
                         tRNA = 'darkseagreen1',
                         mRNA = 'orchid',
                         spliceosomal='orange')
c.df$type[is.na(c.df$type)] <- 'intergenic'
tab = table(c.df$abbv,c.df$type)

barplot(t(tab), beside=F, las=1, xlab='replicated loci', main='Gene relationships',
        horiz=T, col=deep_context_colors[colnames(tab)])

legend('topright', colnames(tab), fill=deep_context_colors[colnames(tab)], cex=0.8)




# what are the antisense ones? --------------------------------------------

m.df <- metaloci.df
m.df <- m.df[m.df$replication != "None" & m.df$type != "OtherRNA",]
m.df$coords = str_glue("{m.df$seqid}:{m.df$start-1000}..{m.df$end+1000}")


c.df <- context.df
c.df <- c.df[c.df$stranding == 'antisense',]

g.df <- merge(m.df, c.df, by='metalocus')
View(g.df[g.df$abbv.x == 'Bocin',])




# big metalocus plot ------------------------------------------------------

g.df <- import.gff("../metaloci/01out-meta_gffs/Cocin.meta.gff3")
# g.df$length = g.df$end - g.df$start
g.df$length <- ranges(g.df)@width


numeric_columns = c('rpm', 'rpkm','depth','length','member_annotations','member_projects','member_loci', 'median_depth','complexity','skew')
for (c in numeric_columns) {
  mcols(g.df)[[c]] <- as.numeric(mcols(g.df)[[c]])
}

# g.df$rpk = round(g.df$median_depth / g.df$length * 1000, 1)

g.df$rep_score = g.df$member_annotations * log10(g.df$rpkm)# + g.df$member_projects + g.df$member_projects + g.df$member_projects


left  <- start(g.df) - width(g.df)*2
left[left < 0] <- 0
right <- end(g.df) + width(g.df)*2
g.df$coords = str_glue("{as.character(seqnames(g.df))}:{left}..{right}")

table(g.df$primary)

g.df$passing <- "No"
g.df$passing[g.df$primary == "True" & g.df$member_projects >= 2] <- "Pass_minimal"
g.df$passing[g.df$primary == 'True' & g.df$member_projects >= 2 & g.df$member_annotations >= 4] <- "Pass_primary"
g.df$passing[g.df$primary == "False" & g.df$member_projects >= 3 & g.df$member_annotations >= 6] <- "Pass_secondary"

table(g.df$passing)






####
head(g.df)

table(g.df$sizecall_single)

boxplot(rep(c('a','20'), each=5), 1:10)

plot(g.df$sizecall_single, g.df$rpm)
boxplot(g.df$rpm ~ g.df$sizecall_single)

plot(g.df$type, g.df$member_projects)
boxplot(g.df$member_projects ~ g.df$type)


g.df$sizecall_single <- as.numeric(g.df$sizecall_single)

plot(g.df$sizecall_single, g.df$rpm)

plot(g.df$member_annotations, g.df$rpm)
head(g.df)

pheatmap(g.df$sizecall_single, g.df$member_projects )


tab = table(size=g.df$sizecall_single, projects = as.numeric(g.df$member_projects))
tab

tab = table(size=g.df$sizecall_single, annotations = as.numeric(g.df$member_annotations))
tab

f = g.df$sizecall_single == 28
plot(g.df$length[f], g.df$rpm[f], log='y')

f = g.df$sizecall_single == 22 & g.df$member_projects >= 3 & g.df$depth > 2000
plot(g.df$length[f], g.df$depth[f], ylim=c(0,100000))
View(g.df[f,])



plot(g.df$rpk, g.df$rep_score, log='x', pch=19, cex=0.5)



plot(g.df$rpk, g.df$rep_score, log='x', pch=19, cex=0.5, 
     col=ifelse(g.df$rep_score ))




rpk_t=500
f = g.df$rpk > rpk_t
table(f)
tab = table(g.df$sizecall_single[f], g.df$rep_score[f])
tab = as.data.frame(tab)
names(tab) <- c('size', 'rep_score', 'freq')
tab <- dcast(tab, size ~ rep_score)
rownames(tab) <- tab$size
tab$size <- NULL
tab <- tab / rowSums(tab)
tab = tab *-1
tab <- cbind(`0`=rep(1, nrow(tab)), tab)

tab = t(apply(tab, 1, cumsum))


plot(0,0, type='n', xlim=c(0,50), ylim=c(0,1), xlab='rep_score', ylab='size1', las=1, main=rpk_t)
for (rn in rownames(tab)) {
  
  col = size_colors[rn]
  if (rn == "N") {
    col='black'
    lwd=1.5
  } else if (is.na(col)) {
    col = scales::alpha('black', 0.5)
    lwd=1
  } else {
    lwd = 1.5
  }
  
  lines(as.numeric(colnames(tab)), tab[rn,], col=col, lwd=lwd)
}



plot(0,0, type='n', xlim=c(0,max(g.df$rep_score)), ylim=c(0,1), xlab='rep_score', ylab='Prop.')

for (size in unique(g.df$sizecall_single)) {
# for (size in c("28")) {
  
  col = size_colors[size]
  if (size == "N") {
    col='black'
    lwd=1.5
  } else if (is.na(col)) {
    col = scales::alpha('black', 0.5)
    lwd=0.5
  } else {
    lwd = 1.5
  }
  
  f = g.df$sizecall_single == size# & g.df$rpk > 5000
  lines(ecdf(g.df$rep_score[f]), do.points=F, verticals=T, col=col, lwd=lwd)
}

View(g.df[g.df$sizecall_single!= "N",])


plot(g.df$member_annotations, g.df$rpkm, log='y', col=ifelse(g.df$passing != "No", 'purple','grey'), pch=19)

f = g.df$passing != "No"
tab = table(g.df$passing[f], g.df$sizecall_single[f])
barplot(tab, beside=F, horiz=T, 
        col=c('darkseagreen','lavender'), las=1)





# after meta redo ---------------------------------------------------------

plot_size_to_phylo <- function(save=F) {
  m.df <- metalocus.df
  m.df$genus <- species.df$genus[match(m.df$abbv, species.df$abbv)]
  
  table(m.df$abbv, m.df$replication)
  
  # f = m.df$replication == "bin+project+sizing"
  f = str_detect(m.df$replication, 'sizing') & str_detect(m.df$replication, 'project')
  tab = table(m.df$sizecall_single[f], m.df$abbv[f])
  ptab = t(t(tab)/colSums(tab))
  
  hc = hclust(dist(t(ptab)))
  
  tab = tab[,hc$order]
  ptab = ptab[,hc$order]
  
  file_name="F02-metaloci_sizes_phylo.svg"
  # if (save) svglite(file_name, 6.4, 5.7)
  if (save) svglite(file_name, 5.8, 4.5)
  par(mfrow=c(1,4), mar=c(4,5,2,0), las=1)
  barplot(tab, col=size_colors[rownames(tab)], horiz=T, xlab='Metaloci',
          cex.names=1.5)
  
  par(mar=c(4,2,2,1))
  barplot(t(t(tab)/colSums(tab)), col=size_colors[rownames(tab)], horiz=T,
          names.arg = rep('', ncol(tab)), xlab='Prop.')
  
  par(mar=c(4,0,2,1))
  p = as.phylo(hc)
  
  
  plot(p, x.lim=c(0.8, 0), y.lim=c(0.5,ncol(tab)+0.5), show.tip.label=F)
  # tiplabels(bg=phylum_colors[species.df$phylum[match(p$tip.label, species.df$abbv)]], pch=21, cex=2)
  
  classes = species.df$class[match(p$tip.label, species.df$abbv)]
  phyla   = species.df$phylum[match(p$tip.label, species.df$abbv)]
  
  tiplabels(bg=class_colors[classes], cex=2,
            pch= phylum_pch[phyla])
  
  plot(1,1,type='n', axes=F, xlab='', ylab='')
  legend('topright', unique(classes),pt.bg=class_colors[unique(classes)], pch=phylum_pch[phyla[!duplicated(classes)]], inset=0.01, 
         title='class', cex=0.8)
  
  legend('right', names(size_colors),fill=size_colors, inset=0.01,
         title='sRNA-size', cex=0.8)
  
  if (save) dev.off()
  if (save) ADsvg(file_name)
}

plot_size_to_phylo(T)



plot_meta_replication <- function(save=F) {
  
  ###NOT FINISHED...FUCK...
 
  m.df <- metalocus.df
  
  f <- m.df$replication != "None"
  tab <- table(m.df$replication[f], m.df$abbv[f])
  tab <- tab[,rev(colnames(tab))]
  tab
  
  
  
  par(mfrow=c(1,1), las=1)
  
  barplot(tab, horiz=T)
  
  
  ## over 50% project replication?
  
  tab = table(rep50=m.df$frac_replicated >= 0.5, sizing=m.df$sizing)
  tab
  barplot(tab, beside=T)
  
  ## in what organisms?
  f = m.df$total_projects >= 2
  tab = table(abbv=m.df$abbv[f], confident=m.df$frac_replicated[f] >= 0.5 & m.df$sizing[f]=='typical')
  tab
  barplot(tab[rev(rownames(tab)), "TRUE"], horiz=T, las=1, cex.names=1, xlab='sRNA genes')
  par(xpd=T)
  text(0, (nrow(tab):1)*1.2-.6, rep_tab[rownames(tab)], pos=2, cex=0.8, offset=0.2)
  par(xpd=F)
  
  
  ## gini across organisms
  f = m.df$replication != 'None' & m.df$sizing == 'typical'
  tab = table(abbv=m.df$abbv[f])
  y <- cumsum( sort(tab) ) / sum(tab)
  x <- 1:length(y) / length(y)
  
  plot(x, y, type='l', las=1, ylab='Cumu. prop. of loci', xlab='Cumu. prop. of species', lwd=2)
  abline(a=0,b=1, col='red', lwd=2)

}

plot_meta_replication()

 

meta_counts <- function(save=F) {
  
  m.df <- metalocus.df
  m.df <- m.df[str_detect(m.df$replication, 'binom\\+project'),]
  
  t.df <- data.frame()
  for (abbv in unique(m.df$abbv)) {
    cat(abbv)
    mat = get_metalocus_mats(abbv)$annotation
    mat[mat > 1] <- 1
    
    if (type(mat) == 'character') next
    
    f.df <- m.df[m.df$abbv == abbv,]
    
    
    df <- data.frame(count=colSums(mat), 
                        other=colSums(mat[f.df$metalocus[f.df$sizing=='other'],, drop=F]),
                        typical=colSums(mat[f.df$metalocus[f.df$sizing=='typical'],, drop=F]))
    
    df$abbv=abbv
    
    t.df <- rbind(t.df, df)
    
  }
  
  qcd <- function(x) {
    # quartile coefficient of dispersion
    q <- quantile(x, probs = c(0.25, 0.75))
    q1 <- q[1]
    q3 <- q[2]
    
    (q3 - q1) / (q3 + q1)
    
  }
  
  
  
  
  
  f = t.df$count < 5000 & t.df$count > 100
  t.df <- t.df[f,]
  
  x = 1:length(unique(t.df$abbv))
  
  
  t.df <- t.df[order(t.df$typical, decreasing = T),]
  
  
  file_name = "02-meta_counts.svg"
  if (save) svglite(file_name, 5, 5.9)
  # if (save) svglite(file_name, 6.9, 5.9)
  
  par(mar=c(1,5,5,2), mfrow=c(2,1))
  ylim = c(0,1000)
  ## other
  sizing = 'other'
  b = boxplot(t.df[, sizing] ~ t.df$abbv, 
              horizontal=F, las=2, 
              xlab='', 
              ylab="Number of loci", 
              main=sizing,
              ylim=ylim, 
              names=rep('',length(x)))
  
  segments(x-0.3,b$stats[3,], 
           x+0.3,b$stats[3,], 
           col='red', lwd=4)
  
  
  ## typical
  par(mar=c(5,5,1,2))
  sizing = 'typical'
  b = boxplot(t.df[, sizing] ~ t.df$abbv, 
              horizontal=F, las=2, 
              xlab='', 
              ylab="Number of loci", 
              main=sizing,
              ylim=ylim)
  
  segments(x-0.3,b$stats[3,], 
           x+0.3,b$stats[3,], 
           col='red', lwd=4)
  
  ## colored points for phyla
  # col = class_colors[species.df$class[match(b$names, species.df$abbv)]]
  # pch = phylum_pch[species.df$phylum[match(b$names, species.df$abbv)]]
  # 
  # par(xpd=T)
  # points(x, rep(-100, length(x)), pch=pch, bg=col)
  # par(xpd=F)
  
  if (save) dev.off()
  if (save) ADsvg(file_name)
  
}

meta_counts(T)




 retrieval <- function(save=F) {
  set.seed(42)
  
  file_name="02-retrieval.svg"
  if (save) svglite(file_name, 4.8,4.8)
  par(mar=c(2,2,2,0), mfrow=c(4,5), las=1, mgp=c(3,0.5,0))
  
  for (abbv in unique(metalocus.df$abbv)) {
    cat(abbv)
    ann_mat = get_metalocus_mats(abbv)$annotation
    ann_mat[ann_mat > 1] <- 1
    
    if (type(ann_mat) == 'character') next
    if (length(ann_mat) == 0) next
    if (ncol(ann_mat) <= 3) next
    
    out.df <- data.frame()
    for (sizing in c('other','typical')) {
      
      s.df <- data.frame()
      m.df <- metalocus.df[metalocus.df$abbv == abbv,]
      
      if (sizing == 'typical') {
        m.df <- m.df[m.df$sizing == 'typical' & 
                       m.df$replication %in% c('binom+project+sizing','binom+sizing'),]
        
      } else {
        m.df <- m.df[ m.df$sizing == 'other',]
        
      }
    
      mat <- ann_mat[m.df$metalocus,, drop=F]
      
      if (nrow(mat) <= 1) next
      
      
      cumu_counts <- function(x) {
        out = c()
        x = sample(x)
        
        for (i in seq_along(x)) {
          xx = x[1:i]
          m <- mat[,xx, drop=F]
          out = c(out, sum(rowSums(m) > 0))
        }
        
        out
      }
      
      
      for (r in 1:20) {
        s.df <- rbind(s.df, cumu_counts(colnames(mat)))
      }
      names(s.df) <- 1:ncol(mat)
      
      s.df = s.df / max(s.df)
      
      
      out.df <- rbind(out.df, s.df)
    }
    
    if (nrow(out.df) < 40) next
    
    matplot(t(out.df), type='l', col=rep(scales::alpha(c('grey80','goldenrod3'),0.4), each=20), lty=1,#, main=abbv,
            xlab='', ylab='', axes=F, ylim=c(0,1))
            # xlab="Num. samples",
            # ylab='Total locus counts')
    text(par()$usr[2]*.95, 0.1, abbv, font=2, adj=c(1,0))
    axis(1)
    axis(2, at=c(0,1))
    box()
  }
  
  
  if (save) dev.off()
  if (save) ADsvg(file_name)
}
retrieval(T)


genome.df <- get_genome.df()
retrieval_redone <- function(save=F, sizing='typical') {
  set.seed(42)
  
  file_name = "F02-genomic_retrieval.svg"
  if (save) svglite(file_name, 6.3, 6.8)
  par(mar=c(2,3,3,1), 
      # mfrow=c(5,4), 
      mfrow=c(3,3), 
      las=1, mgp=c(3,0.5,0))
  
  dirs = get_dir_paths()
  
  for (abbv in unique(metalocus.df$abbv)) {
    
    projects <- project.df[project.df$abbv == abbv & project.df$filter_str == '1111',]
    
    annotations = c()
    for (project in projects) {
      annotations = c(annotations, Sys.glob(str_glue("{dirs$ann}{project}/tradeoff_*/loci.gff3")))
    }
    
    if (length(annotations) <= 5) next
    cat(abbv)
    
    gr.all <- GRanges()
    for (i in seq_along(annotations)) {
      gr = import.gff(annotations[i])
      if (length(gr) == 0) next
      gr$i <- i
      
      if (sizing == 'typical') {
        gr <- gr[!grepl("15|16|17|18", gr$type),]
        gr <- gr[!grepl("27|28|29|30|31|32|33|34|35", gr$type),]
        gr.all <- c(gr.all, gr[gr$type != "OtherRNA",])
        
      } else if (sizing == 'other') {
        gr.all <- c(gr.all, gr[gr$type == "OtherRNA",])
        
      } else {
        stop()
      }
      
    }
    
    # flat.gr.all <- reduce(gr.all)
    # mcols(flat.gr.all)$length <- width(flat.gr.all)
    # mcols(flat.gr.all)$subloci_n <- countOverlaps(flat.gr.all, gr.all)
    # # plot(ecdf(width(flat.gr.all)), xlim=c(0,3000), ylim=c(0,1))
    # # plot(ecdf(width(gaps(flat.gr.all))), xlim=c(0,3000), ylim=c(0,1))
    # plot(ecdf(flat.gr.all$subloci_n), xlim=c(0,15), ylim=c(0,1))
    # 
    out.df <- data.frame()
    for (rep in 1:10) {
      cat('.')
      for (n in 1:length(annotations)) {
        samples = sample(1:length(annotations),n)
        gr <- gr.all[gr.all$i %in% samples]
        strand(gr) <- "*"
        gr <- sort(gr)
        gr <- reduce(gr)
        
        out.df <- rbind(out.df, 
                        data.frame(abbv=abbv, n=n, rep=rep, count=length(gr), space=sum(width(gr)))) 
      }
    }
    g.df <- genome.df
    g.df <- dcast(g.df, abbv ~ "length", value.var='length', fun.aggregate = sum)
    out.df$pgen <- out.df$space / g.df$length[match(out.df$abbv, g.df$abbv)]
    
    
    # plot(out.df$n, out.df$count, ylim=c(0, max(out.df$count)*1.1))
    plot(out.df$n, out.df$pgen, 
         ylim=c(0, max(out.df$pgen)*1.1),
         # ylim=c(0,0.2),
         # xlim=c(0,500),
         pch=19, col=scales::alpha('black',0.4),
         main=abbv)
    

    
    # model <- lm(pgen~ log(n), data=out.df)
    model <- lm(pgen ~ poly(n, 2), data=out.df)
    # model <- glm(pgen ~ n, data=out.df, family= poisson(link = "log"))
    
    # summary(model)
    x = list(n=seq(0, 500, 0.1))
    y = predict(model, x)
    lines(x$n, y, col='red', lwd=2)
    
    out.df$n
    avg_y = median(out.df$pgen[out.df$n == max(out.df$n)])
    
    pmax = round(avg_y /  max(y) , 2)
    # max_y = max(y) / max(out.df$n)
    
    
    
    # model
    
    # plot(out.df$n, out.df$space)
    # pixelPlot(out.df$n, out.df$space, ylim=c(0, max(out.df$count)*1.1), n=31)
    # text(par()$usr[2]*.95, par()$usr[3]*.05, abbv, font=2, adj=c(1,0), col='darkblue')
    text(par()$usr[2]*.95, par()$usr[3]*.05, str_glue("sizing={sizing}"), font=2, adj=c(1,0), col='darkblue')
    text(par()$usr[2]*.95, par()$usr[4]*.20, pmax, font=2, adj=c(1,0), col='darkblue')
    
    abline(h= max(y), col='darkblue', lty=3, lwd=2)
  }
  
  if (save) dev.off()
  if (save) ADsvg(file_name)
}

retrieval_redone(sizing='typical')
retrieval_redone(sizing='other')

# inequality --------------------------------------------------------------


gini <- function(save=F) {
  m.df <- metalocus.df
  m.df <- m.df[!is.infinite(m.df$member_annotations),]
  
  max.df <- dcast(m.df, abbv ~ "max_ann", value.var = 'member_annotations', fun.aggregate = max)
  m.df <- m.df[m.df$abbv %in% max.df$abbv[max.df$max_ann >=4],]
  
  ## gini across organisms
  # f = str_detect(m.df$replication, 'sizing') & str_detect(m.df$replication, 'project')
  f = m.df$sizing == 'typical'
  tab = table(abbv=m.df$abbv[f])
  y <- cumsum( sort(tab) ) / sum(tab)
  x <- 1:length(y) / length(y)
  
  file_name = "02-gini.svg"
  if (save) svglite(file_name, 3.4, 4)
  par(mfrow=c(1,1))
  plot(x, y, type='l', las=1, ylab='Cumu. prop. of loci', xlab='Cumu. prop. of species', lwd=2,
       xlim=c(0,1))
  abline(a=0,b=1, col='red', lwd=2)
  
  if (save) dev.off()
  if (save) ADsvg(file_name)
}

gini(T)





# context -----------------------------------------------------------------


overview_of_contexts <- function(save=F) {
  c.df <- context.df
  m.df <- metalocus.df
  f = str_detect(m.df$replication, 'sizing') & str_detect(m.df$replication, 'project')
  m.df <- m.df[f,]
  
  c.df <- c.df[c.df$metalocus %in% m.df$metalocus,]
  c.df$simplified <- str_remove(c.df$simplified, "near-")
  
  
  tab = table(c.df$abbv, c.df$simplified)
  ptab = t(tab/rowSums(tab))
  
  
  file_name = "02-context_overview.svg"
  if (save) svglite(file_name, 3.5, 4.5)
  
  par(mar=c(5,4,4,8))
  barplot(ptab, horiz=T, las=1, col=deep_context_colors[rownames(ptab)])
  
  par(xpd=T)
  legend('topright', names(deep_context_colors), fill=deep_context_colors, inset=c(-1 , 0.01), cex=0.8)
  par(xpd=F)
  
  if (save) dev.off()
  if (save) ADsvg(file_name)
}

overview_of_contexts(save=F)


expanded_context <- function(type='mRNA', save=F) {
  c.df <- context.df
  m.df <- metalocus.df
  
  f = str_detect(m.df$replication, 'sizing') & str_detect(m.df$replication, 'project')
  m.df <- m.df[f,]
  
  c.df <- c.df[c.df$metalocus %in% m.df$metalocus,]
  c.df <- c.df[!is.na(c.df$type),]
  c.df <- c.df[c.df$type %in% type,]
  c.df
  
  tab = table(c.df$abbv, c.df$relationship)
  tab <- tab[,c('near_upstream','intersect','near_downstream')]
  
  ptab = t(tab/rowSums(tab))
  
  
  col = c(upstream='tomato', `gene_body`='snow2', downstream='skyblue')
  
  file_name = "02-mRNA_context_relationship.svg"
  if (save) svglite(file_name, 3.5, 4.5)
  
  par(mar=c(5,4,4,8))
  barplot(ptab, horiz=T, las=1, col=col)
  
  par(xpd=T)
  legend('topright', names(col), fill=col, inset=c(-1 , 0.01), cex=0.8)
  par(xpd=F)
  
  if (save) dev.off()
  if (save) ADsvg(file_name)
  
}

expanded_context(save=F)


expanded_context_strand <- function(type='mRNA', save=F) {
  c.df <- context.df
  m.df <- metalocus.df
  
  f = str_detect(m.df$replication, 'sizing') & str_detect(m.df$replication, 'project')
  m.df <- m.df[f,]
  
  c.df <- c.df[c.df$metalocus %in% m.df$metalocus,]
  c.df <- c.df[!is.na(c.df$type),]
  c.df <- c.df[c.df$type %in% type,]
  c.df <- c.df[c.df$relationship == 'intersect',]
  c.df
  
  tab = table(c.df$abbv, c.df$context)
  tab
  # tab <- tab[,c('near_upstream','intersect','near_downstream')]
  
  ptab = t(tab/rowSums(tab))
  
  
  col = c('blue','red','grey')
  names(col) = rownames(ptab)
  
  
  file_name = "02-mRNA_context_stranding.svg"
  if (save) svglite(file_name, 3.5, 4.5)
  
  
  par(mar=c(5,4,4,9))
  barplot(ptab, horiz=T, las=1, col=col)
  
  par(xpd=T)
  legend('topright', names(col), fill=col, inset=c(-1.4 , 0.01), cex=0.8)
  par(xpd=F)
  
  if (save) dev.off()
  if (save) ADsvg(file_name)
}

expanded_context_strand(save=T)









mat.ls <- get_metalocus_mats('Cocin')
mat <- mat.ls$annotation
mat[mat > 1] <- 1
plot(density(apply(mat, 2, sum)))
















# annotation jaccard ------------------------------------------------------


locus_to_gr <- function(l.df) {
  l.df <- l.df[l.df$type != "OtherRNA",]
  gr = GRanges(l.df$seqid, IRanges(l.df$start, l.df$end)
  )
  gr$locus <- l.df$ID
  return(gr)
}


ov.df <- data.frame()
for (project in unique(locus.df$project)) {
  message(project)
  
  abbv = str_sub(project, 1, 5)
  
  annotations <- unique(locus.df$annotation[locus.df$project == project])
  
  if (length(annotations) == 1) next
  
  combs = t(combn(annotations, 2, simplify=T))
  
  for (i in 1:nrow(combs)) {
    comb = combs[i,]
    
    message(paste0("   ", comb[1], " ", comb[2]))
    f = locus.df$type != 'OtherRNA'
  
    l1 <- locus_to_gr(locus.df[locus.df$project == project & 
                                 locus.df$annotation == comb[1],])
    l2 <- locus_to_gr(locus.df[locus.df$project == project & 
                                 locus.df$annotation == comb[2],])

    
    seqlevels(l1)
    seqlevels(l2)
    
    
    inter = sum(width(intersect(l1, l2)))
    A_noB =     sum(width(l1)) - inter
    B_noA =     sum(width(l2)) - inter
    gsize = species.df$genome_length[species.df$abbv == abbv]
    exclu = gsize - A_noB - B_noA - inter
    
    gsize == inter + A_noB + B_noA + exclu
    
    jaccard = inter / (A_noB + B_noA + inter)
    smc     = (inter + exclu) / gsize
    
    ov.df <- rbind(ov.df, data.frame(project=project, 
                                     A=comb[1], 
                                     B=comb[2],
                                     jaccard=jaccard,
                            smc=smc))    
  }
  
  
}


jaccard_plot <- function() {

  o.df <- ov.df
  
  at.df = data.frame(project=unique(ov.df$project),
                     base=1:length(unique(ov.df$project)))
  at.df$abbv <- str_sub(at.df$project, 1, 5)
  at.df$dup <- as.numeric(!duplicated(at.df$abbv))*5
  at.df$y <- at.df$base + cumsum(at.df$dup)
  
  o.df$y <- at.df$y[match(o.df$project, at.df$project)]
  
  par(mar=c(4,10,4,2))
  
  
  
  p.df <- data.frame(abbv=unique(at.df$abbv), 
                     max_y=aggregate(y ~ abbv, data=at.df, FUN=function(x) max(x)+3)[,2],
                     min_y=aggregate(y ~ abbv, data=at.df, FUN=function(x) min(x)-3)[,2],
                     med_y=aggregate(y ~ abbv, data=at.df, FUN=function(x) median(x))[,2])
  p.df$to_plot <- rep_len(c(T,F), nrow(p.df))
  
  plot(1,1,type='n', xlim=c(0,1), ylim=c(min(p.df$min_y), max(p.df$min_y)+3),
       axes=F, ylab='', xlab='Jaccard Index')
  
  
  mtext(p.df$abbv, side=2, line=0.5, at=p.df$med_y, las=1, cex=0.8)
  rect(-0.05, p.df$min_y[p.df$to_plot], 1.05, p.df$max_y[p.df$to_plot], border = F, col='grey80')
  
  box()
  axis(1)
  
  points(o.df$jaccard, o.df$y,
         las=1,
         cex=0.3,
         pch=19,
         ylab='')
  agg.df <- aggregate(jaccard ~ project, data=ov.df, FUN=median)
  agg.df$y <- at.df$y[match(agg.df$project, at.df$project)]
  points(agg.df$jaccard, agg.df$y,
         pch=19,
         cex=0.8,
         col='tomato')
}

jaccard_plot()




# Genomic space covered by metaloci ---------------------------------------


get_mspace <- function(m.df) {
  gr <- GRanges(m.df$seqid, IRanges(m.df$start, m.df$end))
  mspace <- sum(width(gr))
}


a.df <- data.frame()
for (abbv in unique(metalocus.df$abbv)) {
  m.df <- metalocus.df[metalocus.df$abbv == abbv,]
  m.df$bin_pass[is.na(m.df$bin_padj)] <- F
    
  # f <- m.df$type != "OtherRNA"
  
  
  f <- m.df$bin_pass & m.df$sizing == 'typical'
  
  gsize = species.df$genome_length[species.df$abbv == abbv]
  
  a.df <- rbind(a.df, 
                data.frame(abbv=abbv,
                           pass=sum(f),
                           pass_space=get_mspace(m.df[f,]),
                           fail=sum(!f),
                           fail_space=get_mspace(m.df[!f,]),
                           gsize=gsize
                           )
                )  
  
  
  mspace / gsize
  
}

a.df <- a.df[a.df$pass > 0,]
rownames(a.df) <- a.df$abbv
a.df$abbv <- NULL

a.df$pass_p <- round(a.df$pass_space / a.df$gsize * 100, 1)
a.df$fail_p <- round(a.df$fail_space / a.df$gsize * 100, 1)


par(mar=c(c(5,10,5,8)))
lp <- layermap(a.df[,c("pass_p", "fail_p")],
               row.df = a.df,
               zlim=c(0,30),
               palette = 'viridis',
               reverse_palette = F)

lp <- lp_names(lp, 2, 'pass_space')
lp <- lp_names(lp, 2)
lp <- lp_names(lp, 3)
lp_plot_values(lp)

# install.packages("formattable")
library(formattable)

tbl <- a.df[,c('pass','pass_space','pass_p','gsize')]
tbl$pass_space <- comma(tbl$pass_space, digits=0)
tbl$gsize      <- comma(tbl$gsize, digits=0)

formattable(tbl,
            list(pass=color_tile('grey', 'red')),
            table.attr = 'style="font-size: 10px; font-family: Arial";\"'
            )




# metalocus size profiles -------------------------------------------------

meta_aln_comparison <- function() {
  m.df <- metalocus.df
  m.df <- m.df[m.df$sizing == 'typical' & m.df$bin_pass,]
  
  tab = table(m.df$abbv, m.df$sizecall_single)
  tab = data.frame(rbind(tab))
  
  par(mfrow=c(1,2))
  par(mar=c(4,3,3,1))
  
  lp <- layermap(tab, palette = 'reds',
                 zlim=c(0,50))
  
  lp <- lp_names(lp, 2)
  lp <- lp_names(lp, 3)
  
  lp_plot_values(lp)
  
  par(xpd=F)
  
  p.df <- scale.df
  head(p.df)
  
  p.df <- p.df[p.df$abbv %in% m.df$abbv,]
  p.df
  
  # p.df <- dcast(p.df, project + abbv ~ size, value.var='prop')
  p.df <- dcast(p.df, project + abbv ~ size, value.var='zmed')
  
  p.df$y <- lp$plotting.df$y[match(p.df$abbv, lp$plotting.df$rows)]
  
  x = 15:30
  y_offset = 0.1
  plot(1,1,xlim=c(17, 28), ylim=lp$ylim, axes=F)
  # abline(v=c(15, 20, 25, 30), col='red', lty=3)
  
  # rect(18.5, 0, 26.5, 80, col='grey90', border=F)
  rect(lp$plotting.df$x+19,
       lp$plotting.df$y,
       lp$plotting.df$x+20,
       lp$plotting.df$y+.2,
       col = lp$plotting.df$color, border=NA)
  
  axis(1, at=c(15,20,25,30))
  
  
  for (i in 1:nrow(p.df)) {
    row = p.df[i,]
    
    # y = row[,as.character(x)]
    # y = y / max(y) / 1.1
    
    
    y = row[,as.character(x)]
    y = y - min(y)
    y = y / max(y) / 2
    y[y> 0.9] = 0.9
    y = y + 0.2  
    
    y = y + row$y
    lines(x, y, col=scales::alpha('black',0.5), lwd=1.0)
  }
}


meta_aln_comparison()



# metalocus_support -------------------------------------------------------


## i'm thinking an upset plot or something related in a single bar that shows the amount of supported loci in each, and what type of support it is


m.df <- metalocus.df
m.df <- m.df[m.df$replication != 'none',]

tab = table(m.df$abbv, m.df$replication)
tab = tab[,c('binom','binom+project','binom+sizing','binom+project+sizing')]

ptab = tab / rowSums(tab)

barplot(t(tab), horiz = T, las=1, col=c('black','darkred','cadetblue','lightgreen'))
barplot(t(ptab), horiz = T, las=1, col=c('black','darkred','cadetblue','lightgreen'))



# which annotations are most rep'd ----------------------------------------

m.df <- metalocus.df

m.df$rep_project <- str_sub(str_split_fixed(m.df$rep_locus, '-', 3)[,2],7,-1)
head(m.df)

ls <- list()
for (abbv in unique(m.df$abbv)) {
  # message(abbv)
  ls[[abbv]] <- table(m.df$rep_project[m.df$abbv == abbv])
}
ls$Bocin


# frequency of high-conf mls ----------------------------------------------




m.df <- metalocus.df
# m.df <- m.df[m.df$bin_pass & m.df$sizing == 'typical',]
m.df <- m.df[m.df$replication == 'binom+project+sizing',]
m.df <- m.df[complete.cases(m.df),]
nrow(m.df)
table(m.df$abbv)








out.df <- data.frame()
for (project_dir in Sys.glob("/Volumes/fungal_srnas/Annotations/*")) {
# for (project in project.df$project[project.df$f_pass]) {
  project_dir = paste0("/Volumes/fungal_srnas/Annotations/", project)
  # project = basename(project_dir)
  message(project)
  
  for (ann_dir in Sys.glob(file.path(project_dir, "tradeoff_*"))) {
    annotation = basename(ann_dir)
    message("  ", annotation)

    skip_to_next = F
    catch = function(e) { skip_to_next <<- TRUE}
    
    tryCatch(a.df <- read.delim(str_glue("/Volumes/fungal_srnas/Annotations/{project}/{annotation}/loci.txt")), error=catch)
    tryCatch(l.df <- read.delim(str_glue("/Volumes/fungal_srnas/Annotations/{project}/align/library_stats.txt")), error=catch)
    tryCatch(j.df <- jsonlite::fromJSON(str_glue('/Volumes/fungal_srnas/Annotations/{project}/{annotation}/params.json')), error=catch)
    
    if (skip_to_next) next
    
    libraries = j.df$conditions[[j.df$annotation_conditions]]
    l.df <- l.df[l.df$library %in% libraries,]
    total_aligned = sum(l.df[,c('umap','mmap_wg','mmap_nw'),])
    a.df$size_1n <- as.numeric(str_sub(a.df$size_1n, 2, 3))
    
    a.df$sized <- ifelse(a.df$size_1n %in% 20:24 & a.df$sizecall != "N", 'sized','degraded')
    
    df <- dcast(a.df,'project' + 'annotation' ~ sized , value.var='Reads', fun.aggregate = sum)
    
    if (!'degraded' %in% names(df)) {
      df$degraded = 0
    }
    
    if (!'sized' %in% names(df)) {
      df$sized = 0
    }
    
    names(df)[1] <- 'project'
    names(df)[2] <- 'annotation'
    
    df <- df[,c('project','annotation','sized','degraded')]
    
    df$unannotated <- total_aligned - df$degraded - df$sized
    df$project = project
    df$annotation = annotation
    
    out.df <- rbind(out.df, df)

  }
}

o.df <- out.df

rownames(o.df) <- paste(o.df$project, o.df$annotation)
o.df$project <- NULL
o.df$annotation <- NULL
o.df$unannotated <- NULL

o.df <- o.df[rowSums(o.df) > 5000000,]

col=c('green','red','black')
barplot(t(o.df), horiz = T, col=col)

po.df <- o.df / rowSums(o.df)

barplot(t(po.df), horiz = T, col=col)

plot(ecdf(po.df$sized), xlab='Prop. sized', ylab='Cumu. annotations')



### now comparing with plants

out.df <- data.frame()

for (ann_file in Sys.glob("../plant_annotations/*.csv")) {
  species = str_sub(basename(ann_file), 13, -5)
  df <- read.csv(ann_file)
  df$species <- species
  
  out.df <- rbind(out.df, df)
  
}


out.df$sized <- ifelse(out.df$loc_type == 'OtherRNA', 'degraded', 'sized')
o.df <- dcast(out.df, sized + species ~ 'count', value.var = 'total_reads', fun.aggregate = sum)

o.df <- dcast(o.df, species ~ sized, value.var = 'count')
o.df$p_sized = o.df$sized / (o.df$degraded + o.df$sized)
o.df







# genome density comparisons ----------------------------------------------

get_other_genome.ls <- function() {
  g.df <- read.delim("../+non-fungi_genomes/genomes.tsv")
  g.df$abbv <- str_c(str_sub(g.df$Organism.Name, 1,2), str_sub(str_split_fixed(g.df$Organism.Name, " ", 3)[,2], 1,3))
  g.df <- g.df[,c('abbv', 
                  'Assembly.Accession',
                  'Organism.Common.Name', 
                  'Organism.Name',
                  'Organism.Taxonomic.ID',
                  'Annotation.Count.Gene.Protein.coding',
                  'Assembly.Stats.Total.Sequence.Length',
                  'Assembly.Stats.Total.Number.of.Chromosomes')]
  
  names(g.df) <- c('abbv','accession','common_name','name','taxid', 'pcg_count','genome_length','chromosome_count')
  
  s.df <- species.df
  s.df$pcg_count = NA
  s.df <- s.df[, c('abbv', 'accession','Common.Name.or.Disease','species','taxid', 'pcg_count', 'genome_length','contig_n')]
  names(s.df) <- names(g.df)
  g.df <- rbind(g.df, s.df)
  
  
  
  
  g.df$kingdom <- 'fungi'
  g.df$kingdom[g.df$abbv %in% c('Artha','Orsat','Phpat','Solyc', "Heann","Madom")] <- 'plants'
  g.df$kingdom[g.df$abbv %in% c('Drmel','Hosap','Mumus','Xelae', "Apmel", "Gagal")] <- 'animals'
  
  
  
  
  
  g.df$col[g.df$kingdom == 'animals'] <- hcl.colors(10, 'reds')[2:7]
  g.df$col[g.df$kingdom == 'plants'] <- hcl.colors(10, 'greens')[2:7]
  g.df$col[g.df$kingdom == 'fungi'] <- 'blue3'
  
  
  ann.ls <- list()
  for (abbv in unique(g.df$abbv)) {
    message(abbv)
    accession = g.df$accession[g.df$abbv == abbv]
    col = g.df$col[g.df$abbv == abbv]
    
    gff_files = c(str_glue("../+non-fungi_genomes/dehydrated/ncbi_dataset/data/{accession}/genomic.gff"),
                  Sys.glob(str_glue("../+genomes/{abbv}*_genomic.gff3")))
    
    for (f in gff_files) {
      if (file.exists(f)) {
        gff_file = f
        break}
    }
    
    message(gff_file)
  
      
    gr <- import.gff(gff_file, feature.type=c('gene'))
    tab=table(gr$gene_biotype)
   
    # print(tab)
    # print(tab['protein_coding'])
    
    gr <- gr[gr$gene_biotype == 'protein_coding',]
    gr <- reduce(gr)
    
    ls = list()
    ls$gaps             = ecdf(width(gaps(gr)))
    ls$pcgs             = ecdf(width(gr))
    ls$annotated_length = sum(width(reduce(gr)))
    ls$gene_summary     = tab
    ls$pcg_count        = tab['protein_coding']
    ls$genome_length    = g.df$genome_length[g.df$abbv == abbv]
    ls$col              = g.df$col[g.df$abbv == abbv]
    
    ann.ls[[abbv]] = ls
  }

}

other_genome.ls <- get_other_genome.ls()



# par(mfrow=c(2,2))
## PCG width cdf

plot_other_pcg_widths <- function() {
  ann.ls <- other_genome.ls

  par(mar=c(4,5,2,4), las=1)
  plot(1,1,type='n', xlim=c(0, 50000), ylim=c(0.5,1), xlab='Nucleotides', ylab="Cumu. Prop.",
       main='PCG widths')
  
  for (abbv in names(ann.ls)) {
    cdf = ann.ls[[abbv]]$pcgs
    col = ann.ls[[abbv]]$col
    
    lines(cdf, col=col, do.points=F)
    
    mtext(abbv, side=4, line=0.2, at=cdf(50000), las=2, adj=0, col=col)
  }
}

plot_other_pcg_gaps <- function() {
  ## gaps cdf
  ann.ls <- other_genome.ls
  
  par(mar=c(4,5,2,4), las=1)
  plot(1,1,type='n', xlim=c(0, 50000), ylim=c(0.2,1), xlab='Nucleotides', ylab="Cumu. Prop.",
       main='gap widths')
  
  for (abbv in names(ann.ls)) {
    cdf = ann.ls[[abbv]]$gaps
    col = ann.ls[[abbv]]$col
    
    lines(cdf, col=col, do.points=F)
    
    mtext(abbv, side=4, line=0.2, at=cdf(50000), las=2, adj=0, col=col)
  }
}
plot_other_pcg_gaps()



## percent annotated
plot_other_pann <- function() {
  ann.ls <- other_genome.ls
  df = data.frame()
  for (abbv in names(ann.ls)) {
    
    df <- rbind(df, data.frame(abbv=abbv,
                               annotated_length=ann.ls[[abbv]]$annotated_length,
                               genome_length=ann.ls[[abbv]]$genome_length,
                               kingdom = g.df$kingdom[g.df$abbv == abbv]))
  }
  df$perc_ann = df$annotated_length / df$genome_length
  boxplot(df$perc_ann ~ df$kingdom, ylim=c(0,1))
}
plot_other_pann()

## gene count

plot_other_gene_count <- function() {
  ann.ls <- other_genome.ls
  df = data.frame()
  for (abbv in names(ann.ls)) {
    
    df <- rbind(df, data.frame(abbv=abbv,
                               pcg_count=ann.ls[[abbv]]$pcg_count,
                               genome_length=ann.ls[[abbv]]$genome_length,
                               kingdom = g.df$kingdom[g.df$abbv == abbv]))
  }
  plot(df$genome_length, df$pcg_count, 
       col=c(fungi='gold',plants='lightgreen',animals='firebrick2')[df$kingdom], 
       log='xy',
       lwd=2,
       xlab="Genome length", ylab='Protein Coding Genes', axes = F)
  box()
  
  ticks = 10^(1:10)
  axis(1, at=ticks, labels = paste0(ticks/1000000,"M"))
  axis(2)
  
    
}
plot_other_gene_count()







# Metalocus size vs abundance ---------------------------------------------


save=T
dir.create("F02-size_abd_type", showWarnings = FALSE)
for (abbv in unique(metadata.df$abbv)) {
  message(abbv)
  if (sum(metalocus.df$abbv == abbv) == 0) {message("  -> none"); next}
  
  file_name = paste0("F02-size_abd_type/", abbv, '.svg')
  if (save) svglite(file_name, 8.5, 8.5)
  
  par(mfrow=c(4,4))
  par(mar=c(3,3,1,1))
  plot.new()
  text(0.5,0.5, abbv, cex=2, font=2)
  legend("bottomleft", c('typical', 'other'), pch=1, col=c('black','orange'), inset=0.05)
  
  
  for (context in sort(unique(metalocus.df$context))) {
    message(paste(" ", context))
    m.df <- metalocus.df[metalocus.df$abbv == abbv,]
    m.df <- m.df[m.df$context == context,]
    m.df$length <- m.df$end - m.df$start
    
    m.df <- m.df[rev(order(match(m.df$sizing, c("typical",'atypical','other')))),]
    
    
    max_rep = max(m.df$member_annotations)
    
    m.df$sizecall_single[!m.df$sizecall_single %in% as.character(19:25)] <- "N"
    xlim=c(80, 100000)
    ylim=c(1, 1E6)
    
    
    plot(m.df$length, m.df$rpm, log='xy', cex = (m.df$member_annotations / max_rep)*3,
         main=paste0(context), 
         xlim=xlim, ylim=ylim, col=scales::alpha(ifelse(m.df$sizing == 'typical', 'black','orange'), (m.df$member_annotations / max_rep)))
    
    # f = m.df$sizing != 'typical'
    # plot(m.df$length[f], m.df$rpm[f], log='xy', cex = (m.df$member_annotations[f] / max_rep)*5,
    #      main='other', xlim=xlim, ylim=ylim, col=scales::alpha(ifelse(m.df$bin_pass[f], 'black','blue'), (m.df$member_annotations[f] / max_rep)))
  }
  if (save) dev.off()
  if (save) ADsvg(file_name)
  
}



# metalocus count ---------------------------------------------------------


m.df <- metalocus.df
m.df$replication[m.df$replication == 'binom'] <- 'other'
m.df$replication[m.df$replication == 'binom+project'] <- 'other'
m.df$replication[m.df$replication == 'none'] <- 'other'


tab = table(m.df$abbv, m.df$replication)
tab = as.data.frame(tab)


tab <- dcast(tab, Var1 ~ Var2, value.var='Freq', fun.aggregate = sum)
tab <- tab[tab$`binom+project+sizing` > 0, ]


# raw metalocus counts ----------------------------------------------------
tab = table(metalocus.df$abbv)
b = barplot(tab, horiz=F, ylab='Metaloci', las=2)

ltab = table(library.df$abbv)
par(xpd=T)
text(b, tab, ltab[names(tab)], pos=3, cex=0.8, col='red')
par(xpd=F)




# context plots -----------------------------------------------------------


make_context_plots <- function(save=F, save_together=F) {

  
  if (save_together) file_name = str_glue("02-context.all.svg")
  if (save_together) svglite(file_name, 10,8)
  if (save_together) par(mar=c(1,4,4,4), mfrow=c(3,5))
  
  for (abbv in unique(metalocus.df$abbv)) {
    
    
    
    message(abbv)
    m.df <- metalocus.df[metalocus.df$abbv == abbv,]
    m.df <- m.df[m.df$replication == 'binom+project+sizing',]
    
    if (nrow(m.df) < 10) next
    
    tab = table(m.df$context, m.df$sizecall_single)
    tab = as.data.frame(tab)
    tab = rbind(tab, 
                cbind(Var1=unique(metalocus.df$context), Var2=rep_len(19:25, length.out = length(unique(metalocus.df$context))),Freq=NA))
    tab$Freq[is.na(tab$Freq)] <- 0
    
    tab <- dcast(tab, Var1 ~ Var2, value.var='Freq', 
                 fun.aggregate = function(x) sum(as.numeric(x)))
    
    rownames(tab) <- tab$Var1
    tab$Var1 <- NULL
    
    row.df <- data.frame(row.names = row.names(tab))
    row.df$class <- str_split_fixed(row.names(row.df), "/", 2)[,1]
    row.df$subclass <- str_split_fixed(row.names(row.df), "/", 2)[,2]
    
    if (save) file_name = str_glue("02-context.{abbv}.svg")
    if (save) svglite(file_name, 3.84, 4.33)
    if (save) par(mar=c(3,4,4,8))
    
    
    
    lp <- layermap(tab, row.df=row.df, color_scale = c('white', hcl.colors(30, 'blues', rev=T)), # palette='blues', reverse_palette = T,
                   cluster_rows = F,
                   row_groups = 'class',
                   zlim=c(0,max(unlist(tab))*.4))
    
    
    lp <- lp_group_names(lp, 2, 'class')
    lp <- lp_names(lp, 3)
    lp <- lp_names(lp, 4, 'subclass')
    mtext('sRNA length', 3, line=1.5, font=1, cex=0.6)
    
    lp_plot_values(lp)
    
    mtext(abbv, 3, line=2.5, at=0, font=2, cex=1)
    
    if (save) dev.off()
    if (save) ADsvg(file_name)
  }
  
  if (save_together) dev.off()
  if (save_together) ADsvg(file_name)
}

make_context_plots(save_together=T)



make_context_stranding_plots <- function(save=F, save_together=F) {
  
  
  if (save_together) file_name = str_glue("02-stranding.all.svg")
  if (save_together) svglite(file_name, 10,6)
  if (save_together) par(mar=c(1,4,4,4), mfrow=c(2,6))
  
  # par(mar=c(1,4,4,4), mfrow=c(3,4))
  
  for (abbv in unique(metalocus.df$abbv)) {
  
  
    m.df <- metalocus.df[metalocus.df$abbv == abbv,] 
    m.df <- m.df[m.df$replication == 'binom+project+sizing',]
    m.df <- m.df[m.df$context != 'intergenic',]
    
    
    if (nrow(m.df) < 10) next
    
    tab = table(m.df$context, m.df$context_stranding)
    tab = as.data.frame(tab)
    tab = rbind(tab, 
                cbind(Var1=unique(metalocus.df$context), Var2=rep_len('sense', length.out = length(unique(metalocus.df$context))),Freq=NA))
    tab$Freq[is.na(tab$Freq)] <- 0
    
    tab <- dcast(tab, Var1 ~ Var2, value.var='Freq', 
                 fun.aggregate = function(x) sum(as.numeric(x)))
    
    rownames(tab) <- tab$Var1
    tab$Var1 <- NULL
    
    tab <- tab[,c('sense','antisense','unstranded')]
    
    row.df <- data.frame(row.names = row.names(tab))
    row.df$class <- str_split_fixed(row.names(row.df), "/", 2)[,1]
    row.df$subclass <- str_split_fixed(row.names(row.df), "/", 2)[,2]
    
    column.df <- data.frame(row.names = names(tab), stranding=c('stranded','stranded','unstranded'))
    
    
    # par(mar=c(3,6,4,1))
    lp <- layermap(tab, 
                   row.df=row.df, 
                   column.df = column.df,
                   color_scale = c('white', hcl.colors(30, 'reds', rev=T)), 
                   # palette='blues', reverse_palette = T,
                   cluster_rows = F,
                   row_groups = 'class',
                   column_groups = 'stranding')
                   # zlim=c(0,max(unlist(tab))*.4))
    
    
    lp <- lp_group_names(lp, 2, 'class')
    lp <- lp_names(lp, 3)
    lp <- lp_names(lp, 4, 'subclass')
    
    
    lp_plot_values(lp)
    mtext(abbv, 3, line=2.5, at=0, font=2, cex=1)
  }
  
  if (save_together) dev.off()
  if (save_together) ADsvg(file_name)
}

make_context_stranding_plots(save_together = T)


