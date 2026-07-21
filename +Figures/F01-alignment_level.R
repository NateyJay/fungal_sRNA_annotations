




# Making a dendgrogram ----------------------------------------------------



plot_phy <- function(save=F) {
  phy <- phylogeny
  
  file_name="F01-tree.svg"
  if (save) svglite(file_name, 4,4)
  
  p = plot(phy,
           type='unrooted', 
           show.tip.label =F,
           edge.color='grey20',
           cex=0.4)
  
  nodelabels(node=1:length(phy$tip.label), pch=19, 
             col=phylum_colors[species.df$phylum[match(phy$tip.label, species.df$genus)]])
  tiplabels(phy$tip.label, 1:length(phy$tip.label),  bg=NA, frame='n', cex=0.3)
  
  if (save) dev.off()
  if (save) ADsvg(file_name)
  
}

plot_phy(F)


project_overview <- function(filter= F) {
  p.df <- project.df
  
  table(p.df$filter_str)
  
  if (filter) p.df <- p.df[p.df$f_pass,]
  
  total_inputs <- length(unique(p.df$project))
  
  total_species <- length(unique(p.df$abbv))
  total_species
  
  l.df <- library.df
  l.df <- nrow(l.df)
  
  
  
  
  p.df$phylum <- species.df$phylum[match(p.df$abbv, species.df$abbv)]
  tab = table(p.df$phylum[!duplicated(p.df$project)])
  
  labels = str_glue("{rownames(tab)}\n({tab})")
  
  plot(0,0, type='n', xlim=c(-2,2), ylim=c(-2,2), axes=F, xlab='', ylab='')
  p = plotrix::floating.pie(0,0, tab, col=phylum_colors[rownames(tab)])
  plotrix::pie.labels(0,0, p, labels, radius=1.2)
  

  
}

project_overview()

plot_peak_heatmap <- function(save=F) {
  p.df <- scale.df
  p.df <- p.df[p.df$project %in% project.df$project[project.df$f_pass],]
  p.df <- p.df[p.df$peak != 'None',]
  p.df <- p.df[p.df$peak == '1',]
  
  
  
  
  p.df <- dcast(p.df, project ~ size, fun.aggregate = function(x) length(x))
  rownames(p.df) <- p.df$project
  p.df$project <- NULL
  p.df <- p.df[,as.character(18:27)]
  
  row.df <- p.df
  row.df$abbv <- str_sub(rownames(row.df), 1, 5)
  row.df$genus <- species.df$genus[match(row.df$abbv, species.df$abbv)]
  row.df$phylum <- species.df$phylum[match(row.df$abbv, species.df$abbv)]
  
  file_name = "F01-peak_bool_heatmap.svg"
  if (save) svglite(file_name,4.3, 8.2)
  
  par(mar=c(5,10,5,5))
  lp <- layermap(p.df, color_scale = c('snow','purple'),
                 row.df=row.df,
                 row_groups = c('phylum','genus'),
                 group_gap=0.05)
  
  lp <- lp_group_names(lp, 2, 'genus')
  
  lp <- lp_names(lp, 3)
  
  lp <- lp_group(lp, 4, 'phylum', col=phylum_colors, plot_label = F, plot_names = F, size=0.5)

  if (save) dev.off()
  if (save) ADsvg(file_name)
  
}
plot_peak_heatmap(F)

p.df <- peak.df
p.df <- p.df[p.df$project %in% project.df$project[project.df$f_pass],]
p.df <- p.df[p.df$center > 18 & p.df$center < 28,]

p.df




