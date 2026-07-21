


## looking at locus fingerprints across all sizes...

par(mfrow=c(8,8))
par(mar=c(3,3,0.2,0.2))

for (abbv in c("Bocin", 'Cocin','Scscl','Fugra','Necra','Asapi')) {
  m.df <- metalocus.df[metalocus.df$abbv == abbv,]
  m.df$length <- m.df$end - m.df$start
  
  max_rep = max(m.df$member_annotations)
  m.df <- m.df[str_detect(m.df$replication,'binom\\+project'),]
  
  m.df$sizecall_single[!m.df$sizecall_single %in% as.character(19:25)] <- "N"
  for (size in c(as.character(19:25), 'N')) {
    xlim=c(80, 100000)
    ylim=c(1, 1E6)
    f = m.df$sizecall_single == size
    
    plot(m.df$length[f], m.df$rpm[f], log='xy', cex = (m.df$member_annotations[f] / max_rep)*3,
         main=paste0(size, "-", abbv), 
         xlim=xlim, ylim=ylim, col=scales::alpha(ifelse(m.df$bin_pass[f], 'black','orange'), (m.df$member_annotations[f] / max_rep)))
    
    # f = m.df$sizing != 'typical'
    # plot(m.df$length[f], m.df$rpm[f], log='xy', cex = (m.df$member_annotations[f] / max_rep)*5,
    #      main='other', xlim=xlim, ylim=ylim, col=scales::alpha(ifelse(m.df$bin_pass[f], 'black','blue'), (m.df$member_annotations[f] / max_rep)))
  }
  
}







# what do bocin tRNAs look like?

m.df <- metalocus.df[metalocus.df$abbv == 'Bocin',]
m.df <- m.df[m.df$context == 'Rfam/tRNA',]
m.df <- m.df[m.df$bin_pass,]
m.df
table(m.df$sizecall_single)

boxplot(m.df$rpm ~ m.df$sizecall_single)




### what do all tRNA and rRNA annotations look like in terms of sRNA sizes.
get_rfam_depth.df <- function(force=F) {
  
  dir.create('00-rfam_depths')
  size.df <- data.frame()
  for (project in project.df$project[project.df$f_pass]) {
    
  # for (project in c('Asapi.PRJNA560456')) {
    message(project)
    
    annotations = str_split(project.df$conditions[project.df$project == project], ",")[[1]]
    # annotations = 'A'
    pas <- paste0(project, ".", annotations)
    abbv = str_sub(project, 1, 5)
    
    if (abbv %in% c("Blhor")) {
      message("  skipping problematic species")
      next
    }
    
    dirs <- get_dir_paths()
    
    message("  checking bamfile...")
    
    bamfile = paste0(dirs$ann, project, "/align/alignment.bam")
    if (!file.exists(bamfile)) {print(paste(bamfile, 'not found')); next}
    
    header =scanBamHeader(bamfile)
    seqids = names(header[[1]]$targets)
    
    
    message("  reading rfam gff...")
    rfam_gff = str_glue("../rfam/02out-rfam_gffs/{abbv}.rfam.gff3")
    
    if (!file.exists(rfam_gff)) { paste("rfam_gff not found:", rfam_gff); next }
  
    rfam.gr <- import.gff(rfam_gff)
    
    if (!abbv %in% lookup.df$abbv) {
      # next
      message("warning: abbv not found in chr lookup table...")
    }
    
    ## fixing problems with genbank/refseq chromosome names
    
    
    rfam.gr <- fix_seqlevels(rfam.gr, seqids)
    if (is.null(rfam.gr)) next
  
    # rfam.gr <- rfam.gr[rfam.gr$ID %in% c("RF00005", "RF00001"),]
    rfam.gr <- rfam.gr[order(as.numeric(str_remove(rfam.gr$ID, "RF"))),]
    
    rfam.gr <- resize(rfam.gr, fix='center', width=width(rfam.gr)+50)
    gr <- reduce(rfam.gr)
    m = match(paste(seqnames(gr), start(gr)), paste(seqnames(rfam.gr), start(rfam.gr)))
    mcols(gr) <- mcols(rfam.gr)[m,]
    rfam.gr <- resize(gr, fix='center', width=width(gr)-50)


    # # ov <- findOverlaps(rfam.gr, resize(rfam.gr, fix='center', width=width(rfam.gr)+30))
    # ov <- findOverlaps(rfam.gr, rfam.gr)
    # ov <- as.data.frame(ov)
    # ov <- ov[ov$queryHits != ov$subjectHits,]
    # ov
    # ov <- ov[ov$subjectHits > ov$queryHits,]
    # # ov <- ov[!duplicated(ov$queryHits),]
    # to_remove <- sort(unique(ov$subjectHits))
    # 
    # if (length(to_remove) != 0) rfam.gr <- rfam.gr[-to_remove,]

    
    
    for (pa in pas) {
      message(paste0("  ", pa))
      
      libraries = library.df$srr[paste(library.df$abbv, library.df$bioproject, library.df$rg, sep='.') == pa]
      
      if (length(libraries) == 0) next
      
      file_name = paste0("00-rfam_depths/", pa, ".rfam.txt")
      
      if (file.exists(file_name) & !force) {
        
        if (file.info(file_name)$size <= 1) next
        s.df <- read.delim(file_name)
        
        names(s.df) <- str_replace(names(s.df), "^X", "")
        if (nrow(s.df) > 0) {
          message("    -> found")
          size.df <- rbind(size.df, s.df)
          next
        }
      }
      message("    counting reads...")
      
      pb = txtProgressBar(0,length(rfam.gr), style=3, width=30)
      
      s.df <- data.frame()
      for (i in 1:length(rfam.gr)) {
        # cat('.')
        setTxtProgressBar(pb, i)
        
        gr = rfam.gr[i,]
        strand = as.vector(strand(gr))
        
        param = ScanBamParam(which=gr, 
                             what=c('qwidth', 'strand'),
                             flag=scanBamFlag('isMinusStrand'= strand == '-'),
                             tagFilter= list(RG=libraries[1]))
        # isMinusStrand=strand == '-')
        b = scanBam(bamfile, param=param)[[1]]
        
        tab = table(b$qwidth)
        if (length(tab) == 0) next
        
        tab = as.data.frame(tab)
        names(tab) = c('size','freq')
        tab$type = gr$ID
        tab$locus = paste0(seqnames(gr), ":", start(gr), "-", end(gr))
        tab$strand = strand
        
        s.df <- rbind(s.df, tab)
      }
      close(pb)
      
      if (nrow(s.df) == 0) {write.table(s.df, file_name, row.names = F, col.names = T, sep='\t', quote=F); next} 
      s.df <- dcast(s.df, type + locus + strand ~ size, value.var='freq', fun.aggregate = sum)
      
      sizes = 15:35
      for (s in as.character(sizes)) {
        if (!s %in% names(s.df)) s.df[[s]] = 0
      }
      
      s.df$pa <- pa
      
      s.df <- s.df[, c('pa','type', 'locus', 'strand', as.character(sizes))]
      
      # sum(unlist(s.df[,as.character(sizes)]))
      
      write.table(s.df, file_name, row.names = F, col.names = T, sep='\t', quote=F)
      
      size.df <- rbind(size.df, s.df)

    }
  }
  
  return(size.df)
}


