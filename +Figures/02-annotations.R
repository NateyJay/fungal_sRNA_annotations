






# locus counts

ann.df <- get_ann.df()


make_locus_count_heatmap <- function(save=F) {
    
  c.df <- data.frame()
  for (project in unique(ann.df$project)) {
    message(project)
    
    a.df <- ann.df[ann.df$project == project,]
    
    f = a.df$peak_locus
    
    if (is.na(sum(f, rm.na=T)) | sum(f, rm.na=T) == 0) next
    
    tab <- table(a.df$sizecall[f])
    
    if (sum(tab) == 0) next
    
    df <- as.data.frame(tab)
    
    names(df) <- c('sizes','loci')
    
    df$abbv       = str_split(project, "\\.", 3)[[1]][1]
    df$bioproject = str_split(project, "\\.", 3)[[1]][2]
    
    c.df <- rbind(c.df, df)
      
  }
  
  sizecalls = c(15:30, str_c(15:29, 16:30, sep="_"), str_c(15:28, 16:29, 17:30, sep="_"))
  
  c.df <- dcast(c.df, abbv + bioproject ~ sizes, value.var='loci')
  
  for (sc in sizecalls[!sizecalls %in% names(c.df)]) {
    message(sc)
    c.df[sc] <- rep(0, nrow(c.df))
    
  }
  
  c.df <- c.df[,c('abbv','bioproject', sizecalls)]
  c.df[is.na(c.df)] <- 0
  
  rownames(c.df) <- str_c(c.df$abbv, c.df$bioproject, sep='.')
  
  val.df <- c.df
  val.df <- c.df[complete.cases(val.df),sizecalls]
  val.df <- val.df / apply(val.df, 1, max)
  # val.df <- as.matrix(log10(val.df))
  # val.df[is.nan(val.df)] <- -0.1
  val.df <- val.df[complete.cases(val.df),]
  
  row.df <- c.df[rownames(val.df),c('abbv','bioproject')]
  row.df$highlight <- NA
  f = row.df$abbv %in% c('Scpom', 'Bocin', "Scscl", "Fugra")
  row.df$highlight[f] <- row.df$abbv[f]
  col.df <- data.frame(row.names=sizecalls, 
                       size=sizecalls,
                       width=str_count(sizecalls, "_") + 1)
  
  
  table(project.df$abbv)
  
  file_name="02-B-locus_counts_heatmap.svg"
  if (save) svglite(file_name, 8.9, 11.3)
  
  par(mar=c(3,2,4,18))
  lp <- layermap(val.df,
                 row.df=row.df,
                 column.df=col.df,
                 column_groups = 'width',
                 # row_groups = 'abbv',
                 palette = 'reds',
                 zlim=c(0,1))
  
  lp <- lp_names(lp, 3)
  # lp <- lp_group_names(lp, 2, 'abbv')
  
  lp <- lp_annotate(lp, 4, 'highlight', type='point', pch=19, plot_label=F, 
                    col=c(Fugra="#000000", Bocin="#E69F00", Scpom="#56B4E9", Scscl="#009E73"))
  lp <- lp_names(lp, 4, 'abbv', cex=0.7)
  lp <- lp_names(lp, 4, 'bioproject', cex=0.7)
  lp <- lp_dend(lp, 4)
  
  lp <- lp_color_legend(lp, 1)
  
  if (save) dev.off()
  if (save) ADsvg(file_name)
}

make_locus_count_heatmap(T)

## which are pathogens??




# Filtered peaks ----------------------------------------------------------

# peak.df <- get_peaks()
peak.df <- get_peak.df()

k.df <- peak.df

k.df <- dcast(k.df, abbv + bioproject + rg ~ peak)

for (c in as.character(15:35)) {
  if (!c %in% names(k.df)) {
    k.df <- cbind(k.df, NA)
    names(k.df)[ncol(k.df)] <- c
  }
}



val.df <- k.df[, as.character(15:35)]
val.df[!is.na(val.df)] <- 1
val.df[is.na(val.df)] <- 0

val.df <- sapply(val.df, as.numeric)
val.df <- t(val.df)
colnames(val.df) <- str_c(k.df$abbv, k.df$bioproject, k.df$rg, sep='.')