scaled_heatmap <- function(save = F) {
  
  s.df <- scale.df
  # s.df <- s.df[s.df$project %in% project.df$project[project.df$f_pass],]
  
  s.df$i <- NULL
  
  
  s.df$genus <- species.df$genus[match(s.df$abbv, species.df$abbv)]
  
    
  s.df <- dcast(s.df, project ~ size, value.var='zmed')
  # s.df <- dcast(s.df, project ~ size, value.var='prop')
  
  rownames(s.df) <- s.df$project
  s.df$project <- NULL
  
  s.df[str_detect(rownames(s.df), "Bocin"),]
  
  sizes = as.character(15:29)
  s.df <- s.df[,sizes]
  
  
  
  ## merging by abbv
  s.df$abbv <- str_sub(row.names(s.df), 1, 5)
  s.df <- melt(s.df)
  s.df <- dcast(s.df, abbv ~ variable, value.var='value', fun.aggregate = mean)
  
  rownames(s.df) <- s.df$abbv
  s.df$abbv <- NULL
  
  s.df <- s.df[rowSums(s.df) > 0.05,]
  
  message(str_glue("species retained: {nrow(s.df)}"))
  
  
  
  row.df <- s.df
  # row.df$abbv <- str_sub(rownames(row.df), 1, 5)
  row.df$abbv <- rownames(row.df)
  row.df$genus <- species.df$genus[match(row.df$abbv, species.df$abbv)]
  # row.df$center = peak.df$center[match(rownames(row.df), peak.df$project)]
  # row.df$width = peak.df$width[match(rownames(row.df), peak.df$project)]
  
  
  # row.df$cluster <- 'unclustered'
  # row.df$cluster[row.df$genus %in% c('Ophiocordyceps','Beauveria','Clonostachys','Trichoderma','Fusarium')] <- 'cluster 1'
  # row.df$cluster[row.df$genus %in% c('Ceratobasidium','Coprinopsis','Pleurotus','Athelia','Rhizoctonia','Sanghuangporus')] <- 'cluster 2'
  # row.df$cluster[row.df$genus %in% c("Saccharomyces", "Naumovozyma", "Candida")] <- 'cluster 3'
  # row.df$cluster[row.df$genus %in% c("Taloromyces", "Trichophyton", "Penicillium", "Aspergillus")] <- 'cluster 4'
  # 
  # row.df$cluster[row.df$genus %in% c("Taloromyces", "Trichophyton", "Penicillium", "Aspergillus")] <- 'cluster 4'
  
  row.df$class   <- species.df$class[match(row.df$abbv, species.df$abbv)]
  row.df$phylum  <- species.df$phylum[match(row.df$abbv, species.df$abbv)]
  row.df$host    <- species.df$Pathogen[match(row.df$abbv, species.df$abbv)]
  row.df$lifestyle    <- species.df$clean_lifestyle[match(row.df$abbv, species.df$abbv)]
  row.df$species <- species.df$species[match(row.df$abbv, species.df$abbv)]
  
  row.df$class[is.na(row.df$class)] <- "MISSING"
  row.df$class[row.df$abbv %in% c('Nocer', 'Nobom')] <- "Microsporidia"
  
  
  
  file_name = "F01-scaled_abundance.svg"
  # if (save) svglite(file_name, 7, 6.1)
  if (save) svglite(file_name, 7, 7.5)
  
  par(mar=c(5,23,5,5))
  lp <- layermap(s.df,
                 row.df = row.df,
                 # zlim=c(-2,2),
                 palette='reds',
                 # zlim=c(0.05, 0.15),
                 zlim=c(0, 3),
                 row_groups = c('class'),
                 group_gap = 0.1)
  
  lp <- lp_names(lp, 2)
  lp <- lp_names(lp, 2, 'species')
  # lp <- lp_group(lp, 2, 'class', plot_names = F)
  lp <- lp_annotate(lp, 2, 'phylum', type='points', col=phylum_colors)
  lp <- lp_group_names(lp, 2, 'class')
  
  # lp <- lp_names(lp, 4, 'center')
  # lp <- lp_names(lp, 4, 'width')
  
  lp <- lp_names(lp, 3, cex=0.7)
  lp <- lp_annotate(lp, 4, 'lifestyle', col=lifestyle_colors, type='p')
  
  
  s.df$max <- apply(s.df, 1, max)
  s.df$breadth <- apply(s.df[,sizes], 1, function(x) sum(x > 0.1))
  
  lp <- lp_color_legend(lp, 1, titles='Z-score')

  if (save) dev.off()
  if (save) ADsvg(file_name)
}
scaled_heatmap(T)