rfam_depth.df <- get_rfam_depth.df(F)



rfam_depth.df <- size.df
table(rfam_depth.df$pa)


plot_rfam_heatmap <- function(pa, save=F) {
  
  message(pa)
  
  dir.create('F01-rfam_heatmaps')
  
  s.df <- rfam_depth.df[rfam_depth.df$pa == pa,]
  s.df <- s.df[!duplicated(s.df$locus),]
  
  if (nrow(s.df) == 0) return()
  
  file_name=str_glue("F01-rfam_heatmaps/{pa}.rfamheat.svg")
  if (save) svglite(file_name, 5.3, 8.7)
  
  par(mar=c(4,5,4,2))
  
  rownames(s.df) <- s.df$locus
  row.df <- s.df[,1:3]
  row.df$type[!row.df$type %in% c("RF00001", "RF00005")] <- "Other\nRFam"
  row.df$type <- factor(row.df$type, levels=c("RF00001", "RF00005", "Other\nRFam"))
  row.df$count <- table(row.df$type)[row.df$type]
  
  
  s.df$pa <- NULL
  s.df$type <- NULL
  s.df$locus <- NULL
  s.df$strand <- NULL
  
  f = rowSums(s.df) > 0
  s.df <- s.df[f,]
  row.df <- row.df[f,]
  
  s.df <- t(scale(t(s.df)))
  
  sizes = as.character( 15:35)
  lp <- layermap(s.df, #zlim=c(0,1000),
                 zlim=c(-1.5,4.0),
                 row.df = row.df,
                 row_groups = c('type', 'count'),
                 palette = 'mako', reverse_palette = F)
  lp <- lp_names(lp, 3)
  lp <- lp_group_names(lp, 4, 'count')
  lp <- lp_group_names(lp, 2, 'type')
  
  lp <- lp_color_legend(lp, 1, titles='Z-score', size_p=0.2)
  
  mtext(pa, side=3, line=2.3, at=0, adj=0, font=2)
  mtext("RNA Length", side=3, line=1.2, cex=0.8)
  
  if (save) dev.off()
  if (save) ADsvg(file_name)
}


for (pa in unique(rfam_depth.df$pa)) {
  
  if (str_sub(pa, 1, 5) != 'Cocin') next

  plot_rfam_heatmap(pa=pa, save=F)
    
}



r.df <- rfam_depth.df
r.df$type <- NULL
r.df$locus <- NULL
r.df$strand <- NULL

head(r.df)
tail(r.df)

r.df <- melt(r.df)
r.df <- dcast(r.df, pa ~ 'depth', value.var = 'value', fun.aggregate = sum)
r.df$rpm <- r.df$depth / 1000000

l.df <- library.df
l.df$pa <- paste(l.df$abbv, l.df$bioproject, l.df$rg, sep='.')

l.df <- cbind(dcast(l.df, pa ~ 'total_aligned', value.var='total_aligned', fun.aggregate = sum, na.rm=T),
              dcast(l.df, pa ~ 'total_reads', value.var='total_reads', fun.aggregate = sum, na.rm=T))
l.df[,3] <- NULL

r.df$total_aligned <- l.df$total_aligned[match(r.df$pa, l.df$pa)]
r.df$total_reads <- l.df$total_reads[match(r.df$pa, l.df$pa)]

r.df$prfam <- r.df$depth / r.df$total_aligned
r.df <- r.df[r.df$total_aligned != 0,]
r.df$aln_rate <- r.df$total_aligned / r.df$total_reads
r.df

r.df$abbv <- str_sub(r.df$pa, 1,5)
r.df$project <- str_split_fixed(r.df$pa, "\\.", 3)[,2]




boxplot(r.df$prfam ~ r.df$abbv, horizontal=T, las=1, ylim=c(0,1))
beeswarm(r.df$prfam ~ r.df$abbv, horizontal=T, add=T, pch=19, cex=0.6, col='firebrick2')

d.df <- dcast(r.df, abbv + project ~ 'prfam', value.var = 'prfam', fun.aggregate = median)

