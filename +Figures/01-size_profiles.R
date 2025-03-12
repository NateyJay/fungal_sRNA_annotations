



df <- read.delim("../peaks/01out-peak_tables.txt", header=F)
names(df) <- c('project','i','size','prop','zeroprop','zprop','cand','ext','peak')

df <- dcast(df, project ~ size, value.var='prop')
head(df)


summary.df <- read.delim("../peaks/01out-peak_summary.txt", header=F)
names(summary.df) <- c('project','peak','sizes','peak_size','width','prop','per_prop')
summary.df <- summary.df[summary.df$peak != "none",]


row.names(df) <- df$project
df$project <- NULL


df <- df[order(rownames(df)),]

row.df <- data.frame(row.names=rownames(df), 
                     species = str_split_fixed(rownames(df), "\\.", 2)[,1],
                     project = str_split_fixed(rownames(df), "\\.", 3)[,2],
                     both = rownames(df))
row.df <- row.df[!duplicated(rownames(row.df)),]
row.df <- merge(row.df, summary.df, by.x=0, by.y='project')
row.df <- row.df[!duplicated(row.df$Row.names),]
rownames(row.df) <- row.df$Row.names
row.df$Row.names <- NULL


save=T
if (save) {
  file_name = "01-size_props.svg"
  svglite::svglite(file_name, 7, 21)
}




par(mar=c(4,15,4,6))

lp <- layermap(df,
               row.df=row.df,
               row_groups = c('species', 'project'),
               palette = 'reds',
               reverse_palette = T,
               zlim=c(0,0.4),
               group_gap=0.04)



# left
lp <- lp_group_names(lp, 2, 'project')
lp <- lp_group(lp, 2, 'species', gap=5, labels=F)
lp <- lp_group_names(lp, 2, 'species')

# top
lp <- lp_names(lp, 3)

# right
lp <- lp_annotate(lp, 4, 'prop', palette = 'blues')
lp <- lp_names(lp, 4, 'sizes')

# bottom
# lp <- lp_color_legend(lp, 1)

if (save) {
  dev.off()
  ADsvg(file_name)
}




# Making peak heatmap -----------------------------------------------------


summary.df <- read.delim("../peaks/01out-peak_summary.txt", header=F)
names(summary.df) <- c('project','peak','sizes','peak_size','width','prop','per_prop')
summary.df <- summary.df[summary.df$peak != "none",]
summary.df$species <- str_split_fixed(summary.df$project,"\\.",2)[,1]
summary.df$bioproject <- str_split_fixed(summary.df$project,"\\.",3)[,2]

out.df <- data.frame()
for (i in 1:nrow(summary.df)) {
  for (size in str_split(summary.df[i,'sizes'],',')[[1]]) {
    
    out.df <- rbind(out.df,
                    cbind(project=summary.df[i,'project'],
                          peak=summary.df[i,'peak'],
                          peak_size=summary.df[i,'peak_size'],
                          width=summary.df[i,'width'],
                          prop=summary.df[i,'prop'],
                          size=size))
  }
}


out.df <- dcast(out.df, project ~ size, value.var = 'peak')
out.df[is.na(out.df)] <- ''
row.names(out.df) <- out.df$project
out.df$project <- NULL

row.df <- summary.df
row.df <- row.df[!duplicated(row.df$project),]
rownames(row.df) <- row.df$project

row.df <- row.df[order(row.df$project),]

bioproject_colors <- setNames(rep(c('gold','grey20'),length(unique(row.df$bioproject))/2)[1:length(unique(row.df$bioproject))],
                              unique(row.df$bioproject))


row.df$bioproject_color <- bioproject_colors[row.df$bioproject]

sum(!rownames(row.df) %in% rownames(out.df))
sum(!rownames(out.df) %in% rownames(row.df))


source("~/Desktop/++github/layermap/R/layermap.R")



save=T
if (save) {
  file_name = "01-size_peaks.svg"
  svglite::svglite(file_name, 7, 21)
}



par(mar=c(4,15,4,6))

lp <- layermap(out.df,
               color_scale = c(peak1='salmon',peak2='navyblue', peak3='goldenrod'),
               row.df = row.df,
               row_groups = c('species','bioproject'),
               reverse_palette = T,
               group_gap=0.04)