peak_vs_breadth <- function() {
  s.df <- scale.df
  s.df <- s.df[s.df$project %in% project.df$project[project.df$f_pass],]
  s.df$i <- NULL
  
  
  s.df$genus <- species.df$genus[match(s.df$abbv, species.df$abbv)]
  s.df <- s.df[s.df$peak != "None",]
  s.df
  
  s.df <- merge(aggregate(prop ~ project, s.df, sum),
                aggregate(prop ~ project, s.df, max),
                by=1)
  
  s.df$abbv <- str_sub(s.df$project, 1, 5)
  s.df$phylum <- species.df$phylum[match(s.df$abbv, species.df$abbv)]
  
  names(s.df)[2:3] <- c("sum", "max")
  
  par(mar=c(5,2,4,4))
  plot(s.df$sum, s.df$max, col=phylum_colors[s.df$phylum],
       pch=19, xlim=c(0,1), ylim=c(0,1),
       ylab='Max peak prop.',
       xlab='Sum peak prop.',
       axes=F)
  axis(1)
  axis(4)
  abline(a=0,b=1,
         col='grey')
  abline(h=-0.04, v=1.04, lwd=2)
  
  
}




# Naming help -------------------------------------------------------------



s.df <- species.df

s.df <- s.df[order(s.df$class),]
s.df <- s.df[order(s.df$phylum),]




# project filter upset -----------------------------------------------------------

plot_project_filter <- function(save=F) {
  library(eulerr)
  p.df <- project.df
  p.df <- p.df[,c('f_abs_alignment', 'f_rel_alignment', 'f_has_peak', 'f_no_slope')]
  
  fit <- euler(p.df)
  fit
  
  file_name = "F01-project_filter_euler.svg"
  
  if (save) svglite(file_name, 7, 4.5)
  par(mar=c(5,5,5,5))
  plot(fit)
  
  if (save) dev.off()
  if (save) ADsvg(file_name)

}

plot_project_filter(T)


# Lifestyle to profile ----------------------------------------------------


s.df <- scale.df
s.df <- s.df[s.df$project %in% project.df$project[project.df$f_pass],]
s.df$i <- NULL


s.df$genus <- species.df$genus[match(s.df$abbv, species.df$abbv)]


s.df <- dcast(s.df, project ~ size, value.var='zmed')
# s.df <- dcast(s.df, project ~ size, value.var='prop')

rownames(s.df) <- s.df$project
s.df$project <- NULL

s.df[str_detect(rownames(s.df), "Bocin"),]

sizes = as.character(15:29)
s.df <- s.df[,sizes]


## merging by abbv
s.df$abbv <- str_sub(row.names(s.df), 1, 5)
s.df <- melt(s.df)
s.df <- dcast(s.df, abbv ~ variable, value.var='value', fun.aggregate = mean)

rownames(s.df) <- s.df$abbv
s.df$abbv <- NULL

lf.df <- data.frame(abbv = rownames(s.df),
                    peak = apply(s.df, 1, function(x) names(s.df)[which.max(x)]),
                    lifestyle = species.df$clean_lifestyle[match(rownames(s.df), species.df$abbv)])
lf.df$peak <- as.numeric(lf.df$peak)

par(mar=c(4,10,4,2))
boxplot(lf.df$peak ~ lf.df$lifestyle, horizontal=T, las=1, xlab="Peak size",
        ylab='',
        main=)


row.df <- s.df
# row.df$abbv <- str_sub(rownames(row.df), 1, 5)
row.df$abbv <- rownames(row.df)
row.df$genus <- species.df$genus[match(row.df$abbv, species.df$abbv)]
# row.df$center = peak.df$center[match(rownames(row.df), peak.df$project)]
# row.df$width = peak.df$width[match(rownames(row.df), peak.df$project)]


# row.df$cluster <- 'unclustered'
# row.df$cluster[row.df$genus %in% c('Ophiocordyceps','Beauveria','Clonostachys','Trichoderma','Fusarium')] <- 'cluster 1'
# row.df$cluster[row.df$genus %in% c('Ceratobasidium','Coprinopsis','Pleurotus','Athelia','Rhizoctonia','Sanghuangporus')] <- 'cluster 2'
# row.df$cluster[row.df$genus %in% c("Saccharomyces", "Naumovozyma", "Candida")] <- 'cluster 3'
# row.df$cluster[row.df$genus %in% c("Taloromyces", "Trichophyton", "Penicillium", "Aspergillus")] <- 'cluster 4'
# 
# row.df$cluster[row.df$genus %in% c("Taloromyces", "Trichophyton", "Penicillium", "Aspergillus")] <- 'cluster 4'