col.df <- k.df[,1:3]
rownames(col.df) <- str_c(k.df$abbv, k.df$bioproject, k.df$rg, sep='.')

# col.df <- data.frame(row.names = k.df$abbv, )

lp <- layermap(val.df,
               color_scale = c('white','darkorange3'),
               cluster_cols = T,
               cluster_rows = F,
               column.df = col.df,
               column_groups = 'abbv',
               group_gap = .1)
# lp <- lp_names(lp, 3,
#                cex=0.3)
lp <- lp_names(lp, 2, cex=0.4)
# lp <- lp_names(lp, 1)
lp <- lp_group_names(lp, 1, 'abbv')

lp <- lp_dend(lp, 3)


# making peak scaling filter ----------------------------------------------

## moved to functions

# Plotting all peaks ------------------------------------------------------



peak.ls <- make_peak_filter()



plot_unaggregated_peaks <- function(save) {
  k.df <- peak.ls$peak_filter_unaggregated
  rownames(k.df) <- str_c(k.df$abbv, k.df$bioproject, k.df$rg, sep='.')
  
  val.df <- k.df[, as.character(15:35)]
  rownames(val.df) <- str_c(k.df$abbv, k.df$bioproject, k.df$rg, sep='.')
  
  row.df <- k.df[,c("abbv",'bioproject','rg')]
  
  row.df$highly_skewed <- 0
  row.df$highly_skewed[rownames(row.df) %in% highly_skewed] <- 1
  
  file_name = "02-A-peak_filter_unaggregated.svg"
  if (save) svglite(file_name, 6, 30)
  
  par(mar=c(4,13,4,2.2))
  lp <- layermap(val.df,
                 color_scale = c('snow','red2'),
                 row.df=row.df,
                 row_groups = c('abbv'),
                 group_gap = 0.01)
  
  # left
  # lp <- lp_names(lp, 2, "rg")
  # lp <- lp_group_names(lp, 2, "bioproject")
  # lp <- lp_group(lp, 2, "abbv", plot_label = F, plot_names = F)
  lp <- lp_group_names(lp, 2, "abbv")
  
  # top
  lp <- lp_names(lp, 3)
  
  # right
  lp <- lp_annotate(lp, 4, 'highly_skewed')
  
  if (save) dev.off()
  if (save) ADsvg(file_name)
}

plot_unaggregated_peaks(F)


plot_aggregated_peaks <- function(save=F) {

  val.df <- peak.ls$peak_filter
  
  row.df <- spec.df[rownames(val.df),]
  
  file_name = "02-A-peak_filter_aggregated.svg"
  if (save) svglite(file_name, 5.9, 6.9)
  
  par(mar=c(4,8,4,10))
  lp <- layermap(val.df,
                 palette='reds',
                 # color_scale = c('snow','red2'),
                 row.df=row.df,
                 # row_groups = c('abbv'),
                 group_gap = 0.01,
                 zlim=c(0,1))
  
  # left
  lp <- lp_annotate(lp, 2, "phylum", type='points', pch=16, col=phylum_colors)
  lp <- lp_names(lp, 2)
  
  # top
  lp <- lp_names(lp, 3)
  
  # right
  lp <- lp_dend(lp, 4)
  lp <- lp_legend(lp, 4, 'phylum')
  
  # bottom
  lp <- lp_color_legend(lp, 1, titles='Peak score')
  
  
  if (save) dev.off()
  if (save) ADsvg(file_name)

}

plot_aggregated_peaks(T)



# What do loci look like? -------------------------------------------------








annotation.df <- get_annotation.df()
annotation.df <- filter_loci()