tab = table(d.df$abbv)
d.df <- d.df[d.df$abbv %in% names(tab)[tab >= 3],]

boxplot(d.df$prfam ~ d.df$abbv, horizontal=T, las=1, ylim=c(0,1))
beeswarm(d.df$prfam ~ d.df$abbv, horizontal=T, add=T, pch=19, col='blue')


plot(r.df$total_aligned, r.df$prfam, xlim=c(0,100000000), ylim=c(0,1))


plot(r.df$aln_rate, r.df$prfam, xlim=c(0,1), ylim=c(0,1))


get_depths <- function(molecule = c('rfam','te', 'ncbi'), force=F) {
  
  molecule <- match.arg(molecule)
  message(paste0("molecule: ", molecule))
    
    
  dir.create(str_glue('00-feature_depths'))
  
  size.ls <- list()
  count.ls <- list()
  for (project in project.df$project[project.df$f_pass]) {
    
    # for (project in c('Asapi.PRJNA560456')) {
    message(project)
    
    annotations = str_split(project.df$conditions[project.df$project == project], ",")[[1]]
    # annotations = 'A'
    pas <- paste0(project, ".", annotations)
    abbv = str_sub(project, 1, 5)
    
    if (abbv %in% c("Blhor")) {
      message("  skipping problematic species")
      next
    }
    
    dirs <- get_dir_paths()
    
    message("  checking bamfile...")
    
    bamfile = paste0(dirs$ann, project, "/align/alignment.bam")
    if (!file.exists(bamfile)) {print(paste(bamfile, 'not found')); next}
    
    header =scanBamHeader(bamfile)
    seqids = names(header[[1]]$targets)
    
    
    message(str_glue("  reading {molecule} gff..."))
    
    if (molecule == 'rfam') {
      gff = str_glue("../rfam/02out-rfam_gffs/{abbv}.rfam.gff3")
      feature.type = NULL
      
    } else if (molecule == 'te') {
      gff = (paste0("../TE_annotations/eg_out/",abbv,"_EarlGrey/",abbv,"_summaryFiles/",abbv,".filteredRepeats.gff"))
      feature.type = NULL
      
    } else if (molecule == 'ncbi') {
      s.df = species.df[species.df$abbv == abbv,]
      gff = str_glue("{dirs$gen}{abbv}.{s.df$accession}_{s.df$assembly_name}_genomic.gff3")
      feature.type = c('gene','mRNA','exon')
      
    }
    
    if (!file.exists(gff)) { paste("gff not found:", gff); next }
    
    
    gr <- import.gff(gff, feature.type=feature.type)
    
    
    if (!abbv %in% lookup.df$abbv) {
      # next
      message("warning: abbv not found in chr lookup table...")
    }
    
    ## fixing problems with genbank/refseq chromosome names
    
    
    gr <- fix_seqlevels(gr, seqids)
    if (is.null(gr)) next
    
    if (molecule == 'rfam') {
      # rfam.gr <- rfam.gr[rfam.gr$ID %in% c("RF00005", "RF00001"),]
      gr <- gr[order(as.numeric(str_remove(gr$ID, "RF"))),]
      
    } else if (molecule == 'te') {
      gr <- gr[gr$type != 'Simple_repeat',]
      gr <- gr[gr$type != 'Unknown']
      gr$ID <- gr$type
      
    } else if (molecule == 'ncbi') {
      e.gr <- gr[gr$type == 'exon',]
      gr <- gr[gr$type == 'mRNA',]
      gr <- gr[!duplicated(unlist(gr$Parent)),]  
    }
    
    if (molecule == 'rfam') {
      ## merging any end-to-end rfam annotations (to prevent double counting)
      
      gr <- resize(gr, fix='center', width=width(gr)+50)
      temp <- reduce(gr)
      m = match(paste(seqnames(temp), start(temp)), paste(seqnames(gr), start(gr)))
      mcols(temp) <- mcols(gr)[m,]
      gr <- resize(temp, fix='center', width=width(temp)-50)
    }
    
    
    for (pa in pas) {
      message(paste0("  ", pa))
      
      count.ls[[pa]] = list()
      
      libraries = library.df$srr[paste(library.df$abbv, library.df$bioproject, library.df$rg, sep='.') == pa]
      
      if (length(libraries) == 0) next
      
      count_file = paste0("00-feature_depths/", pa, ".", molecule, ".count.json")
      size_file  = paste0("00-feature_depths/", pa, ".", molecule, ".size.json")
      
      do_analyze = F
      if (molecule == 'ncbi' & 
          (!file.exists(count_file) | force | file.info(count_file)$size < 10)) {
        do_analyze = T
        
      } else {
        count.ls[[pa]] <- read_json(count_file) 
        
      }
      
      if (!file.exists(size_file) | force | file.info(size_file)$size < 10) {
        do_analyze = T
        
      } else {
        size.ls[[pa]] <- read_json(size_file) 
        
      }
      
      if (!do_analyze) next
      
      message("    counting reads...")
      
      pb = txtProgressBar(0,length(gr), style=3, width=30)
      
      for (i in 1:length(gr)) {
      # for (i in 1:300) {
        # cat('.')
        setTxtProgressBar(pb, i)
        
        gri = gr[i,]
        gre = e.gr[unlist(e.gr$Parent) == gri$ID,]
        # strand = as.vector(strand(gri))
        
        exon_positions = unlist(apply(data.frame(ranges(gre)), 1, function(x) x[1]:x[2]))
        exon_positions = sort(exon_positions, decreasing = as.vector(strand(gri)) == "-")
        
        if (molecule=='ncbi') {
          param = ScanBamParam(which=gri, 
                               what=c('qwidth','strand', 'pos'),
                               tagFilter= list(RG=libraries[1]))
          b = scanBam(bamfile, param=param)[[1]]
          b$strand <- droplevels(b$strand)
          b$cpos = b$pos + round(b$qwidth/2)
          b$exon = as.numeric(b$cpos %in% exon_positions)
          if (length(b$pos) == 0) next
          
          tab = table(size=b$qwidth, strand=b$strand, exon=b$exon)
          tab <- as.data.frame(tab)
          tab$size <- as.numeric(as.vector(tab$size))
          tab$exon <- as.numeric(as.vector(tab$exon))
          # tab$pa = pa
          # tab$locus = gri$ID
          
          
          size.ls[[pa]][[gri$ID]] = as.list(tab)
          
          ctab = table(pos=b$cpos, strand=b$strand, exon=b$exon)
          ctab = as.data.frame(ctab)
          ctab$pos <- as.numeric(as.vector(ctab$pos))
          ctab$exon <- as.numeric(as.vector(ctab$exon))
          ctab = ctab[ctab$Freq > 0,]
          ctab <- ctab[order(ctab$pos),]
          ctab$fpos = match(ctab$pos, exon_positions)
          ctab$rpos = sum(width(gre)) - ctab$fpos
          
          count.ls[[pa]][[gri$ID]] = as.list(ctab)

          
        } else {
          ## only taking strand and length for tes and rfam
          param = ScanBamParam(which=gri, 
                               what=c('qwidth','strand'),
                               tagFilter= list(RG=libraries[1]))
          b = scanBam(bamfile, param=param)[[1]]
          b$strand <- droplevels(b$strand)
          
          tab = table(size=b$qwidth, strand=b$strand)
          # tab <- tab[,c('size','strand')]
          if (length(tab) == 0) next
          
          tab = as.data.frame(tab)
          names(tab) = c('size','strand','freq')
          name = paste0(gri$ID, "_", seqnames(gri), ":", start(gri), "-", end(gri))
          # tab$strand = strand
          
          size.ls[[pa]][[name]] <- as.list(tab)
          
          s.df <- rbind(s.df, tab)
          
        }
        
      }
      close(pb)
      
      write_json(count.ls[[pa]], count_file, pretty=T)
      write_json(size.ls[[pa]],  size_file, pretty=T)


      # if (nrow(s.df) == 0) {write.table(s.df, file_name, row.names = F, col.names = T, sep='\t', quote=F); next} 
      # 
      # s.df <- dcast(s.df, type + locus + strand ~ size, value.var='freq', fun.aggregate = sum)
      # 
      # sizes = 15:35
      # for (s in as.character(sizes)) {
      #   if (!s %in% names(s.df)) s.df[[s]] = 0
      # }
      # 
      # s.df$pa <- pa
      # 
      # s.df <- s.df[, c('pa','type', 'locus', 'strand', as.character(sizes))]
      # 
      # # sum(unlist(s.df[,as.character(sizes)]))
      # 
      # write.table(s.df, file_name, row.names = F, col.names = T, sep='\t', quote=F)
      # 
      # size.df <- rbind(size.df, s.df)
      
    }
  }
  
  return(size.df)
}