row.df$class   <- species.df$class[match(row.df$abbv, species.df$abbv)]
row.df$phylum  <- species.df$phylum[match(row.df$abbv, species.df$abbv)]
row.df$host    <- species.df$Pathogen[match(row.df$abbv, species.df$abbv)]
row.df$lifestyle    <- species.df$clean_lifestyle[match(row.df$abbv, species.df$abbv)]
row.df$species <- species.df$species[match(row.df$abbv, species.df$abbv)]

row.df$class[is.na(row.df$class)] <- "MISSING"
row.df$class[row.df$abbv %in% c('Nocer', 'Nobom')] <- "Microsporidia"






# Biases ------------------------------------------------------------------

## 5p nt bias --------------------------------------------------------------

plot_complicated_fivep_bias <- function(save=F) {
  df <- read.delim("../nucleotide_bias/01out-5p_bias.txt")
  
  head(df)
  df <- dcast(df, project + size ~ fivep)
  head(df)
  
  df <- df[rowSums(df[,c('A','C','G','T')]) > 0,]
  
  
  df <- cbind(df, df[, c('A','C','G','T')] / rowSums(df[, c('A','C','G','T')]))
  names(df)[(ncol(df)-3):ncol(df)] <- c('pA', 'pC', 'pG', 'pT')
  
  highest_prominence <- function(x) {
    x = sort(x, decreasing = T)
    x[1] - x[2]
    
  }
  
  df$highest <- apply(df[,c('pA', 'pC', 'pG', 'pT')], 1, max)
  df$which   <- apply(df[,c('A','C','T','G')], 1, function(x) {names(x)[which.max(x)]})
  df$prom <- apply(df[,c('pA', 'pC', 'pG', 'pT')], 1, highest_prominence)
  
  df <- df[df$size >= 15 & df$size <= 30,]
  
  ## filtering bull shit projects
  j.df <- project.df
  j.df <- j.df[j.df$f_pass & j.df$project %in% df$project,]
  
  df <- df[df$project %in% j.df$project,]
  
  
  
  highest_mat <- dcast(df, project ~ size, value.var='highest')
  which_mat   <- dcast(df, project ~ size, value.var='which')
  prom_mat    <- dcast(df, project ~ size, value.var='prom')
  
  
  # df$mod <- df$highest + (match(df$which, c('A','T','G','C')) - 1)*10
  df$mod <- df$prom + (match(df$which, c('A','T','G','C')) - 1)*10
  mat <- dcast(df, project ~ size, value.var='mod')
  rownames(mat) <- mat$project
  mat$project <- NULL
  mat[is.na(mat)] <- 0
  
  
  color_scale = c()
  for (col_set in c("reds", 'purples','greens','grays')) {
    max_color = hcl.colors(2, col_set, rev = T)[2]
    color_scale = c(color_scale, 
                    rep('white', 5),
                    hcl.colors(65, col_set, rev = T),
                    rep(max_color, 30),
                    rep('orange',900))
    
    
  }
  
  file_name="F01-comp_fivep_bias.svg"
  if (save) svglite(file_name, 4.8, 9)
  
  par(mar=c(5,10,5,5), mfrow=c(1,1))
  lp <- layermap(mat,
                 color_scale = color_scale,
                 zlim=c(0,40),
                 cluster_rows = T)
  
  lp <- lp_names(lp, 3)
  lp <- lp_names(lp, 2)
  lp <- lp_color_legend(lp, 1)
  
  if (save) dev.off()
  if (save) ADsvg(file_name)
  
}

plot_complicated_fivep_bias(F)

### simpler