plot_locus_counts <- function() {
  l.df <- data.frame()
  for (project in unique(annotation.df$project)) {
    message(project)
    
    
    a.df <- annotation.df[annotation.df$project == project & 
                            annotation.df$f_all,]
    
    abbv       = str_split(project, "\\.", 3)[[1]][1]
    bioproject = str_split(project, "\\.", 3)[[1]][2]
    
    l.df <- rbind(l.df, c(abbv, bioproject, nrow(a.df)))
    
    
  }
  
  names(l.df) <- c('abbv','bioproject','count')
  l.df$count <- as.numeric(l.df$count)
  l.df <- l.df[rev(order(l.df$abbv)),]
  
  l.df <- l.df[l.df$count > 0,]
  
  a.df <- aggregate(l.df, abbv ~ count, median)
  a.df <- a.df[order(a.df$count),]
  
  l.df$abbv <- factor(l.df$abbv, levels=unique(a.df$abbv))

  
  b = boxplot(l.df$count ~ l.df$abbv, horizontal=F, las=1, plot=F)
  x =1:length(b$n)
  
  plot(1,1,type='n', xlim=c(min(x),max(x)), ylim=c(0,5000), axes=F, xlab='',ylab='Locus count')
  axis(2, las=1)
  
  segments(x, 0, x, 5000, lty=1, lwd=0.2)
  f = b$n == 1
  
  points(which(f), b$stats[3,f], pch=19, col='darkred')
  
  f = b$n > 1
  rect(which(f)-0.2, b$stats[2,f], which(f)+0.2, b$stats[4,f], lwd=1.5, col='lavender')
  segments(which(f)-0.2, b$stats[3,f], which(f)+0.2, b$stats[3,f], lwd=1)
  
  par(xpd=T)
  text(x, -100, b$names, srt=90, adj=c(1, 0.5))
  par(xpd=F)
}

plot_locus_counts()



plot_locus_counts_by_phylo <- function() {
  
  l.df <- annotation.df
  l.df <- l.df[l.df$f_all,]
  
  l.df <- dcast(l.df, project ~ ., fun.aggregate = length)
  l.df$abbv <- str_sub(l.df$project, 1,5)
  
  names(l.df) <- c('bioproject','count','abbv')
  l.df <- l.df[order(l.df$abbv),]
  
  # l.df <- l.df[l.df$count > 0,]
  

  
  l.df$abbv <- factor(l.df$abbv, levels=unique(l.df$abbv))
  
  l.df$tax <- species.df$order[match(l.df$abbv, species.df$abbv)]
  
  l.df <- l.df[order(l.df$tax),]
  l.df$abbv <- factor(l.df$abbv, levels=unique(l.df$abbv))
  
  l.df$gap <- cumsum(!duplicated(l.df$tax))
  
  l.df$host <- species.df$Pathogen[match(l.df$abbv, species.df$abbv)]
  
  host_colors = c(`NA`=NA, Plant='darkgreen', Human='blue', Insect='orange')
  
  
  b = boxplot(l.df$count ~ l.df$abbv, horizontal=F, las=1, plot=F)
  x =1:length(b$n) + l.df$gap[!duplicated(l.df$abbv)]
  
  par(mar=c(5,5,5,2))
  plot(1,1,type='n', xlim=c(min(x),max(x)), ylim=c(0,6000), axes=F, xlab='',ylab='Locus count')
  axis(2, las=1)
  
  segments(x, 0, x, 6000, lty=1, lwd=0.2)
  f = b$n == 1
  
  points(x[f], b$stats[3,f], pch=19, col='darkred')
  
  f = b$n > 1
  rect(x[f]-0.2, b$stats[2,f], x[f]+0.2, b$stats[4,f], lwd=1.5, col='lavender')
  segments(x[f]-0.2, b$stats[3,f], x[f]+0.2, b$stats[3,f], lwd=1)
  
  par(xpd=T)
  points(x, rep(-600, length(x)),
         pch = 18,
         col = host_colors[l.df$host[match(b$names, l.df$abbv)]])
  
  text(x, -800, b$names, srt=90, adj=c(1, 0.5))
  par(xpd=F)
}

plot_locus_counts_by_phylo()





# locus sizes? ------------------------------------------------------------


ann.df <- get_ann.df()

a.df <- ann.df
a.df$abbv <- str_sub(a.df$project, 1,5)
a.df$bioproject <- str_sub(a.df$project, 7, -1)

a.df <- a.df[!is.na(a.df$peak_locus),]
a.df <- a.df[a.df$peak_locus,]
a.df <- a.df[a.df$sizecall != "N",]


# par(mar=c(15,4,2,2))
# boxplot(a.df$Length ~ a.df$project, ylim=c(0, 4000), outline=F, whisklty=0, staplelty=0,
#         las=2, xlab='',
#         cex.axis=0.6)
# 
# 
head(a.df)