te_depth.df <- get_depths(molecule='te')
  


get_mrna_depths <- function(force=F) {
  
  
  
  dir.create(str_glue('00-ncbi_depths'))
  
  size.df <- data.frame()
  for (project in project.df$project[project.df$f_pass]) {
    
    # for (project in c('Asapi.PRJNA560456')) {
    message(project)
    
    annotations = str_split(project.df$conditions[project.df$project == project], ",")[[1]]
    # annotations = 'A'
    pas <- paste0(project, ".", annotations)
    abbv = str_sub(project, 1, 5)
    
    if (abbv %in% c("Blhor")) {
      message("  skipping problematic species")
      next
    }
    
    dirs <- get_dir_paths()
    
    message("  checking bamfile...")
    
    bamfile = paste0(dirs$ann, project, "/align/alignment.bam")
    if (!file.exists(bamfile)) {print(paste(bamfile, 'not found')); next}
    
    header =scanBamHeader(bamfile)
    seqids = names(header[[1]]$targets)
    
    
    message(str_glue("  reading ncbi gff..."))
    
    s.df = species.df[species.df$abbv == abbv,]
    gff = str_glue("{dirs$gen}{abbv}.{s.df$accession}_{s.df$assembly_name}_genomic.gff3")
    
    gr <- import.gff(gff, 
                     feature.type	=c('mRNA','exon'))
    
    if (!abbv %in% lookup.df$abbv) {
      # next
      message("warning: abbv not found in chr lookup table...")
    }
    
    ## fixing problems with genbank/refseq chromosome names
    
    
    gr <- fix_seqlevels(gr, seqids)
    if (is.null(gr)) next
    
    
    mrna.gr <- gr[gr$type == 'mRNA',]
    exon.gr <- gr[gr$type == 'exon',]
    
    
    
    for (pa in pas) {
      message(paste0("  ", pa))
      
      libraries = library.df$srr[paste(library.df$abbv, library.df$bioproject, library.df$rg, sep='.') == pa]
      
      if (length(libraries) == 0) next
      
      file_name = paste0("00-ncbi_depths/", pa, ".ncbi.txt")
      
      if (file.exists(file_name) & !force) {
        
        if (file.info(file_name)$size <= 1) next
        s.df <- read.delim(file_name)
        
        names(s.df) <- str_replace(names(s.df), "^X", "")
        if (nrow(s.df) > 0) {
          message("    -> found")
          size.df <- rbind(size.df, s.df)
          next
        }
      }
      message("    counting reads...")
      
      pb = txtProgressBar(0,length(gr), style=3, width=30)
      
      s.df <- data.frame()
      for (i in 1:length(mrna.gr)) {
        # cat('.')
        setTxtProgressBar(pb, i)
        
        gri = mrna.gr[i,]
        gre = exon.gr[unlist(exon.gr$Parent) == gri$ID,]
        
        param = ScanBamParam(which=gri, 
                             what=c('qwidth', 'strand', 'pos'),
                             tagFilter= list(RG=libraries[1]))
        b = scanBam(bamfile, param=param)[[1]]
        
        tab = table(size=b$qwidth, strand=b$strand)
        # tab <- tab[,c('size','strand')]
        if (length(tab) == 0) next
        
        tab = as.data.frame(tab)
        names(tab) = c('size','strand','freq')
        tab <- tab[tab$strand != "*",]
        tab$type = gri$ID
        tab$locus = paste0(seqnames(gri), ":", start(gri), "-", end(gri))
        # tab$strand = strand
        
        s.df <- rbind(s.df, tab)
      }
      close(pb)
      
      if (nrow(s.df) == 0) {write.table(s.df, file_name, row.names = F, col.names = T, sep='\t', quote=F); next} 
      # s.df <- 
      s.df <- dcast(s.df, type + locus + strand ~ size, value.var='freq', fun.aggregate = sum)
      
      sizes = 15:35
      for (s in as.character(sizes)) {
        if (!s %in% names(s.df)) s.df[[s]] = 0
      }
      
      s.df$pa <- pa
      
      s.df <- s.df[, c('pa','type', 'locus', 'strand', as.character(sizes))]
      
      # sum(unlist(s.df[,as.character(sizes)]))
      
      write.table(s.df, file_name, row.names = F, col.names = T, sep='\t', quote=F)
      
      size.df <- rbind(size.df, s.df)
      
    }
  }
  
  return(size.df)
}