plot_fivep_bias <- function(save=F) {
  df <- read.delim("../nucleotide_bias/01out-5p_bias.txt")
  
  head(df)
  df <- dcast(df, project + size ~ fivep)
  head(df)
  
  df <- df[rowSums(df[,c('A','C','G','T')]) > 0,]
  
  
  df <- cbind(df, df[, c('A','C','G','T')] / rowSums(df[, c('A','C','G','T')]))
  names(df)[(ncol(df)-3):ncol(df)] <- c('pA', 'pC', 'pG', 'pT')
  
  file_name="F01-fivep_bias.svg"
  if (save) svglite(file_name, 8.7, 40)
  
  par(mar=c(2,2,2,1), las=1, xpd=F)
  if (save) {
    par(mfrow=c(31,5))
  } else {
    par(mfrow=c(6,5))
  }
  
  base_colors = c(pA='red',`pT`='blue','pG'='seagreen',pC='black')
  
  for (project in unique(df$project)) {
    p.df <- df[df$project==project,]
    
  
    
    aln_rate  = round(project.df$alignment_rate[project.df$project == project]*100)
    aln_count = round(project.df$total_aligned[project.df$project == project] / 1000000)
    if (length(aln_rate) == 0) {aln_rate=0; aln_count=0}
    
    if (aln_rate < 2 | aln_count < 2) next
    
    plot(1,1,type='n', main=project, xlim=c(15,30), ylim=c(0,0.8), xlab='size',ylab='Prop', axes=F)
    box()
    axis(1, at=c(15,20,25,30))
    axis(2, at=c(0,0.25,0.5,0.75))
    abline(h=c(0,0.25,0.5,0.75), col='salmon',lty=3)
    
    for (base in c('pA','pT','pG','pC')) {
      lines(p.df$size, p.df[[base]], col=base_colors[base], type='o',cex=0.8, pch=19)
    }
    
    text(15,0.75, str_glue("{aln_count}M ({aln_rate}%)") , adj=c(0,1), cex=0.9)
  
  }
  
  if (save) dev.off()
  if (save) ADsvg(file_name)
                  
}

plot_fivep_bias(F)




## 5' bias total proportion ------------------------------------------------

plot_fivep_bias_proportion <- function(save=F) {
  df <- read.delim("../nucleotide_bias/01out-5p_bias.txt")
  df <- dcast(df, project ~ size + fivep)
  rownames(df) <- df$project
  df$project <- NULL
  
  df <- df / rowSums(df)
  
  cat.df <- as.data.frame(readxl::read_excel('01-bias_categorization.xlsx'))
  cat.df <- cat.df[!cat.df$`peak range` %in% c('none','noise','NA','multi'),]
  
  file_name="F01-fivep_bias_prop.svg"
  if (save) svglite(file_name, 8.7, 60)
  
  if (save) {
    par(mfrow=c(48,5))
  } else {
    par(mfrow=c(5,4))
  }
  
  
  par(mar=c(4,3,2,1))
  par(las=1)
  
  for (project in rownames(df)) {
    p.df <- as.data.frame(str_split_fixed(names(df), "_", 2))
    names(p.df) <- c('size','base')
    p.df$size <- as.numeric(p.df$size)
    p.df$prop <- unlist(df[project,])
    
    p.df <- dcast(p.df, base ~ size, value.var='prop')
    rownames(p.df) <- p.df$base
    p.df$base <- NULL
    
    plot(1,1,type='n', xlim=c(15,30), ylim=c(0, 0.15),
         main=project, xlab='', ylab='')
    
    if (project %in% cat.df$project) {
      range = cat.df$`peak range`[cat.df$project == project]
      range = as.numeric(str_split(range, "-")[[1]])
      
      rect(min(range)-0.5, -1, max(range)+0.5, 1.15, 
           border=NA, col='grey80')
      box()
      
    }
    
    
    base_colors = c(A='red',`T`='blue','G'='seagreen',C='black')
    
    for (base in names(base_colors)) {
      lines(15:30, p.df[base,as.character(15:30)], 
            col=base_colors[base],
            type='o',
            pch=19)
    }
    
  }
  
  if (save) dev.off()
  if (save) ADsvg(file_name)
}

plot_fivep_bias_proportion(T)

write.table(project.df[,c('project','filter_str','f_pass')],
            file="01-bias_categorization.txt", quote=F, 
            row.names = F, sep='\t'
            )