# left
lp <- lp_group_names(lp, 2, 'bioproject')
lp <- lp_group(lp, 2, 'species',labels=F, gap=5)
lp <- lp_group_names(lp, 2, 'species')

# top
lp <- lp_names(lp, 3)

# right
# lp <- lp_names(lp, 4, 'sizes')

# bottom
# lp <- lp_color_legend(lp, 1)


if (save) {
  dev.off()
  ADsvg(file_name)
}



# Now with (near) full data -----------------------------------------------


get_profile.df <- function() {
  p.df = data.frame()
  files <- list.files("../depth_profiles/01out-depth_profiles/")
  
  for (file in files) {
    abbv       = str_split(file, "\\.")[[1]][1]
    bioproject = str_split(file, "\\.")[[1]][2]
    
    
    message(paste(abbv, bioproject, sep='.'))
    
    md.df <- meta.df[meta.df$bioproject == bioproject, c('bioproject','srr','Replicate group', 'Dicer Mutant')]
    
    df <- read.delim(paste('../depth_profiles/01out-depth_profiles/', file, sep=''))
    df$rg <- str_remove(df$rg, "_1")
    
    df <- dcast(df, rg ~ length, value.var = 'abundance', fun.aggregate = sum)
    rownames(df) <- df$rg
    df$rg <- NULL
    
    df = df / rowSums(df)
    
    for (l in 15:50) {
      if (!as.character(l) %in% names(df)) {
        df[[as.character(l)]] <- NA
      }
    }
    
    df$srr <- rownames(df)
    df$bioproject <- bioproject
    df$abbv <- abbv
    df$rg <- md.df$`Replicate group`[match(df$srr, md.df$srr)]
    
    df <- df[,c('bioproject','srr','abbv','rg', as.character(15:50))]
    p.df <- rbind(p.df, df)
    
    
  }
  return(p.df)
  
}

profile.df <- get_profile.df()



## heatmap -----------------------------------------------------------------


p.df <- profile.df


p.df <- p.df[p.df$bioproject %in% meta.df$bioproject[meta.df$has_dicer_mutant],]

p.df <- melt(p.df, id.vars=c('bioproject','srr','abbv','rg'))
head(p.df)
p.df <- dcast(p.df, bioproject + abbv + rg ~ variable, value.var = 'value', fun.aggregate = mean)

rownames(p.df) <- str_c(p.df$bioproject, p.df$rg, sep='.')

mutant_colors = c(wt='black',d1='cadetblue',d2='aquamarine2',d1d2='cornflowerblue',q2='cadetblue')

val.df <- p.df[,as.character(15:35)]
row.df <- p.df[,c('bioproject','abbv','rg')]
row.df$genotype <- 'wt'

row.df$genotype[grepl("d1", row.df$rg)] <- 'd1'
row.df$genotype[grepl("d2", row.df$rg)] <- 'd2'
row.df$genotype[grepl("d1d2", row.df$rg)] <- 'd1d2'

par(mfrow=c(1,1))
par(mar=c(5,10,5,2))
lp <- layermap(val.df,
               row.df=row.df,
               row_groups = c('bioproject', 'abbv', 'genotype'),
               palette = 'reds',
               zlim=c(0,0.15))


# left

lp <- lp_annotate(lp, 2, "genotype", type='points',
                  col=mutant_colors)
lp <- lp_group(lp, 2, 'abbv')
lp <- lp_group_names(lp, 2, 'bioproject', gap=1)

# top
lp <- lp_names(lp, 3)


## lines -------------------------------------------------------------------



n.df <- read.delim("../normalization/control_alignment.txt")
n.df$rpm <- n.df$map / n.df$total * 1000000

p.df <- profile.df


p.df <- p.df[p.df$bioproject %in% meta.df$bioproject[meta.df$has_dicer_mutant],]

p.df$genotype <- 'wt'
p.df$genotype[grepl("d1", p.df$rg)] <- 'd1'
p.df$genotype[grepl("d2", p.df$rg)] <- 'd2'
p.df$genotype[grepl("d1d2", p.df$rg)] <- 'd1d2'
p.df$genotype[grepl("q2", p.df$rg)] <- 'q2'