# metaplot ----------------------------------------------------------------


project = 'Asapi.PRJNA560456'
annotation = "A"
abbv  = str_sub(project, 1, 5)


s.df = species.df[species.df$abbv == abbv,]
gff = str_glue("{dirs$gen}{abbv}.{s.df$accession}_{s.df$assembly_name}_genomic.gff3")
m.gr <- import.gff(gff, feature.type='mRNA')
e.gr <- import.gff(gff, feature.type='exon')


pos.ls <- read_json(str_glue("../count_features/01out-details/{project}.pos.json.gz"))


genes <- apply(str_split_fixed(names(pos.ls), "_", 3)[,1:2], 1, function(x) paste(x[1],x[2], sep='_'))
mRNAs <- m.gr$ID[match(genes, unlist(m.gr$Parent))]

bin.df <- data.frame()

pb = txtProgressBar(0,length(pos.ls), style=3, width=30)
for (i in 1:length(pos.ls)) {
  
  setTxtProgressBar(pb, i)
  gene = names(pos.ls)[i]
  
  exon_length = pos.ls[[gene]]$exon_length
  strand      = pos.ls[[gene]]$strand
  
  bin_size = 15
  
  if (exon_length < bin_size * 100) next
  
  df <- lapply(pos.ls[[gene]]$table, unlist)
  
  df <- as.data.frame(lapply(df, type.convert, as.is=T))
  df$bin = floor(df$rpos / bin_size)  
  df$stranding = ifelse(df$strand == strand, 'ss', 'as')
  df <- df[complete.cases(df),]
  
  if (nrow(df) == 0 ) next
  
  df$gene = gene
  
  df <- df[,c('gene','condition','fpos','rpos','depth','bin','stranding')]
  bin.df <- rbind(bin.df, df)
  
}

ss.df <- bin.df[bin.df$stranding == 'ss',]
as.df <- bin.df[bin.df$stranding == 'as',]


fold <- function(b.df) {
  b.df <- dcast(b.df, gene ~ bin, value.var='depth', fun.aggregate = sum)
  rownames(b.df) <- b.df$gene
  b.df$gene <- NULL
  b.df$'NA' <- NULL
  return(b.df)
}

ss.df <- fold(ss.df)
as.df <- fold(as.df)

as.df <- as.df[rowSums(as.df) > rowSums(ss.df)[rownames(as.df)],]

b.df <- as.df
b.df <- b.df[complete.cases(b.df),]
b.df <- b.df[rowSums(b.df) > 0, ]


b.df <- t(scale(t(b.df)))
lp <- layermap(b.df, zlim=c(0,5))
lp <- lp_color_legend(lp, 1)


b.df <- b.df[,as.character(0:100)]
# b.df <- b.df / rowSums(b.df)



plot(as.numeric(colnames(b.df)), colMeans(b.df, na.rm=T), type='p', 
     xlab='Distance from 3p end', 
     ylab='Average proportional depth', las=1, 
     main=paste(project, annotation, sep='.'))







# size metaplot -----------------------------------------------------------


# project = 'Asapi.PRJNA565611'
# project = 'Bocin.PRJNA1092616'
# project = 'Bocin.PRJNA431815'
# project = 'Bocin.PRJNA431815'
project = 'Bocin.PRJNA752615'

table(project.df$abbv[project.df$f_pass])