# plot_fivep_logo <- function(save=F) {
#   df <- read.delim("../nucleotide_bias/01out-5p_bias.txt")
#   df <- dcast(df, project ~ size + fivep)
#   rownames(df) <- df$project
#   df$project <- NULL
#   
#   df <- df / rowSums(df)
#   
#   # par(mfrow=c(5,4))
#   # par(mar=c(4,3,2,1))
#   par(las=1)
#   
#   for (project in rownames(df)) {
#     p.df <- as.data.frame(str_split_fixed(names(df), "_", 2))
#     names(p.df) <- c('size','base')
#     p.df$size <- as.numeric(p.df$size)
#     p.df$prop <- unlist(df[project,])
#     
#     p.df <- dcast(p.df, base ~ size, value.var='prop')
#     rownames(p.df) <- p.df$base
#     p.df$base <- NULL
#     
#     plot(1,1,type='n', xlim=c(15,30), ylim=c(0, 0.15),
#          main=project, xlab='', ylab='')
#     
#     
#     base_colors = c(A='red',`T`='blue','G'='seagreen',C='black')
#     
#     for (base in names(base_colors)) {
#       lines(15:30, p.df[base,as.character(15:30)], 
#             col=base_colors[base],
#             type='o',
#             pch=19)
#     }
#     
#   }
# }






## gc bias -----------------------------------------------------------------

plot_gc_bias <- function(save=F) {
  df <- read.delim("../nucleotide_bias/02out-gc_bias.txt")
  
  # for ()
  # 
  # head(df)
  # df <- dcast(df, project + size ~ fivep)
  # head(df)
  # 
  # df <- df[rowSums(df[,c('A','C','G','T')]) > 0,]
  # 
  # 
  # df <- cbind(df, df[, c('A','C','G','T')] / rowSums(df[, c('A','C','G','T')]))
  # names(df)[(ncol(df)-3):ncol(df)] <- c('pA', 'pC', 'pG', 'pT')
  # 
  
  p.df <- df
  
  p.df$gc[p.df$gc == 100] <- 99
  p.df$bin <- floor(p.df$gc /10)*10
  
  p.df <- dcast(p.df, project + size ~ bin, value.var='count', sum)
  p.df[is.na(p.df)] <- 0
  
  # rownames(p.df) <- p.df$size
  # p.df$size <- NULL
  columns = as.character((0:9)*10)
  
  p.df$bin_median <- apply(p.df[,columns], 1, function(x) names(x)[which(cumsum(x)/sum(x)>0.5)[1]] )
  
  get_bin_mean <- function(x) {
    x[is.na(x)] <- 0
    sum(x * as.numeric(names(x))) / sum(x)
  }
  p.df$bin_mean <- apply(p.df[,columns], 1, get_bin_mean)
  
  m.df <- p.df[,c('project', 'size','bin_mean')]
  m.df <- dcast(m.df, project ~ size)
  rownames(m.df) <- m.df$project
  m.df$project <- NULL
  
  m.df[is.na(m.df)] <- 50
  m.df <- m.df[,as.character(15:30)]
  
  
  ## filtering out garbage
  j.df <- project.df
  j.df <- j.df[j.df$f_pass & j.df$project %in% rownames(m.df),]
  
  m.df <- m.df[j.df$project,]
  
  
  row.df <- data.frame(row.names = row.names(m.df), 
                       abbv = str_sub(row.names(m.df), 1, 5))
  row.df$class <- species.df$class[match(row.df$abbv, species.df$abbv)]
  row.df$phylum <- species.df$phylum[match(row.df$abbv, species.df$abbv)]
  row.df$peak_score <- peak.df$prop[match(row.names(row.df), peak.df$project)]
  
  file_name="F01-gc_bias.svg"
  if (save) svglite(file_name, 6, 9)
  par(mar=c(5,10,5,10))
  lp <- layermap(m.df, zlim=c(30,70), palette = 'puor',
                 row.df = row.df,
                 # row_groups = 'abbv',
                 group_gap = 0.1)
  
  lp <- lp_names(lp, 3)
  lp <- lp_dend(lp, 4)
  # lp <- lp_group_names(lp, 2, 'abbv')
  lp <- lp_annotate(lp, 2, 'class', palette='zissou')
  lp <- lp_annotate(lp, 2, 'phylum', col=phylum_colors)
  lp <- lp_annotate(lp, 2, 'peak_score', palette='reds', zlim=c(0,1))
  lp <- lp_color_legend(lp, 1, titles='% GC content')
  
  legend('topright', names(lp$legend$class), fill=lp$legend$class,
         inset=c(-.8, 0), cex=0.6)
  legend('bottomright', names(lp$legend$phylum), fill=lp$legend$phylum,
         inset=c(-.8, 0), cex=0.6)
    
  
  if (save) dev.off()
  if (save) ADsvg(file_name)
  
}