mutant_colors = c(wt='black',d1='cadetblue',d2='aquamarine2',d1d2='cornflowerblue',q2='cadetblue')
p.df$col <- mutant_colors[p.df$genotype]

head(p.df)

par(mfrow=c(length(unique(p.df$bioproject)),1))
par(mar=c(2,5,0,0))
for (p in unique(p.df$bioproject)) {
  
  l.df <- p.df[p.df$bioproject == p,]
  l.df <- l.df[order(l.df$genotype),]
  
  rpms = n.df$rpm[match(l.df$srr, n.df$library)]
  
  if (is.na(rpms[1])) rpms = rep(1, length(rpms))
  
  l.df[,as.character(15:50)] <- l.df[,as.character(15:50)] /  apply(l.df[, as.character(15:36)], 1, max, na.rm=T)
  # l.df[,as.character(15:50)] <- t(scale(t(l.df[,as.character(15:50)])))
  # l.df[,as.character(15:50)] <- l.df[,as.character(15:50)] /  apply(l.df[, as.character(15:36)], 1, max, na.rm=T) / rpms
  
  
  
  
  ylim=c(0,max(l.df[,as.character(15:36)], na.rm = T)*1.1)
  # ylim=c(0,1)
  # ylim=c(0, .4)
  plot(1,1,type='n', xlim=c(15,35), ylim=ylim, xlab='size', ylab='prop', las=1)
  
  for (i in 1:nrow(l.df)) {
    lines(15:35, l.df[i, as.character(15:35)], col=l.df$col[i], lwd=2)
  }  
  
  text(15, ylim[2], adj=c(0,1.3), paste(l.df$abbv[1], l.df$bioproject[1], sep='.'))
  
}





# normalization -----------------------------------------------------------


# basic view --------------------------------------------------------------
## aggregating by species

profile.df <- get_profile.df()

p.df <- profile.df
p.df <- p.df[!is.na(p.df$`22`),]


p.df <- melt(p.df)
names(p.df) <- c('bioproject','srr','abbv','rg','size','prop')
p.df <- aggregate(prop ~ bioproject + abbv + rg + size, p.df, mean)
p.df <- aggregate(prop ~ bioproject + abbv + size, p.df, mean)
p.df <- aggregate(prop ~ abbv + size, p.df, mean)
p.df <- dcast(p.df, abbv ~ size, value.var = 'prop')


val.df <- p.df[,as.character(15:40)]
val.df[is.na(val.df)] <- 0

row.df <- p.df[,c('abbv'), drop=F]

make_cat_df <- function() {
  df <- as.data.frame(readxl::read_excel("/Users/jax/🔬Research/🚸Colleagues/Lorena/Advances_II_data/Sup. table 2. - Lorena Melet.xlsx"))
  head(df)
  
  df$abbv <- str_c(
    str_sub(str_split_fixed(df$SpeciesName, " ", 3)[,1], 1,2), 
    str_sub(str_split_fixed(df$SpeciesName, " ", 3)[,2], 1,3),
    sep='')
  
  
  
  df <- df[,c('SpeciesName','pDCR_category')]
  df <- dcast(df, SpeciesName ~ pDCR_category)
  head(df)
  
  df <- df[df$`NA` == 0,]
  df$`NA` <- NULL
  
  head(df)
  rownames(df) <- df$SpeciesName
  df$SpeciesName <- NULL
  
  df$str <- apply(df, 1, paste, collapse='')
  df$abbv <- str_c(
    str_sub(str_split_fixed(rownames(df), " ", 3)[,1], 1,2), 
    str_sub(str_split_fixed(rownames(df), " ", 3)[,2], 1,3),
    sep='')
  
  return(df)
}


cat.df <- make_cat_df()

head(cat.df)








col.df <- data.frame(row.names = names(val.df),
                     cat= c(
                       rep_len('small',length(15:18)),
                     rep_len('normal',length(19:24)),
                     rep_len('large',length(25:40))))
                     # rep_len('too large',length(39:50))))
col.df$cat <- factor(col.df$cat, levels=c('small','normal','large','too large'))