make_size_heatmaps <- function(save=F) {
  for (abbv in unique(project.df$abbv[project.df$f_pass])) {
    p.df <- project.df[project.df$abbv == abbv,]
  
  
    gff.ls <- get_gff_grrs(abbv)
    if (length(gff.ls) <= 1) next
    
    overlapping_genes = unique(c(findOverlaps(gff.ls$ncbi.gene, gff.ls$te)@from, 
                                 findOverlaps(gff.ls$ncbi.gene, gff.ls$rfam)@from))
    overlapping_genes = gff.ls$ncbi.gene$ID[overlapping_genes]
    
    for (project in p.df$project[p.df$f_pass & p.df$abbv == abbv]) {
      
      
      size.ls <- read_json(str_glue("../count_features/01out-details/{project}.sizes.json.gz"))
      
      names(size.ls)
      
      
      if (length(size.ls) == 0) next
      
      rfam_genes <- names(size.ls)[str_detect(names(size.ls), "^RF")]
      ncbi_genes <- names(size.ls)[str_detect(names(size.ls), "^gene")]
      te_genes   <- names(size.ls)[!names(size.ls) %in% c(rfam_genes, ncbi_genes)]
      ncbi_genes <- ncbi_genes[!ncbi_genes %in% overlapping_genes]
      
      ncbi_genes <- sample(ncbi_genes, min(c(length(ncbi_genes),length(rfam_genes)*2)))
      te_genes   <- sample(te_genes  , min(c(length(te_genes),length(rfam_genes)*2)))
      
      
      size.df <- data.frame()
      # for (gene in names(size.ls)) {
      for (gene in c(ncbi_genes, te_genes, rfam_genes)) {
        message(gene)
        
        df <- lapply(size.ls[[gene]]$table, unlist)
        
        df <- as.data.frame(lapply(df, type.convert, as.is=T))
        
        if (nrow(df) == 0) next
        df$stranding = ifelse(df$strand == size.ls[[gene]]$strand, 'ss','as')
        df$gene = gene
        df$source = size.ls[[gene]]$source
        df$locus = size.ls[[gene]]$locus
        
        
        size.df <- rbind(size.df, df)
        
      }
      
      s.df <- dcast(size.df, condition + locus + gene + source ~ size, value.var='depth', fun.aggregate = sum)
      s.df$width <- width(GRanges(s.df$locus))
      
      # stop(" I'm thinking that I should confirm that these are reproducibly peaked at 21 + 22. I've done this from the sRNA-side, but not the mRNAs")
      
      
      sizes = as.character(15:35)
      for (s in sizes[!sizes %in% names(s.df)]){
        s.df[[s]] <- 0
      }
      
      condition = s.df$condition[1]
      
      s.df <- s.df[s.df$condition == condition,]
      # s.df <- s.df[s.df$stranding == 'ss',]
      s.df <- s.df[rowSums(s.df[,sizes]) > 0,]
      
      rownames(s.df) <- s.df$gene
      
      total_aligned = sum(library.df[paste(library.df$project, library.df$rg, sep='.') == paste0(project,'.',condition),'total_aligned'])
      s.df$log10abd <- log10(rowSums(s.df[,sizes]))
      s.df$rpm <- rowSums(s.df[,sizes]) / total_aligned * 1000000
      s.df$rpkm <- s.df$rpm / s.df$width * 1000
      
      
      value.df <- s.df[,sizes]
      
      # max_ic = entropy(15:35)
      # ic <- function(x) {
      #   
      #   v = as.numeric(rep(sizes, unlist(x)))
      #   tab = tabulate(v, nbins = 35)[15:35]
      #   # tab = sort(tab)
      #   tab = tab / sum(tab)
      #   
      #    
      #   return (tab * (max_ic - entropy(v)))
      # }
      # 
      # entropy.df = data.frame()
      # for (i in 1:nrow(s.df)) {
      #   
      #   entropy.df <- rbind(entropy.df,ic(s.df[i,sizes]) )
      # }
      # 
      # names(entropy.df) <- sizes
      # rownames(entropy.df) <- rownames(s.df)
      
      
      # value.df <- value.df/apply(value.df,1, max, na.rm=T)
      
      row.df <- s.df
      row.df$peak <- apply(value.df, 1, function(x) as.numeric(names(value.df)[which.max(x)]))
      
      row.df <- row.df[order(row.df$log10abd),]
      row.df <- row.df[order(row.df$peak),]
      row.df <- row.df[row.df$log10abd > 3,]
      
      
      # value.df <- value.df[rownames(row.df),]
      # entropy.df <- entropy.df[rownames(row.df),]
      value.df <- t(scale(t(value.df)))
      # value.df <- value.df / apply(value.df, 1, max, na.rm=T)
      
      row.df <- row.df[rownames(value.df),]
      
      par(mar=c(4,5,4,6))
      
      lp <- layermap(entropy.df, palette = 'mako', reverse_palette = F,
                     row.df=row.df,
                     zlim=c(0,2),
                     row_groups = 'source',
                     cluster_rows = F)
      lp <- lp_annotate(lp, 4, 'rpkm', palette ='reds', reverse_palette = T, zlim=c(0,5))
      lp <- lp_annotate(lp, 4, 'rpm', palette ='blues', reverse_palette = T, zlim=c(0,50))
      lp <- lp_group_names(lp, 2, 'source')
      lp <- lp_names(lp, 3)
      lp <- lp_color_legend(lp, 1, attributes = c('main','rpkm', 'rpm') , size_p=0.25)
      mtext(paste0(project, ".", condition), side=3, line=2, at=0, adj=0, font=2, cex=1)
    }
  }
}

make_size_heatmaps()




abbv = "Asapi"