plot_gc_bias(T)




# GINIs -------------------------------------------------------------------


plot_gini <- function(project='Bocin.PRJNA431815') {
  
  message(project)
  
  abbv       = strsplit(project, '\\.')[[1]][1]
  bioproject = strsplit(project, '\\.')[[1]][2]
  
  l.df <- library.df[library.df$bioproject == bioproject,]
  l.df
  
  plot_gini_line <- function(library) {
    message(library)
    gini_file = str_glue("../gini_alignment/01out-ginis/{library}.gini.txt")
    
    if (!file.exists(gini_file)) return()
    
    df <- read.delim(gini_file, comment.char = "#")
    
    
    # Create an rle object
    rle_object <- list(lengths = df$bin_count, values = df$depth)
    class(rle_object) <- "rle"
    
    v.df <- data.frame(depth=sort(inverse.rle(rle_object)))
    v.df$cumulative <- cumsum(v.df$depth)
    v.df$prop <- v.df$cumulative / sum(v.df$depth)
    
    lines((1:nrow(v.df))/nrow(v.df), v.df$prop)
  }
  
  par(las=1, mfrow=c(2,1))
  
  xlim = c(0.5,1)
  ylim = c(0,1)
  main = project
  
  plot(1,1,type='l', xlim=xlim, ylim=ylim, 
       xlab='Cumulative genomic space', ylab='Cumulative aligned reads',
       main=main)
  abline(v=1, h=0, lty=3)
  abline(a=0,b=1, col='red')
  for (library in l.df$srr) {
    plot_gini_line(library)
  }
  
  abbv = l.df$abbv[1]
  
  s.df <- read.delim(str_glue("../gini_alignment/01out-ginis_quantiles/{project}.gini_q.txt"), comment.char = "#")
  s.df$quantile <- round(s.df$quantile, 2)
  s.df$size[s.df$size < 20] <- 19
  s.df$size[s.df$size > 25] <- 26
  
  s.df <- dcast(s.df, quantile ~ size, fun.aggregate = sum, value.var = 'depth')
  head(s.df)  
  rownames(s.df) <- s.df$quantile
  s.df$quantile <- NULL
  s.df <- s.df / rowSums(s.df)
  # barplot(t(s.df))  
  s.df <- t(s.df)
  
  columns = as.character(seq(xlim[1], xlim[2], 0.01))
  for (column in columns) {
    if (!column %in% colnames(s.df)) {
      s.df <- cbind(s.df, rep(0, nrow(s.df)))
      colnames(s.df)[ncol(s.df)] <- column
    }
  }
  s.df <- s.df[, columns]
  
  # rows = as.character(15:50) 
  # for (row in rows) {
  #   if (!row %in% rownames(s.df)) {
  #     s.df <- rbind(s.df, rep(0, ncol(s.df)))
  #     rownames(s.df)[nrow(s.df)] <- row
  #   }
  # }
  # s.df <- s.df[rows,]
  
  color <- c(`19`='grey20', size_colors[as.character(20:25)], `26`='grey80')
  
  s.df <- s.df[names(color),]
  
  barplot(s.df, col=color, space=0)
  
  
}
plot_gini()
plot_gini("Agbis.PRJNA770841")
plot_gini('Alalt.PRJNA475703')
plot_gini("Fuoxy.PRJNA562097")


plot_gini("Maory.PRJNA310070")
plot_gini("Fuoxy.PRJNA562097")
plot_gini("Fuoxy.PRJNA562097")
plot_gini("Fuoxy.PRJNA562097")
plot_gini("Fuoxy.PRJNA562097")
plot_gini("Fuoxy.PRJNA562097")


dir.create("01-ginis")
for (file in Sys.glob("../gini_alignment/01out-ginis_quantiles/*.txt")) {
  project = str_remove(basename(file), '.gini_q.txt')
  
  out_file = str_glue("01-ginis/{project}.gini.svg")
  svglite(out_file, 5.5, 7)
  plot_gini(project)
  dev.off()
  ADsvg(out_file)
}



# feature alignments ------------------------------------------------------