# colors = c(hcl.colors(100,'PuBuGn', rev=T)[10:100])

par(mfrow=c(1,1))
par(mar=c(3,10,2,6))
lp <- layermap(val.df,
               palette = 'PuBuGn',
               # color_scale = colors,
               zlim=c(0,0.15),
               row.df=row.df,
               column.df=col.df)
               # column_groups = 'cat',
               # group_gap = 0)


# top
lp <- lp_names(lp, 3)


# left
lp <- lp_names(lp, 2, 'abbv')

# right
lp <- lp_dend(lp, 4)

# bottom
lp <- lp_color_legend(lp, 1, size_p=0.4, round=2)


## wide view

profile.df <- get_profile.df()
peak_filter <- make_peak_filter()

plot_wide_profile = function(save=F, hard_filter=F) {
  file="01-A-size_profile_aggregated.svg"
  
  p.df <- profile.df
  # p.df <- p.df[!is.na(p.df$`22`),]
  
  
  p.df <- melt(p.df)
  names(p.df) <- c('bioproject','srr','abbv','rg','size','prop')
  p.df <- p.df[!grepl("\\.", p.df$rg),]
  p.df <- aggregate(prop ~ bioproject + abbv + rg + size, p.df, mean)
  p.df <- aggregate(prop ~ bioproject + abbv + size, p.df, mean)
  p.df <- aggregate(prop ~ abbv + size, p.df, mean)
  p.df <- dcast(p.df, abbv ~ size, value.var = 'prop')
  
  rownames(p.df) <- p.df$abbv
  p.df$abbv <- NULL
  
  if (hard_filter) {
    p.df <- p.df[rownames(peak_filter$peak_filter), colnames(peak_filter$peak_filter)]
    p.df <- p.df * peak.ls$peak_filter
    
  }
  
  
  val.df <- t(p.df)
  val.df[is.na(val.df)] <- 0
  colnames(val.df) <- rownames(p.df)
  
  find_peak <- function(x) {
    w=which(x == max(x, na.rm=T))
  }
  ord = as.numeric(rownames(val.df)[apply(val.df, 2, find_peak)])
  val.df <- val.df[, order(ord)]
  # hc = hclust(dist(t(val.df[as.character(20:30),])))
  # ord = hc$order
  # val.df <- val.df[,hc$labels]
  
  
  col.df <- data.frame(row.names = rownames(p.df),
                       phylum=spec.df$phylum[match(rownames(p.df), spec.df$abbv)]
  )
  
  
  # row.df <- data.frame(row.names = rownames(val.df),
                       # cat= c(
                       #   rep_len('small',length(15:18)),
                       #   rep_len('normal',length(19:24)),
                       #   rep_len('large',length(25:40))))
  # rep_len('too large',length(39:50))))
  # row.df$cat <- factor(row.df$cat, levels=c('small','normal','large','too large'))
  
  
  # colors = c(hcl.colors(100,'PuBuGn', rev=T)[10:100])
  
  
  if (save) svglite(file, 7.5, 4)
  
  par(mar=c(5,5,6,3))
  par(mfrow=c(1,1))
  lp <- layermap(val.df,
                 palette = 'PuBuGn',
                 # color_scale = colors,
                 zlim=c(0,0.15),
                 # row.df=row.df,
                 cluster_cols = T,
                 cluster_rows = F,
                 column.df=col.df)
                 # row_groups = 'cat',
                 # group_gap = 0)
  
  
  # left
  lp <- lp_names(lp, 2, cex=0.5)
  
  
  # bottom
  lp <- lp_names(lp, 1, cex=0.7)
  
  # top
  lp <- lp_annotate(lp, 3, 'phylum', type='points', col=phylum_colors, label = NA)
  lp <- lp_dend(lp, 3)
  
  # bottom
  lp <- lp_color_legend(lp, 1, size_p=0.4, round=2, gap=1.5)

  if (save) dev.off()
  if (save) ADsvg(file)
  
  return(p.df)
}
# p.df <- plot_wide_profile(F)

p.df <- plot_wide_profile(F, hard_filter = T)



### using this approach to look at knockouts

