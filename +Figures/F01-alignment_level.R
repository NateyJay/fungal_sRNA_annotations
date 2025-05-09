




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
  if (save) svglite(file_name, 7, 6.1)
  
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














