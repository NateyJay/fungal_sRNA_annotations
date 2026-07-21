



s.df <- species.df
names(s.df)
s.df <- s.df[,c('abbv','nmemonic','species','accession', 'genome_length', 'contig_n')]
s.df


s.df$TE_n <- NA
s.df$TE_length <- NA

for (file in Sys.glob("../TE_annotations/annotations/*anno.gff3")) {
  accession = str_split(file, "/")[[1]][4]
  accession = str_split(accession, "_")[[1]][1:2]
  accession = paste(accession, collapse="_")
  print(accession)
  
  gr <- readGFFAsGRanges(file)
  
  f = s.df$accession == accession
  
  if (!any(f)) message("^^^ NO ACCESSION MATCH")
  
  s.df$TE_n[f] <- length(gr)
  s.df$TE_length[f]      <- sum(width(gr))  
  
  gr <- gr[!gr$tsd %in% c('rRNA_gene', 'repeat_fragment', 'repeat_region'),]
  
  s.df$TE_n[f] <- length(gr)
  s.df$TE_length[f]      <- sum(width(gr))  
  
  table(gr$type)
  
}


s.df$perc_TE <- round(s.df$TE_length / s.df$genome_length * 100,1)
s.df

