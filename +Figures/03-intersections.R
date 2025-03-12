








peak.df <- get_peak.df()
ann.ls <- get_ann.ls()


ann.ls$Agbis.PRJNA770841.A

for (n in names(ann.ls)) {
  a.df = ann.ls[[n]]
  
  abbv = str_sub(n, 1, 5)
  
  gff = str_c(spec.df$genome[spec.df$abbv == abbv], ".gff", sep='')
  
  if (!is.na(gff)) {
    
    gff.df <- read.gff(file.path("../+genomes/", gff))
    gff.df <- gff.df[gff.df$type == 'mRNA',]
    gff.df$tss <- ifelse(gff.df$strand == "+", gff.df$start, gff.df$end)
    
    
    
    gff.gr = GRanges(seqnames=gff.df$seqid,
                     ranges=IRanges(gff.df$start, gff.df$end),
                     strand=gff.df$strand)
    gff.gr$tss <- ifelse(gff.gr$strand )
    
  }
  
  
  
}



# yasma context -----------------------------------------------------------


context.df <- data.frame()
for (project in annotation.df$project) {
  
  for (rg in annotation.df$rg[annotation.df$project == project]) {
    
    
    message(project, rg)
    
    file=file.path("../+annotations", project, paste('tradeoff',rg,sep="_"), "context.txt")
    
    if (!file.exists(file)) next
    
    c.df <- read.delim(file)
    c.df$project = project
    c.df$rg      = rg
      
    
    a.df <- ann.ls[[paste(project, rg, sep='.')]]
    
    c.df$size <- a.df$size_1n[match(c.df$cluster, a.df$Name)]
    c.df$size[c.df$cluster %in% a.df$Name[a.df$sizecall == 'N']] <- "N"
    
    context.df <- rbind(context.df, c.df)
    # table(c.df$category, c.df$size)
  }

  
}