ko_plot <- function() {
  p.df <- profile.df
  
  p.df <- melt(p.df)
  names(p.df) <- c('bioproject','srr','abbv','rg','size','prop')
  
  projects_with_KO <- p.df$bioproject[grepl("\\.", p.df$rg)]
  
  p.df <- p.df[p.df$bioproject %in% projects_with_KO,]
  p.df <- p.df[p.df$abbv != 'Rhsol',]
  
  
  p.df <- aggregate(prop ~ bioproject + abbv + rg + size, p.df, mean)
  p.df$genotype <- 'wt'
  f = grepl("\\.", p.df$rg)
  p.df$genotype[f] <- str_sub(p.df$rg[f], 3, -1)
  
  # p.df <- aggregate(prop ~ bioproject + abbv + size, p.df, mean)
  # p.df <- aggregate(prop ~ abbv + size, p.df, mean)
  p.df <- dcast(p.df, abbv + bioproject + genotype ~ size, value.var = 'prop', fun.aggregate = mean)
  
  rownames(p.df) <- str_c(p.df$abbv, p.df$bioproject, p.df$genotype, sep='.')
  col.df <- p.df
  p.df$abbv <- NULL
  p.df$bioproject <- NULL
  p.df$genotype <- NULL
  
  
  
    
  
  
  val.df <- t(p.df)
  val.df[is.na(val.df)] <- 0
  colnames(val.df) <- rownames(p.df)
  
  
  
  
  par(mar=c(5,5,6,3))
  par(mfrow=c(1,1))
  lp <- layermap(val.df,
                 palette = 'PuBuGn',
                 # color_scale = colors,
                 column_groups = c('abbv', 'bioproject'),
                 zlim=c(0,0.10),
                 col.df =col.df,
                 # row.df=row.df,
                 cluster_cols = T,
                 cluster_rows = F)
  
  # row_groups = 'cat',
  # group_gap = 0)
  
  
  # left
  lp <- lp_names(lp, 2, cex=0.5)
  
  
  # bottom
  lp <- lp_names(lp, 1, cex=0.7, 'genotype')
  lp <- lp_group_names(lp, 1, "abbv", gap=1.2)
  
  # top
  lp <- lp_annotate(lp, 3, 'phylum', type='points', col=phylum_colors, label = NA)
  lp <- lp_dend(lp, 3)
  
  # bottom
  lp <- lp_color_legend(lp, 1, size_p=0.4, round=2, gap=1.5)
}
ko_plot()



# ko difference plot ------------------------------------------------------

ko_diff_plot <- function() {
  p.df <- profile.df
  
  p.df <- melt(p.df)
  names(p.df) <- c('bioproject','srr','abbv','rg','size','prop')
  
  projects_with_KO <- p.df$bioproject[grepl("\\.", p.df$rg)]
  
  p.df <- p.df[p.df$bioproject %in% projects_with_KO,]
  p.df <- p.df[p.df$abbv != 'Rhsol',]
  
  
  p.df <- aggregate(prop ~ bioproject + abbv + rg + size, p.df, mean)
  p.df$genotype <- 'wt'
  f = grepl("\\.", p.df$rg)
  p.df$genotype[f] <- str_sub(p.df$rg[f], 3, -1)
  
  # p.df <- aggregate(prop ~ bioproject + abbv + size, p.df, mean)
  # p.df <- aggregate(prop ~ abbv + size, p.df, mean)
  p.df <- dcast(p.df, abbv + bioproject + genotype ~ size, value.var = 'prop', fun.aggregate = mean)
  
  
  mt.df <- p.df[p.df$genotype != 'wt',]
  
  wt.df <- data.frame()
  for (i in 1:nrow(mt.df)) {
    
    wt_row = p.df[p.df$genotype == 'wt' & p.df$bioproject == mt.df$bioproject[i],]
    wt.df <- rbind(wt.df, wt_row)
  }
  
  dim(wt.df)
  dim(mt.df)
  
  f = as.character(15:50)
  val.df <- mt.df[,f] - wt.df[,f]
  
  
  
  rownames(val.df) <- str_c(mt.df$abbv, mt.df$bioproject, mt.df$genotype, sep='.')
  
  
  
  
  
  col.df <- mt.df
  rownames(col.df) <- str_c(mt.df$abbv, mt.df$bioproject, mt.df$genotype, sep='.')
  
  
  
  
  
  val.df[is.na(val.df)] <- 0
  val.df <- t(val.df)
  
  
  par(mar=c(5,5,6,3))
  par(mfrow=c(1,1))
  lp <- layermap(val.df,
                 palette = 'puor',
                 reverse_palette = T,
                 # color_scale = colors,
                 column_groups = c('abbv', 'bioproject'),
                 zlim=c(-0.10,0.10),
                 col.df =col.df,
                 # row.df=row.df,
                 cluster_cols = F,
                 cluster_rows = F)
  
  # row_groups = 'cat',
  # group_gap = 0)
  
  
  # left
  lp <- lp_names(lp, 2, cex=0.5)
  
  
  # bottom
  lp <- lp_names(lp, 1, cex=0.7, 'genotype')
  lp <- lp_group_names(lp, 1, "abbv", gap=1.2)
  
  # top
  lp <- lp_color_legend(lp, 3, titles='mut - wt')
  # lp <- lp_annotate(lp, 3, 'phylum', type='points', col=phylum_colors, label = NA)
  # lp <- lp_dend(lp, 3)
  
  # # bottom
  # lp <- lp_color_legend(lp, 1, size_p=0.4, round=2, gap=1.5)
}