out.df <- data.frame()
for (file in list.files("../alignment_to_features/01out-counts/")) {
  df <- read.delim(paste0("../alignment_to_features/01out-counts/",file))
  out.df <- rbind(out.df, df)
}

out.df <- out.df[order(out.df$project, out.df$sizing, out.df$feature),]
out.df <- out.df[out.df$feature != 'unmapped',]
out.df

out.df$structural <- as.numeric(str_detect(out.df$feature, 'structural'))
out.df$TE <- as.numeric(str_detect(out.df$feature, 'TE'))
out.df$promoter <- as.numeric(str_detect(out.df$feature, 'promoter'))
out.df$gene <- as.numeric(str_detect(out.df$feature, 'gene'))
out.df$sRNA <- as.numeric(str_detect(out.df$feature, 'sRNA_metalocus'))
out.df$str <- paste(out.df$structural, out.df$TE, out.df$gene, out.df$sRNA, sep='')


# project = 'Bocin.PRJNA752615'
project = 'Bocin.PRJNA253747'

# c.df <- dcast(out.df, project + sizing + str ~ 'depth', value.var='count', fun.aggregate = sum)
# 
# c.df[c.df$project == project,]
# c.df$project <- NULL
# 
# c.df <- dcast(c.df, str ~ sizing, value.var='depth', fun.aggregate = sum)
# rownames(c.df) <- c.df$str
# c.df$str <- NULL
# barplot(t(c.df[,c('sRNA'), drop=F]), horiz=T, las=1)





make_feature_count_plot <- function(save=F) {

  projects = unique(out.df$project)
  
    
  file_name = paste0("F01-feature_counts.svg")
  if (save) svglite(file_name, 7,60)
  
  if (save) par(mfrow=c(40,3))
  if (save) par(mar=c(3,8,1,2))
  if (save) par(las=1)
  
  for (project in projects) {
    if (is.na(project)) break
    
    o.df <- out.df[out.df$project == project,]
    o.df$cat <- 'non-genic'
    o.df$cat[o.df$sRNA==1] <- 'intergenic sRNA'
    o.df$cat[o.df$promoter==1] <- 'near-pcg'
    o.df$cat[o.df$gene==1] <- 'pcg'
    o.df$cat[o.df$TE==1] <- 'TE'
    o.df$cat[o.df$structural==1] <- 'structural'
    
    o.df$cat <- factor(o.df$cat, levels = rev(c('structural', 'TE','pcg','near-pcg','intergenic sRNA', 'non-genic')))
    
    
    o.df <- dcast(o.df, cat ~ sizing, value.var='count', fun.aggregate = sum)
    rownames(o.df) <- o.df$cat
    o.df$cat <- NULL
    
    # par(mar=c(4,8,4,2))
    barplot(t(o.df), beside=T, horiz=T, las=1, col=c('grey50', 'gold'), main=project)
    
  }
  if (save) dev.off()
  if (save) ADsvg(file_name)
  
}

make_feature_count_plot(T)



# simple size profiles ----------------------------------------------------



project = 'Bocin.PRJNA1092616'
project = 'Bocin.PRJNA730711'
project = 'Bocin.PRJNA282705'

for (project in project.df$project[project.df$abbv == 'Bocin']) {
  depth_file <- file.path("/Users/jax/fungal_annotations/annotations", project,  "align/alignment.depth.txt")
  if (!file.exists(depth_file)) next
  depth.df <- read.delim(depth_file)
  
  l.df <- library.df[library.df$project == project,]
  depth.df$condition = l.df$rg[match(depth.df$rg, l.df$srr)]
  
  d.df <- dcast(depth.df, condition ~ length, value.var='abundance', fun.aggregate = sum)
  d.df
  
  row.names(d.df) <- d.df$condition
  d.df$condition <- NULL
  
  d.df <- d.df/rowSums(d.df)
  
  
  colors = hcl.colors(nrow(d.df), palette = 'zissou')
  
  plot(1,1, type='n', xlim=c(15,35), ylim=c(0, 0.4), main=project)
  for (i in 1:nrow(d.df)) lines(as.numeric(names(d.df)), d.df[i,], type='o', pch=19, cex=0.5, col=colors[i])
  legend('topright', rownames(d.df), pch=19, col=colors, cex=0.5)
}