a.df$chrom = str_split_fixed(a.df$Locus, ":", 2)[,1]
a.df$start = as.numeric(str_split_fixed(str_split_fixed(a.df$Locus, ":", 2)[,2], "-", 2)[,1])
a.df$stop  = as.numeric(str_split_fixed(str_split_fixed(a.df$Locus, ":", 2)[,2], "-", 2)[,2])


loci = GRanges(a.df$chrom, IRanges(a.df$start,a.df$stop), a.df$strand)
loci$bioproject = str_sub(a.df$project, 7, -1)
loci$abbv = str_sub(a.df$project, 1,5)

for (abbv in unique(loci$abbv)) {
  
  projects = unique(loci$bioproject[loci$abbv == abbv])
  
  mat = matrix(rep(NA, length(projects) * length(projects)), nrow=length(projects),
               dimnames=list(projects, projects))
  
  for (a in projects) {
    al = loci[loci$bioproject == a]
    for (b in projects) {
      bl = loci[loci$bioproject == b]
      if (a != b) {
        mat[a,b] = sum(countOverlaps(al, bl) > 0)
      }
    }
    mat[a,] = round(mat[a,] / length(al) * 100)
  }
  
  mat  
  
}


# miRNAs ------------------------------------------------------------------

profile.df <- get_profile.df()
annotation.df <- get_annotation.df()

## high conf
mir.df <- get_mir.df()




m.df <- mir.df[mir.df$ruling == 'x x xx xx x x',]
m.df$abbv <- str_sub(m.df$project, 1,5)
m.df$mas_length <- str_length(m.df$mas)





table(m.df$abbv)
table(m.df$abbv, m.df$mas_length)

m.df$mas_length <- str_length(m.df$mas)
m.df$norm_name <- str_remove(m.df$name, "-t")

m.df$sizecall <- annotation.df$sizecall[match(paste(m.df$project, m.df$norm_name), paste(annotation.df$project, annotation.df$Name))]

m.df$sizecall <- annotation.df$
  
  

m.df <- m.df[,c('project','condition','name','locus', 'mas', 'mas_length','length','ruling', 'sizecall')]
m.df$ref <- str_split_fixed(m.df$locus, ":", 2)[,1]
m.df$start <- as.numeric(str_split_fixed(str_split_fixed(m.df$locus, ":", 2)[,2], "-", 2)[,1])
m.df$stop  <- as.numeric(str_split_fixed(str_split_fixed(m.df$locus, ":", 2)[,2], "-", 2)[,2])

dir.create("../miRNAs/strong_candidates/", showWarnings = FALSE)
for (i in 1:nrow(m.df)) {
  row        = m.df[i,]
  abbv       = row$abbv
  bioproject = row$bioproject
  rg         = row$rg
  name       = row$name
  locus      = row$locus
  
  "../+annotations/Agbis.PRJNA770841/hairpin_A/folds/locus_17-t.eps"
  source_file = file.path("../+annotations", 
                          paste(abbv, bioproject, sep='.'),
                          paste("hairpin_", rg, sep=''),
                          "folds",
                          paste(name, ".eps", sep=''))
  
  dest_file = str_glue("../miRNAs/strong_candidates/{abbv}.{bioproject}.{name}.{locus}.eps")
  
  file.copy(source_file, dest_file, overwrite = T)
  
}


m.df[,c('abbv','sizecall')]

m.df <- m.df[order(m.df$locus),]

f1 = m.df$ref[2:nrow(m.df)] == m.df$ref[1:(nrow(m.df)-1)]
f2 = m.df$start[2:nrow(m.df)] < m.df$stop[1:(nrow(m.df)-1)]

m.df <- m.df[!(f1 & f2),]

m.df <- m.df[order(m.df$mas),]

m.df[duplicated(m.df$mas),]
m.df[m.df$mas == 'CACCAAGGUGCCUUGCGUAGUUCU',]



tab = table(m.df$abbv)
barplot(tab, las=2, ylab='No. HC-miRNAs')



val.df <- as.data.frame(table(m.df$mas_length, m.df$abbv))
names(val.df) <- c('size','abbv','freq')


val.df <- dcast(val.df, size ~ abbv)
rownames(val.df) <- val.df$size
val.df$size <- NULL

par(mar=c(8,4,4,4))
lp <- layermap(val.df, 
               palette='greens',
               cluster_rows = F,
               cluster_cols = T,
               zlim=c(0,3))

