



merged.df <- read.delim("../mRNA_alignment/01out-merged.txt")



### Looking at total alignment rates
m.df <- merged.df

head(m.df)

m.df <- aggregate(. ~ project, m.df, sum)
m.df$size <- NULL

rownames(m.df) <- m.df$project
m.df$project <- NULL

m.df$aligned_only <- 0
f = m.df$gene_aligned + m.df$gene_aligned_stranded == 0
m.df$aligned_only[f] <- m.df$aligned[f]
m.df$aligned[f] <- 0

m.df <- m.df[,c('unaligned',"aligned", 'aligned_only',"gene_aligned","gene_aligned_stranded")]


mp.df = m.df / rowSums(m.df)

t.df  <- m.df[,c("aligned", 'aligned_only',"gene_aligned","gene_aligned_stranded")]
tp.df <- t.df / rowSums(t.df)


plot_it <- function(o) {

  colors = c('grey30','lightgreen', 'cadetblue3','goldenrod','maroon')
  names  = rep('', nrow(m.df))
  
  layout(matrix(1:4, ncol=1), heights = c(1.5,1,1,2))
  par(mar=c(0,5,4,2))
  par(las=2)
  barplot(t(m.df[o,]), col=colors, names.arg=names, space=0, ylab='Total reads')
  
  par(xpd=T)
  legend('topleft', legend=rev(names(m.df)), fill=rev(colors), cex=0.7, title='Alignment type', inset=c(0.04,-0.08))
  par(xpd=F)
  
  par(mar=c(0,5,1,2))
  barplot(t(mp.df[o,]), col=colors, names.arg=names, space=0, ylab='Prop. of all')
  
  par(mar=c(0,5,1,2))
  par(xpd=T)
  barplot(t(tp.df[o,]), cex.names=0.7, col=colors[2:5], space=0, ylab='Prop. of aligned')
  par(xpd=F)
  
  

}

svglite("04-A-alignment_rates.svg", 12.67, 5.88)
plot_it(order(mp.df$aligned)) ### <- i like this one
dev.off()
ADsvg("04-A-alignment_rates.svg")

## This figure would be enhanced if I could also include info on whether it is the fungi alone, or a mixed sample.


plot_it(order(m.df$aligned))
plot_it(order(rowSums(m.df)))
plot_it(hclust(dist(m.df))$order)




# Profiles based on alignment type ----------------------------------------




merged.df <- read.delim("../mRNA_alignment/01out-merged.txt")


m.df <- merged.df


g.df <- aggregate(. ~ project, m.df, sum)
g.df$size <- NULL

# par(mfrow=c(1,1), xpd=F)
# plot(ecdf(g.df$aligned + g.df$gene_aligned + g.df$gene_aligned_stranded), do.points=F, verticals=T, xlim=c(0,10000000))
# abline(v=1000000)

# m.df <- m.df[m.df$project %in% g.df$project[g.df$aligned + g.df$gene_aligned + g.df$gene_aligned_stranded > 10000000],]
# length(unique(m.df$project))

# p.df <- peak.df
# p.df$project <- str_c(p.df$abbv, p.df$bioproject, sep='.')
# length(unique(p.df$project))
# 
# m.df <- m.df[m.df$project %in% unique(p.df$project),]
# length(unique(m.df$project))


par(mfrow=c(1,1))
par(mar=c(5,3,4,4))
par(xpd=F)

if (exists('big.df')) rm('big.df')
short = c(aligned='a',gene_aligned='ga',gene_aligned_stranded='gas')

for (type in c("aligned","gene_aligned","gene_aligned_stranded")) {
  
  pr  = 15:35
  prc = as.character(pr)
  
  a.df <- m.df[,c('project','size', type)]
  names(a.df)[3] <- 'abd'
  
  a.df <- dcast(a.df, project ~ size)
  rownames(a.df) <- a.df$project
  a.df$project <- NULL
  
  a.df <- a.df / rowSums(a.df)
  
  
  # plot(1,1,xlim=c(min(pr), max(pr)), ylim=c(0,0.3), main=type, las=2)
  # 
  # for (i in 1:nrow(a.df)) {
  #   row = a.df[i,prc]
  #   lines(pr, row, col=scales::alpha('black', 0.2))
  # }
  
  a.df <- as.matrix(a.df)
  a.df[is.nan(a.df)] <- 0
  
  a.df <- a.df[,prc]
  
  colnames(a.df) <- str_c(colnames(a.df), short[type], sep="_")
  a.df <- as.data.frame(a.df)
  
  if (!exists('big.df')) { big.df <- a.df
  } else {big.df <- cbind(big.df, a.df)}

  # lp = layermap(a.df,
  #               palette='reds',
  #               zlim=c(0,0.5))
  # 
  # lp = lp_names(lp, 3)

}


col.df = as.data.frame(row.names =names(big.df),
                       str_split_fixed(names(big.df), '_',2))
names(col.df) <- c('size','type')
col.df$full_type[col.df$type == 'a'] <- 'aligned'
col.df$full_type[col.df$type == 'ga'] <- 'gene_aligned'
col.df$full_type[col.df$type == 'gas'] <- 'gene_aligned_stranded'

lp = layermap(big.df,
              palette='greens',
              zlim=c(0,0.4),
              col.df =col.df,
              column_groups = 'full_type'
              )

lp = lp_names(lp, 3, 'size', cex=0.6)
lp = lp_group_names(lp, 3, 'full_type', srt=0, gap=1)

lp = lp_dend(lp, 4)

# lp = lp_names(lp, 2, cex=0.6)

lp = lp_color_legend(lp, 1, titles='Proportion')





        