ko_diff_plot()



ko_range_plot <- function(save=F) {
  
  p.df <- profile.df
  f.df <- peak.ls$peak_filter
  
  p.df <- p.df[p.df$abbv %in% rownames(f.df),]
  
  p.df <- melt(p.df)
  names(p.df) <- c('bioproject','srr','abbv','rg','size','prop')
  
  projects_with_KO <- p.df$bioproject[grepl("\\.", p.df$rg)]
  
  p.df <- p.df[p.df$bioproject %in% projects_with_KO,]
  p.df <- p.df[p.df$abbv != 'Rhsol',]
  
  
  p.df <- aggregate(prop ~ bioproject + abbv + rg + size, p.df, mean)
  p.df$genotype <- 'wt'
  f = grepl("\\.", p.df$rg)
  p.df$genotype[f] <- str_sub(p.df$rg[f], 3, -1)
  
  # p.df <- aggregate(prop ~ bioproject + abbv + size, p.df, mean)
  # p.df <- aggregate(prop ~ abbv + size, p.df, mean)
  p.df <- dcast(p.df, abbv + bioproject + genotype ~ size, value.var = 'prop', fun.aggregate = mean)
  
  
  mt.df <- p.df[p.df$genotype != 'wt',]
  wt.df <- p.df[p.df$genotype == 'wt',]
  
  
  x_range = 18:28
  
  
  file_name = '01-B-props_in_KO.svg'
  if (save) svglite(file_name, 3.73, 6.11)
  
  par(mfrow=c(7, 2))
  par(mar=c(2,4,0,2))
  for (project in wt.df$bioproject) {
    abbv = wt.df$abbv[wt.df$bioproject == project]
    peak_sizes =  as.numeric(names(f.df)[which(f.df[abbv,] >= 0.5)])
    
    w.df <- wt.df[wt.df$bioproject == project,]
    m.df <- mt.df[mt.df$bioproject == project,]
    
    columns = as.character(x_range)
    vals = unlist(w.df[,columns])
    vals[is.nan(vals)] <- 0
    ymax = max(vals) * 1.6
    
    
    for (row_i in 1:nrow(m.df)) {
      plot(1,1,type='n', xlim=c(min(x_range), max(x_range)), ylim=c(0,1), axes=F, ylab='Prop. aligned', xlab='')
      
      text(min(x_range), ymax, paste(abbv, project, m.df$genotype[row_i]), adj=c(0,1), cex=0.7)
      
      axis(1, las=1, mgp=c(2,0.5,0))
      axis(2, las=1)
      
      
      pr  = min(peak_sizes):max(peak_sizes)
      prc = as.character(pr)
      
      wt_row = unlist(w.df[1,as.character(15:50)])
      mt_row = unlist(m.df[row_i,as.character(15:50)])
      
      wt_row[is.nan(wt_row)] <- 0
      mt_row[is.nan(mt_row)] <- 0
      
      wt_row = wt_row / max(wt_row)
      mt_row = mt_row / max(mt_row)
      
      wt_row = wt_row[columns]
      mt_row = mt_row[columns]
      
      
      
      polygon(c(pr, rev(pr)), c(wt_row[prc], mt_row[rev(prc)]), border=F, col='lightblue')
      
      lines(x_range, wt_row[columns], lty=3, lwd=1.5)
      
      lines(x_range, mt_row[columns], lwd=2)
    }
  }
  
  if (save) dev.off()
  if (save) ADsvg(file_name)
}