lp <- lp_names(lp, 2)
lp <- lp_names(lp, 1)
lp <- lp_color_legend(lp, 1, main='Number of candidates', gap=1.2)



table(m.df$mas_length, m.df$abbv)

### less conf

m.df <- mir.df[mir.df$ruling == 'x xx xx x -',]
m.df$mas_length <- str_length(m.df$mas)


val.df <- as.data.frame(table(m.df$mas_length, m.df$abbv))
names(val.df) <- c('size','abbv','freq')


val.df <- dcast(val.df, size ~ abbv)
rownames(val.df) <- val.df$size
val.df$size <- NULL

lp <- layermap(val.df, 
               palette='greens',
               cluster_rows = F,
               cluster_cols = T,
               zlim=c(0,10))

lp <- lp_names(lp, 2)
lp <- lp_names(lp, 1)
lp <- lp_color_legend(lp, 1, main='Number of candidates')


# miRNA expression vs whole -----------------------------------------------


m.df <- mir.df[mir.df$ruling %in% c('x xx xx x -','x xx xx x x'),]
m.df$mas_length <- str_length(m.df$mas)


val.df <- as.data.frame(table(m.df$mas_length, m.df$abbv))
names(val.df) <- c('size','abbv','freq')


val.df <- dcast(val.df, size ~ abbv)
rownames(val.df) <- val.df$size
val.df$size <- NULL

miRNAs = m.df$name[m.df$bioproject == 'PRJNA193535' & m.df$rg == 'A']
miRNAs = unique(str_remove(miRNAs, "-t"))

a.df <- ann.ls[["Bocin.PRJNA193535.A"]]

f = a.df$Name %in% miRNAs
miRNA_abd = sum(a.df$Reads[f])

f = a.df$peak_locus
peak_abd = sum(a.df$Reads[f]) -  miRNA_abd

f = a.df$peak_locus
other_abd = sum(a.df$Reads) -  miRNA_abd - peak_abd

abds = c(miRNA_abd, peak_abd, other_abd)
prop = abds/sum(abds)

par(mfrow=c(1,1), mar=c(5,4,2,2))
b = barplot(prop, las=1, names.arg = c('miRNAs', "other sRNAs", 'filtered'))
par(xpd=T)
text(b, prop, round(prop,3), pos=3, col='red')
par(xpd=F)


# locus metrics ------------------------------------------------------------


ann.ls <- get_ann.ls()

l.df <- data.frame()
for (project in names(ann.ls)) {
  message(project)
  
  
  a.df <- ann.ls[[project]]
  
  a.df$abbv       = str_split(project, "\\.", 3)[[1]][1]
  a.df$bioproject = str_split(project, "\\.", 3)[[1]][2]
  a.df$rg         = str_split(project, "\\.", 3)[[1]][3]
  
  a.df <- a.df[a.df$peak_locus,]
  
  if (nrow(a.df) > 0) l.df <- rbind(l.df, a.df)
  
  
}

par(mar=c(5,5,2,2), mfrow=c(3,1))
# length
a.df <- aggregate(l.df, Length ~ abbv, median)
a.df <- a.df[order(a.df$Length),]
l.df$abbv <- factor(l.df$abbv, levels=unique(a.df$abbv))

boxplot(l.df$Length ~ l.df$abbv, outline=F, las=2, ylab='Locus Length', lty=1,
        xlab='', ylim=c(0,6000))

col = lifestyle_colors[spec.df$lifestyle[match(levels(l.df$abbv), spec.df$abbv)]]
pch = lifestyle_pch[spec.df$lifestyle[match(levels(l.df$abbv), spec.df$abbv)]]
par(xpd=T)
points(1:length(levels(l.df$abbv)), 
       rep(par()$usr[3],length(levels(l.df$abbv))),
       pch=pch,
       col=col )
par(xpd=F)

## skew

a.df <- aggregate(l.df, skew ~ abbv, median)
a.df <- a.df[order(a.df$skew),]
l.df$abbv <- factor(l.df$abbv, levels=rev(unique(a.df$abbv)))

boxplot(l.df$skew ~ l.df$abbv, outline=F, las=2, ylab='Skew', lty=1,
        xlab='')