out.ls <- list()
for (project in project.df$project[project.df$f_pass & project.df$abbv == abbv]) {
  
  size.ls <- read_json(str_glue("../count_features/01out-details/{project}.sizes.json.gz"))
  message(project)
  
  out.ls[[project]] <- data.frame()
  for (gene in names(size.ls)) {
    # message(gene)
    
    df <- lapply(size.ls[[gene]]$table, unlist)
    
    df <- as.data.frame(lapply(df, type.convert, as.is=T))
    
    df <- df[df$condition == 'A',]
    
    if (nrow(df) == 0) next
    df$stranding = ifelse(df$strand == size.ls[[gene]]$strand, 'ss','as')
    df$gene = gene
    df$source = size.ls[[gene]]$source
    df$locus = size.ls[[gene]]$locus
    
    
    df <- dcast(df, gene + size ~ 'depth', value.var='depth', fun.aggregate = sum)
    
    df <- df[order(df$size),]
    
    w <- which.max(df$depth)
    
    df$prop <- df$depth / sum(df$depth)
    
    
    out.ls[[project]] <- rbind(out.ls[[project]], df[w,,F])
    
    
      
  }
  
}


props <- NULL
peaks <- NULL
abds  <- NULL

for (i in 1:length(out.ls)) {
  p = names(out.ls)[i]
  
  df <- out.ls[[p]]
  row.names(df) <- df$gene
  
  if (is.null(props)) {
    props <- df[,'prop',drop=F]
    peaks <- df[,'size',drop=F]
    abds  <- df[,'depth' ,drop=F]
    
  } else {
    props = merge(props, df[,'prop',drop=F], by=0)
    peaks = merge(peaks, df[,'size',drop=F], by=0)
    abds  = merge(abds,  df[,'depth',drop=F], by=0)
    
    rownames(props) <- props$Row.names
    rownames(peaks) <- peaks$Row.names
    rownames(abds)  <- abds$Row.names
    
    props$Row.names <- NULL
    peaks$Row.names <- NULL
    abds$Row.names <- NULL
    
  }
  
  names(props)[i] =  names(out.ls)[i]
  names(peaks)[i] =  names(out.ls)[i]
  names(abds)[i]  =  names(out.ls)[i]
  head(props)
  
  
}



# Pairing size-biases between projects ------------------------------------



abbv = "Bocin"


out.ls <- list()
for (project in project.df$project[project.df$f_pass & project.df$abbv == abbv]) {
  
  size.ls <- read_json(str_glue("../count_features/01out-details/{project}.sizes.json.gz"))
  message(project)
  
  out.ls[[project]] <- data.frame()
  for (gene in names(size.ls)) {
    # message(gene)
    
    df <- lapply(size.ls[[gene]]$table, unlist)
    
    df <- as.data.frame(lapply(df, type.convert, as.is=T))
    
    df <- df[df$condition == 'A',]
    
    if (nrow(df) == 0) next
    df$stranding = ifelse(df$strand == size.ls[[gene]]$strand, 'ss','as')
    df$gene = gene
    df$source = size.ls[[gene]]$source
    df$locus = size.ls[[gene]]$locus
    
    df$sizing <- factor('typical', levels=c("N-",'typical','N+'))
    df$sizing[df$size <= 19] <- 'N-'
    df$sizing[df$size >= 23] <- 'N+'
    
    df <- dcast(df, gene + sizing ~ 'depth', value.var='depth', fun.aggregate = sum)
    
    out.ls[[project]] <- rbind(out.ls[[project]], df)
  }
  
  out.ls[[project]] <- dcast(out.ls[[project]], gene ~ sizing, value.var='depth', fun.aggregate = sum)
  
  rownames(out.ls[[project]]) <- out.ls[[project]]$gene
  out.ls[[project]]$gene <- NULL
}


head(gff.ls$ncbi.gene)
head(gff.ls$rfam)
head(gff.ls$te)

get_gene.df <- function(abbv) {
  gff.ls <- get_gff_grrs(abbv)
  
  gff.ls$ncbi.gene$source <- 'ncbi'
  gff.ls$rfam$name <- paste0(gff.ls$rfam$ID, ";", 
                             as.vector(seqnames(gff.ls$rfam)), ":", start(gff.ls$rfam), '-', end(gff.ls$rfam))
  
  gff.ls$te$name <- paste0(gff.ls$te$type, ";", 
                             as.vector(seqnames(gff.ls$te)), ":", start(gff.ls$te), '-', end(gff.ls$te))
  gff.ls$ncbi.gene$name <- gff.ls$ncbi.gene$ID
  
  cols = c('seqnames','start','end','width','strand','name', 'source')
  gene.df <- rbind(as.data.frame(gff.ls$ncbi.gene)[,cols],
                   as.data.frame(gff.ls$rfam)[,cols],
                   as.data.frame(gff.ls$te)[,cols])
}

gene.df <- get_gene.df('Bocin')
  
  
for (i in 1:length(out.ls)) {
  
  # df = out.ls[[i]][rowSums(out.ls[[i]]) > 100,]
  df <- out.ls[[i]]
  df <- df / rowSums(df)
  
  # rownames(out.ls[[i]])
  
  
  hc = hclust(dist(df))
  df <- df[hc$order,]
  gene.df[[paste0("order-",i)]] <- match(gene.df$name, rownames(df))
  
  # gene.df <- gene.df[order(gene.df$`order-4`),]
  
  # head(gene.df)
  # head(hc$labels)
  # b = barplot(t(df[gene.df$name,]),
  #             horiz=T, space=0, border=NA,
  #             col=c('black','mediumseagreen','black'),
  #             main=names(out.ls)[i])
   
}





gene.df <- gene.df[order(gene.df$`order-4`),]

par(mfrow=c(1,4))
for (i in 1:length(out.ls)) {
  
  df <- out.ls[[i]]
  df <- df / rowSums(df)

  df <- df[gene.df$name,]
  
  b = barplot(t(df), horiz=T, space=0, border=NA, col=c('black','mediumseagreen','black'),
          main=names(out.ls)[i])
  
  # points(rep(1, length(b)), b, col=c(te='cadetblue',mRNA=NA,rfam='firebrick2')[source[hc$order]])
}