ko_range_plot(save=F)


## line plots --------------------------------------------------------------


make_line_profiles <- function(save=F) {
  
  p.df <- profile.df
  
  p.df <- melt(p.df)
  names(p.df) <- c('bioproject','srr','abbv','rg','size','prop')
  
  
  agg_proportions <- function(p.df) {
    p.df <- aggregate(prop ~ bioproject + abbv + rg + size, p.df, mean)
    p.df <- aggregate(prop ~ bioproject + abbv + size, p.df, mean)
    p.df <- aggregate(prop ~ abbv + size, p.df, mean)
    p.df <- dcast(p.df, abbv ~ size, value.var = 'prop')
    
    rownames(p.df) <- p.df$abbv
    p.df$abbv <- NULL
    
    p.df <- p.df[rownames(peak_filter), colnames(peak_filter)]
    
    return(p.df)
  }
  
  soft_filter.df  <- agg_proportions(p.df[!grepl("d", p.df$rg),])
  hard_filter.df <- soft_filter.df * peak_filter
  ko.df <- agg_proportions(p.df[ grepl("d", p.df$rg),])
  
  hard_filter.df[is.na(hard_filter.df)] <- 0
  
  
  dim(soft_filter.df)
  dim(hard_filter.df)
  dim(ko.df)
  
  hc = hclust(dist(hard_filter.df))
  
  
  par(mfrow=c(11,5), mar=c(1,1,1,1))
  for (abbv in rownames(soft_filter.df)[hc$order]) {
    
    x = as.numeric(names(ko.df))
    
    plot(1, 1, type='n', ylim=c(0,0.25), xlim=c(15,35),
         ylab='Proportion', xlab='Size', main=abbv, axes=F)
    par(lwd=2)
    par(xpd=T)
    lines(x, soft_filter.df[abbv,], 
          col='cadetblue')
    lines(x, hard_filter.df[abbv,], 
          col='firebrick') 
    points(x, hard_filter.df[abbv,], 
                                 col='firebrick', pch=19)
    y = hard_filter.df[abbv,]
    w = which(y == max(y, na.rm=T))
    text(x[w], y[w], x[w], pos=3, cex=0.7, font=2)
    
    
    lines(x, ko.df[abbv,], 
          col='grey30', lwd=3)
    
    rg = unique(p.df$rg[p.df$abbv == abbv & grepl('d',p.df$rg)])
    if (length(rg) > 0) text(34, 0.25, paste(rg, collapse="\n"), cex=0.8, adj=c(0.5,1))
    # if (length(rg) > 0) stop()  
    par(lwd=1)
    par(xpd=F)
  }
}

make_line_profiles()


# profile clust -----------------------------------------------------------

library(hclust1d)


p.df <- profile.df[profile.df$abbv == 'Bocin', as.character(15:50)]

x = p.df[9,]
f = !is.na(x)
n = names(p.df)[f]
x = x[f]

d <- hclust1d(x)
d$labels <- n

par(mfrow=c(2,1))
plot(d)

plot(n, x, type='l')

cutree(d,3)





# Highly skewed profiles --------------------------------------------------

profile.df <- get_profile.df()


p.df <- profile.df

p.df$left_most <- apply(p.df[,c(15,16,17)], 1, sum, na.rm=T)
p.df$filtered <- p.df$left_most > 0.3

highly_skewed <- unique(str_c(p.df$abbv, p.df$bioproject, p.df$rg, sep='.')[p.df$filtered])








# just zmed scaling -------------------------------------------------------