col = lifestyle_colors[spec.df$lifestyle[match(levels(l.df$abbv), spec.df$abbv)]]
pch = lifestyle_pch[spec.df$lifestyle[match(levels(l.df$abbv), spec.df$abbv)]]
par(xpd=T)
points(1:length(levels(l.df$abbv)), 
       rep(par()$usr[3],length(levels(l.df$abbv))),
       pch=pch,
       col=col )
par(xpd=F)

## complexity 


l.df$fracuniq <- l.df$UniqueReads / l.df$Reads

a.df <- aggregate(l.df, fracuniq ~ abbv, median)
a.df <- a.df[order(a.df$fracuniq),]
l.df$abbv <- factor(l.df$abbv, levels=unique(a.df$abbv))

boxplot(l.df$fracuniq ~ l.df$abbv, outline=F, las=2,
        xlab='',
        ylab='Prop. unique', lty=1)

col = lifestyle_colors[spec.df$lifestyle[match(levels(l.df$abbv), spec.df$abbv)]]
pch = lifestyle_pch[spec.df$lifestyle[match(levels(l.df$abbv), spec.df$abbv)]]
par(xpd=T)
points(1:length(levels(l.df$abbv)), 
       rep(par()$usr[3],length(levels(l.df$abbv))),
       pch=pch,
       col=col)
par(xpd=F)



# tradeoff basics ---------------------------------------------------------



test_threshold <- function(file_name) {
  
  project = strsplit(file_name, "/")[[1]]
  project = project[length(project)-2]
  
  
  # t.df <- read.delim(file.path("~/Desktop", project, "tradeoff/thresholds.txt"))
  t.df <- read.delim(file_name)
  
  # plot(t.df$p_reads, t.df$p_genome)
  
  # t.df$dp_reads <- c(diff(t.df$p_reads), 0) * -1
  # t.df$dp_genome <- c(diff(t.df$p_genome), 0) * -1
  # 
  # t.df$dp_avg <- apply(t.df[,c('dp_reads', 'dp_genome')], 1, mean)
  # 
  # t.df$net_change <- t.df$dp_reads - t.df$dp_genome
  # median(t.df$net_change)
  # sd(t.df$net_change)
  # 
  # t.df$passing_net_change <- abs(t.df$net_change) < sd(t.df$net_change) * 1
  # 
  # 
  # par(mfrow=c(2,1))
  # par(xpd=F)
  # xlim =c(0,100)
  # plot(t.df$depth, t.df$p_reads, type='l', col='red3', xlim=xlim, main=project,
  #      ylab='Proportion', xlab='Depth (rpm)')
  # lines(t.df$depth, t.df$p_genome, col='blue2')
  # lines(t.df$depth, t.df$dp_avg)
  # abline(v=t.df$depth[which(t.df$peak == 1)])
  # legend('topright', c('p_reads','p_genome','dp_avg'), col=c('red3','blue2','black'), lwd=1, inset=0.01)
  # 
  # plot(t.df$depth, t.df$dp_reads - t.df$dp_genome, xlim=xlim, type='l',
  #      ylab="dp_reads - dp_genome", xlab='Depth (rpm)')
  # abline(h=0, lty=3, col='red')
  # abline(v=t.df$depth[match(T, t.df$passing_net_change)])
  
  
  get_knee <- function(x, y) {
    k.df <- data.frame(x=x, y=y)
    
    # k.df <- k.df[k.df$x < trim,]
    # k.df$scaled_depth = round(k.df$depth / max(k.df$depth),4)
    
    k.df$vdist = k.df$y - k.df$x
    k.df$z = apply(k.df[,c('x','y')], 1, mean)
    k.df$pdist = sqrt((k.df$z - k.df$x)^2 + (k.df$z - k.df$x)^2)
    
    k.df$kdiff = k.df$vdist - k.df$pdist
    
    peak_i = which.max(k.df$kdiff)
    
    # plot(k.df$x, k.df$y, xlim=c(0,1), ylim=c(0,1), type='l')
    # abline(a=0,b=1)
    # 
    # points(x[peak_i], y[peak_i])
    # 
    # 
    # i = 40
    # 
    # points(x[i], y[i], pch=19)
    # 
    # points(z[i], z[i])
    # 
    # segments(x[i], y[i], y[i], x[i])
    # 
    
    return(peak_i)
  }
  
  
  
  plot(t.df$p_reads, t.df$p_genome, type='l', 
       main=project, xlim=c(0.5,1), ylim=c(0,0.5))
  # knees = c(get_knee(t.df$p_genome, t.df$p_reads),
  #           get_knee(1-t.df$p_reads, 1-t.df$p_genome))
  # knee_r = min(knees):max(knees)
  # lines(t.df$p_reads[knee_r], t.df$p_genome[knee_r], col='goldenrod', lwd=3)
  # t.df[knees,]
  
  knee_i = get_knee(t.df$p_genome, t.df$p_reads)
  points(t.df$p_reads[knee_i], t.df$p_genome[knee_i], col='goldenrod', pch=19)
  
  
  
  
  
}