merge.df <- gene.df[gene.df$source == 'Rfam',]
merge.df <- merge.df[,'name',drop=F]
for (i in 1:length(out.ls)) {
 # for (i in c(2,4)) {
  df = out.ls[[i]]
  df <- df / rowSums(df)
  
  merge.df <- merge(merge.df, df, by.x='name', by.y=0)    
  
  names(merge.df)[(ncol(merge.df)-2):ncol(merge.df)] <- paste0(names(out.ls)[i], "_", c("N-","typical","N+"))

  
}
rownames(merge.df) <- merge.df$name
merge.df$name <- NULL

hc = hclust(dist(merge.df[,names(merge.df)[str_detect(names(merge.df), "typical")]]))

merge.df <- merge.df[hc$order,]


barplot(t(merge.df), horiz=T, space=0, border=NA, col=c('black','mediumseagreen','black'))




col.df <- data.frame(row.names=names(merge.df), 
                     project = rep(names(out.ls), each=3))
lp <- layermap(merge.df,
               cluster_rows = F,
               col.df = col.df,
               column_groups = 'project',
               palette = 'mako',
               reverse_palette = F)

lp <- lp_group_names(lp, 3, 'project')








# annotation counts -------------------------------------------------------

out.df = data.frame()
for (abbv in unique(metalocus.df$abbv[metalocus.df$replication == 'binom+project+sizing'])) {
  gene.df <- get_gene.df(abbv)
  
  g.df <- gene.df
  f <- g.df$source != 'ncbi'
  
  g.df$subclass[f] <- str_split_fixed(g.df$name[f], ';', 2)[,1]
  g.df$subclass[!f] <- 'mRNA'
  
  
  tab <- table(g.df$subclass,g.df$source)
  tab <- as.data.frame(tab)
  names(tab) <- c('subclass','class','freq')
  tab$abbv = abbv
  out.df <- rbind(out.df, tab)
}


# 5'bias ------------------------------------------------------------------




project = 'Asapi.PRJNA560456'
abbv = 'Bocin'

gene.df <- get_gene.df(abbv)


out.ls <- list()
for (project in project.df$project[project.df$f_pass & project.df$abbv == abbv]) {
  
  bias.ls <- read_json(str_glue("../count_features/01out-details/{project}.bias.json.gz"))
  message(project)
  
  out.df <- data.frame()
  for (gene in names(bias.ls)) {
    # message(gene)
    
    df <- lapply(bias.ls[[gene]]$table, unlist)
    
    df <- as.data.frame(lapply(df, type.convert, as.is=T))
    
    df <- df[df$condition == 'A',]
    
    
    if (nrow(df) == 0) next
    
    df$fivep[df$fivep == 'T'] <- 'U'
    df$fivep[df$fivep == 'TRUE'] <- 'U'
    df$stranding = ifelse(df$strand == bias.ls[[gene]]$strand, 'ss','as')
    df$gene = gene
    df$source = bias.ls[[gene]]$source
    df$locus = bias.ls[[gene]]$locus
    
    
    df <- dcast(df, gene + fivep ~ 'depth', value.var='depth', fun.aggregate = sum)
    
    out.df <- rbind(out.df, df)
  }
  
  out.ls[[project]] <- dcast(out.df, gene ~ fivep, value.var='depth', fun.aggregate = sum)
  
  rownames(out.ls[[project]]) <- out.ls[[project]]$gene
  out.ls[[project]]$gene <- NULL
}


tab.ls <- list()
for (i in 1:length(out.ls)) {
  project = names(out.ls)[i]
  message(project)
  
  df = out.ls[[i]]
  df$depth <- rowSums(df)
  
  df <- cbind(df[,1:4] / df$depth, depth=df$depth)
  df$bias_p <- apply(df[, 1:4], 1, function(x) round(x[which.max(x)] * 100) )
  df$bias <- apply(df[, 1:4], 1, function(x) names(df)[which.max(x)])
  df$source <- gene.df$source[match(rownames(df), gene.df$name)]
  
  f = df$depth >= 100 & df$bias_p >= 50
  tab = table(df$source[f], df$bias[f])
  
  tab.ls[[project]] = list()
  tab.ls[[project]]$tab = tab
  tab.ls[[project]]$ptab = tab / rowSums(tab)
  
}

tab.ls

# logos -------------------------------------------------------------------


library(seqLogo) 

mFile <- system.file("extdata/pwm1", package="seqLogo")
m <- read.table(mFile)
m
##    V1  V2  V3  V4  V5  V6  V7  V8
## 1 0.0 0.0 0.0 0.3 0.2 0.0 0.0 0.0
## 2 0.8 0.2 0.8 0.3 0.4 0.2 0.8 0.2
## 3 0.2 0.8 0.2 0.4 0.3 0.8 0.2 0.8
## 4 0.0 0.0 0.0 0.0 0.1 0.0 0.0 0.0
p <- makePWM(m)
p
ic(p)
p@ic
seqLogo::plot(p)



# entropy playground ------------------------------------------------------

setosa_subset <- iris[iris$Species=="setosa",]
entropy <- function(target) {
  freq <- table(target)/length(target)
  # vectorize
  vec <- as.data.frame(freq)[,2]
  #drop 0 to avoid NaN resulting from log2
  vec<-vec[vec>0]
  #compute entropy
  -sum(vec * log2(vec))
}

entropy(setosa_subset$Species)
entropy(iris$Species)


s.df <- size.df[size.df$gene == 'gene-BCIN_10g06000',]
x = rep(s.df$size, s.df$depth)
tab = table(x)
tab = sort(tab)
tab = tab / sum(tab)


tab * (entropy(15:35) - entropy(x))



entropy(15:35)

information_content <- function(size_vector, all_sizes) {}