scale.df <- get_peak_scales(filter=T)
filter.df <- filter_projects()

plot_zmed_scaled <- function(save=F) {

  
  
  s.df <- scale.df
  s.df <- s.df[s.df$project %in% filter.df$project[filter.df$f_pass],]
  s.df <- dcast(s.df, project ~ size, value.var = 'zmed')
  
  rownames(s.df) <- s.df$project
  s.df$project <- NULL
  
  hc <- hclust(dist(s.df))
  cu <- cutree(hc,4)
  col.df <- data.frame(row.names = rownames(s.df),
                       project=rownames(s.df))
  col.df$cluster <- cu[rownames(col.df)]
  col.df$abbv <- str_sub(col.df$project, 1, 5)
  col.df$phylum <- species.df$phylum[match(col.df$abbv, species.df$abbv)]
  col.df$host <- species.df$Pathogen[match(col.df$abbv, species.df$abbv)]
  
  
  file_name = "01-zmed_scaled.svg"
  if (save) svglite(file_name, 8.2, 5.84)
  
  par(mar=c(10,2,10,2))
  lp <- layermap(t(s.df), 
                 palette='blues',
                 reverse_palette = T,
                 col.df = col.df,
                 # column_groups = 'cluster',
                 cluster_cols = T,
                 cluster_rows = F,
                 zlim=c(0,3))
  
  # left
  lp <- lp_names(lp, 2, cex=0.5)
  
  # top
  lp <- lp_names(lp, 3, cex=0.5)
  
  # bottom
  # lp <- lp_annotate(lp, 1, 'phylum', col=phylum_colors, type='p')
  lp <- lp_annotate(lp, 1, 'host', col=host_colors, type='p', plot_label = F)
  lp <- lp_dend(lp, 1)
  
  lp <- lp_legend(lp, 1, 'host')
  
  # y = unique(lp$plotting.df$y[lp$plotting.df$rows %in% c('20','25','27','30')])
  # x1 = min(lp$plotting.df$x)
  # x2 = max(lp$plotting.df$x)+1
  # rect(x1, y[1], x2, y[2], border='red', lwd=1.5)
  # rect(x1, y[3], x2, y[4], border='red', lwd=1.5)
  
  # 
  # f = scale.df$peak != 'None'
  # 
  # lp$plotting.df$point <- ifelse(paste(lp$plotting.df$rows, lp$plotting.df$cols) %in% paste(scale.df$size[f], scale.df$project[f]),
  #                                T,
  #                                F)
  # f = lp$plotting.df$point
  # points(lp$plotting.df$x[f]+0.5, lp$plotting.df$y[f]+0.5, pch=19, cex=0.3, col='white')
  
  if (save) dev.off()
  if (save) ADsvg(file_name)
  
}

plot_zmed_scaled(F)







# phylo  ------------------------------------------------------------------

library(ape)
peak.df <- get_peak.df()

d <- dend

d$abbv <- species.df$abbv[match(d$tip.label, species.df$tree_name)]
f= which(is.na(d$abbv))
d=drop.tip(d, f)

d$abbv <- species.df$abbv[match(d$tip.label, species.df$tree_name)]
f= which(is.na(d$abbv))

d$tip.label <- d$abbv


par(mar=c(1,1,1,1))
plot(d, type='unrooted', show.tip.label = T)


k.df <- peak.df
k.df <- k.df[!duplicated(k.df$project),]
k.df <- k.df[k.df$center > 18,]
k.df$abbv <- str_sub(k.df$project, 1, 5)

d$peak_center <- k.df$center[match(d$abbv, k.df$abbv)]


size_colors = c(setNames(rep(hcl.colors(8)[1],5), 15:19),
                setNames(hcl.colors(8), 20:27),
                setNames(rep(hcl.colors(8)[8],13), 28:40))


# f = which(!is.na(d$abbv))
# nodelabels(node=which(!is.na(d$abbv)), pch=19, col='magenta')
# tiplabels(d$peak_center[f], f)

nodelabels(node=1:length(d$tip.label), pch=19, col=size_colors[d$peak_center], cex=2)
# tiplabels()

legend('topleft', names(size_colors), pch=19, col=size_colors)