test_threshold("Pugra.PRJNA960906")
test_threshold("Cocin.PRJNA560364")

graphics.off()
par(mfrow=c(3,3))
for (file in Sys.glob("/Users/jax/Google Drive/++Publications/2024 - fungal  annotations/+annotations/*/tradeoff/thresholds.txt")) {
  test_threshold(file)
  # readline(prompt="Press [enter] to continue")
}

for (file in Sys.glob("/Users/jax/🔬Research/🔍2023-fungi_annotator/+YASMA_runs/*/tradeoff/thresholds.txt")) {
  message(file)
  test_threshold(file)
  # readline(prompt="Press [enter] to continue")
}




plot_alignment_rates <- function(save=F) {
  filtered.df <- get_alignment_filter()
  
  
  
  s.df <- read.delim("../data_extractors/01out-annotation_stats.txt")
  
  s.df$p_genome = s.df$final_genome_annotated / s.df$total_genome
  s.df$p_reads = s.df$final_reads_annotated / s.df$total_reads
  
  s.df <- s.df[s.df$project %in% filtered.df$project[filtered.df$f_all], c('project','p_genome', 'p_reads')]
  rownames(s.df) <- s.df$project
  s.df$project <- NULL
  
  # plot(1:nrow(s.df), s.df$p_reads, pch=19, col='red', beside=T)
  
  row.df <- s.df
  row.df$abbv <- str_sub(rownames(s.df), 1,5)
  row.df$phylum <- spec.df$phylum[match(row.df$abbv, spec.df$abbv)]
  
  
  file_name = "02-C-annotation_rates.svg"
  if (save) svglite(file_name, 4.32, 8.6)
  par(mar=c(4,8,5,8))
  lp <- layermap(s.df, zlim=c(0,1),
                 row.df=row.df)
  
  lp <- lp_names(lp, 3)
  
  lp <- lp_names(lp, 2, cex=0.7)
  
  lp <- lp_annotate(lp, 4, 'phylum', label=NA, type='points', col=phylum_colors, pch=21)
  lp <- lp_dend(lp, 4)
  
  lp <- lp_color_legend(lp, 1, titles='Prop.')
  
  lp_plot_values(lp)
  
  if (save) dev.off()
  if (save) ADsvg(file_name)
}
plot_alignment_rates()



# Filtered loci -----------------------------------------------------------

locus.df <- get_locus_filter()

## just filtered loci
tab = table(locus.df$project[locus.df$f_all])
b = barplot(tab, horiz=T, las=1, cex.names = 0.7, col='lightblue')
text(tab, b, tab, pos=4, cex=0.6, col='red')


## showing those that don't filter
tab = t(table(locus.df$project, locus.df$f_all))
b = barplot(tab, horiz=T, las=1, cex.names = 0.7, col=c('firebrick','lightblue'))
text(colSums(tab), b, colSums(tab), pos=4, cex=0.6, col='red')


## aggregating by abbv

tab = table(locus.df$project[locus.df$f_all])
tab <- as.data.frame(tab)
names(tab) <- c('project','freq')
tab$abbv <- str_sub(tab$project,1,5)

b = boxplot(tab$freq ~ tab$abbv, horizontal=T, las=1, plot=F)

plot(1,1,type='n',xlim=c(0, max(b$stats)), ylim=c(0,b$group), axes=F)
axis(1)

f = b$n == 1

points(b$stats[3,f], which(f), pch=19, col='darkred')

f = b$n > 1
segments(b$stats[2,f])

