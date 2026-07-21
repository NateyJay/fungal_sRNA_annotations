# 00-preprocessing.R



dir.create("00-processed_tables", showWarnings=F)



# chromosome lookups ------------------------------------------------------



make_lookup.df <- function(force=F) {
  lookup_file= "00-lookup_table.txt"
  if (!force & file.exists(lookup_file)) {
    return(read.delim(lookup_file))
  }
  lookup.df <- data.frame()
  colnames = c('abbv','assemblyAccession','genbankAccession', 'refseqAccession','length')
  for (file in Sys.glob('../+genomes/*sequence_report.jsonl')){
    
    print(file)
    abbv = str_sub(file, 13,17)
    con = file(file, 'r')
    
    if (!abbv %in% metalocus.df$abbv) next
    
    while (T) {
      line = readLines(con, n=1)
      if ( length(line) == 0 ) {
        break
      }
      
      df <- as.data.frame(jsonlite::parse_json(line))
      df <- cbind(data.frame(abbv=abbv), df)
      df$sequenceName <- NULL
      
      for (n in colnames) {
        if (!n %in% names(df)) {
          df[[n]] = NA
        }
      }
      df <- df[,colnames]
      
      lookup.df <- rbind(lookup.df, df)
      
    }
    close(con)
    
  }
  write.table(lookup.df, lookup_file, quote=F, sep='\t', row.names = F)
  return(lookup.df)
}

lookup.df <- make_lookup.df()


# phylogneny ------------------------------------------------

dend <- ape::read.tree("../phylogenies/18s.raxml.bestTree")

# species ------------------------------------------------

get_species.df <- function(force=F) {
  
  message("loading species...")
  
  table_file = file.path("00-processed_tables", "species.txt")
  if (file.exists(table_file) & !force) {
    m.df= read.delim(table_file)
    
    return(m.df)
  }
  
  
  s.df <- readxl::read_excel("../phylogenies/Species_information.xlsx")
  s.df <- as.data.frame(s.df)
  head(s.df)
  names(s.df)[2] <- 'abbv'
  s.df <- s.df[!duplicated(s.df$abbv),]
  
  
  t.df <- read.delim("../phylogenies/01out-taxonomy_info.txt")
  t.df[duplicated(t.df$abbv),]
  t.df <- t.df[!duplicated(t.df$abbv),]
  head(t.df)
  
  m.df <- merge(t.df, s.df[,c('abbv','AKA','Common Name or Disease', 'Model', "Importance", "Pathogen", "Mutualist", "clean_lifestyle")], 
                by.x='abbv', all.x=T)
  
  rownames(m.df) <- m.df$abbv
  
  m.df$Pathogen[m.df$Pathogen == '-'] <- NA
  
  
  d.df <- data.frame(names=dend$tip.label)
  d.df$genus <- str_split_fixed(d.df$names, "_", 2)[,1]
  d.df$species <- apply(str_split_fixed(d.df$names, "_", 3)[,1:2], 1, paste, collapse=' ')
  d.df$species <- str_remove(d.df$species, '\\.')
  
  m.df$tree_name <- d.df$names[match(m.df$species, d.df$species)]
  f = is.na(m.df$tree_name)
  m.df$tree_name[f] <- d.df$names[match(m.df$genus[f], d.df$genus)]
  
  m.df$species <- str_replace(m.df$species, "Pyricularia", "Magnaporthe")
  
  
  g.df <- Sys.glob("../+genomes/*.fa")
  g.df <- str_sub(g.df, 13, -1)
  g.df <- data.frame(abbv= str_sub(g.df, 1, 5),
                     accession = str_sub(g.df, 7, 21),
                     assembly_name = str_sub(g.df, 23, -12))
  
  get_gen_size <- function(fai_file) {
    df <- read.delim(fai_file, header=F)
    return(sum(df$V2))
  }
  get_contig_count <- function(fai_file) {
    df <- read.delim(fai_file, header=F)
    return(nrow(df))
  }
  
  files <- Sys.glob("../+genomes/*.fai")
  f.df <- str_sub(files, 13, -1)
  f.df <- data.frame(abbv= str_sub(f.df, 1, 5),
                     genome_length = as.vector(sapply(files, get_gen_size)),
                     contig_n = as.vector(sapply(files, get_contig_count))
                     )
  
  m.df <- merge(m.df, g.df, by='abbv')
  m.df <- merge(m.df, f.df, by='abbv', all.x=T)
  
  write.table(m.df, table_file, quote=F, sep='\t', row.names = F)
  
  
  return(m.df)  
}


species.df <- get_species.df()


# library metadata --------------------------------------------------------

get_metadata.df <- function() {
  meta_file = file.path("/Volumes/YASMA/master_table.xlsx")
  # meta_file = file.path(path)
  
  
  
  
  if (file.exists(meta_file)) {
    
    message("/Volumes/YASMA/master_table.xlsx found!")
    message("backing up and loading...")
    
    backup_backup = str_glue("backup_{Sys.Date()}.xlsx")
    file.copy("backup.xlsx", backup_backup, overwrite = TRUE)
    file.copy(meta_file, "backup.xlsx", overwrite = TRUE)
    
    metadata.df <- readxl::read_excel(meta_file, skip=1)
    
    
    
  } else {
    message("/Volumes/YASMA/master_table.xlsx not found!")
    message("  -> working from backup file")
    # scp njohnson@darwin:/home2/njohnson/fungi_annotations/batch_scripts/master_table.xlsx ./backup.xlsx
    metadata.df <- readxl::read_excel("backup.xlsx", skip=1)
    
  }
  
  metadata.df <- as.data.frame(metadata.df)
  metadata.df <- metadata.df[!is.na(metadata.df$`project-rg`),]
  
  metadata.df$abbv <- str_c(str_sub(metadata.df$fungi_species, 1,2),
                        str_sub(str_split_fixed(metadata.df$fungi_species, " ", 2)[,2], 1,3),
                        sep='')
  
  # unique(metadata.df$`Replicate group`)
  
  metadata.df$has_dicer_mutant <- str_detect(metadata.df$`Replicate group`, "\\.")
  head(metadata.df)
  
  return(metadata.df)
}

metadata.df <- get_metadata.df()


# scaled peaks ----------------------------------------------------------

get_scale.df <- function(filter=F, force=F) {
  message("loading scaled size profiles...")
  # p.df <- project.df
  
  
  table_file = file.path("00-processed_tables", "peaks.txt")
  if (file.exists(table_file) & !force) {
    out.df= read.delim(table_file)
    
    return(out.df)
  }
  
  out.df <- data.frame()
  
  for (peak_file in Sys.glob("../+annotations/*/align/alignment.peak_table.txt")) {
    message(peak_file)
    
  # for (project in p.df$project) {
    # message(project)
    
    # peak_file = file.path("../+annotations", project, "align/alignment.peak_table.txt")
    
    if (!file.exists(peak_file)) {
      message("  ^^^ peak_file not found")
      next
    }
    
    df <- read.delim(peak_file)
    
    if (filter) {
      
      if (length(unique(df$peak)) == 1) {message('  xxx filtered'); next}
      
      slope_peaks = unique(df$peak[df$size %in% 15:18])
      if (length(slope_peaks) > 1) {message('  xxx filtered'); next}
      if (slope_peaks != "None") {message('  xxx filtered'); next}
    }
    
    if (nrow(out.df) == 0 | identical(names(out.df), names(df))) {
      out.df <- rbind(out.df, df)
    }
    
  }
  
  out.df$abbv <- str_sub(out.df$project, 1, 5)
  
  write.table(out.df, table_file, quote=F, sep='\t', row.names=F)
  
  return(out.df)
}

scale.df <- get_scale.df()

# projects -------------------------------------------------------


import_projects <- function(filter = T) {
  annotations_dir = "../+annotations"
  m.df <- metadata.df
  m.df$project <- paste(m.df$abbv, m.df$bioproject, sep='.')
  
  head(m.df)  
  
  comma_paste <- function(x) {
    x <- x[!duplicated(x)]
    x <- x[order(x)]
    paste(x, collapse=',')
  }
  rg.df <- m.df[,c('project', 'Replicate group')]
  rg.df <- dcast(rg.df, project ~ ., fun.aggregate = comma_paste)
  
  m.df <- m.df[,c('fungi_abbv','project')]  
  names(m.df) <- c('abbv','project')
  m.df$conditions <- rg.df$`.`[match(m.df$project, rg.df$project)]
  
  
  m.df$abbv[m.df$project == 'Vacer.PRJNA399493'] <- "Nocer"
  m.df$project[m.df$project == 'Vacer.PRJNA399493'] <- "Nocer.PRJNA399493"
  
  # m.df$project <- str_c(m.df$abbv, m.df$bioproject, sep='.')
  m.df <- m.df[!duplicated(m.df$project),]
  
  rownames(m.df) <- m.df$project
  
  
  
  
  
  aln.df <- data.frame()
  for (p in m.df$project) {
    
    project_file = file.path(annotations_dir, p, "align/project_stats.txt")
    
    if (!file.exists(project_file)) next
    
    df <- read.delim(project_file)
    
    if (!"xmap_fr" %in% names(df))  df$xmap_fr = 0
    
    aln.df <- rbind(aln.df, df)
  }
  
  
  m.df <- merge(m.df, aln.df, by='project', all.x=T)
  
  m.df$abbv <- str_sub(m.df$project, 1, 5)
  
  # if (filter) m.df <- filter_projects(m.df)
  return(m.df)
  
}


filter_projects <- function(p.df) {
  
  
  rownames(p.df) <- p.df$project
  
  p.df <- p.df[complete.cases(p.df),]
  p.df$total_aligned <- rowSums(p.df[,c('umap', 'mmap_wg', 'mmap_nw')])
  p.df$alignment_rate <- p.df$total_aligned / rowSums(p.df[,c('umap', 'mmap_wg', 'mmap_nw', 'xmap_nw', 'xmap_ma', 'xmap_nv')])
  
  # absolute alignment >= 1M reads
  p.df$f_abs_alignment <- p.df$total_aligned >= 1000000
  table(p.df$f_abs_alignment)
  
  # relative alignment >= 0.05
  p.df$f_rel_alignment <- p.df$alignment_rate >= 0.05
  # p.df[is.na(p.df$f_rel_alignment),]
  p.df$f_rel_alignment[is.na(p.df$f_rel_alignment)] <- F
  table(p.df$f_rel_alignment)
  
  table(`abs`=p.df$f_abs_alignment, `rel`=p.df$f_rel_alignment)
  
  k.df <- scale.df
  # k.df <- get_peak_scales(project.df)
  k.df <- k.df[k.df$peak != "None", c('project','size','peak')]
  
  
  # has a peak
  # originally this was based off of peak tools from yasma
  
  # p.df$f_has_peak <- p.df$project %in% k.df$project
  # table(p.df$f_has_peak)
  # 
  k.df <- k.df[k.df$size < 18 | k.df$size > 32,]
  
  # now, i've changed to a manual filter, produced with some knowledge of nucleotide bias at the 5'. Unbiased peaks must be very clear.
  
  bias.df <- as.data.frame(readxl::read_excel("01-bias_categorization.xlsx"))
  bias.df <- bias.df[!bias.df$`peak range` %in% c('noise','none','multi'),]
  bias.df <- bias.df[!is.na(bias.df$f_pass),]
  
  # bias.df$comment[is.na(bias.df$comment)] <- "pass"
  # table(bias.df$comment)
  # bias.df <- bias.df[bias.df$comment %in% c('pass', 'some T also','multi','noisy'),]
  p.df$f_has_peak <- p.df$project %in% bias.df$project
  
  
  
  
  # no slope
  p.df$f_no_slope <- !p.df$project %in% k.df$project & p.df$f_has_peak
  table(p.df$f_no_slope)
  
  head(p.df)
  
  
  f.df <- p.df[,c('f_abs_alignment', 'f_rel_alignment', 'f_has_peak', 'f_no_slope')]
  f.df <- as.data.frame(t(apply(f.df, 1, as.numeric)))
  
  p.df$filter_str <- apply(f.df, 1, paste, collapse='')
  p.df$f_pass <- apply(f.df, 1, sum) == 4
  
  write.table(p.df, "../+tables/projects.filtered.txt", quote=F, sep='\t', row.names = F)
  
  return(p.df) 
}

# project_bias_filter <- function(p.df) {
#   bias.df <- as.data.frame(readxl::read_excel("01-bias_categorization.xlsx"))
#   bias.df <- bias.df[!bias.df$`peak range` %in% c('noise','none','multi'),]
#   bias.df <- bias.df[!is.na(bias.df$f_pass),]
#   
#   # bias.df$comment[is.na(bias.df$comment)] <- "pass"
#   # table(bias.df$comment)
#   # bias.df <- bias.df[bias.df$comment %in% c('pass', 'some T also','multi','noisy'),]
#   p.df$f_bias <- p.df$project %in% bias.df$project
#   
#   p.df$filter_str <- str_c(p.df$filter_str, as.numeric(p.df$f_bias))
#   return(p.df)
# }


get_project.df <- function() {
  message("loading projects...")
  
  # project.df <- 
  p.df <- import_projects()
  p.df <- filter_projects(p.df)
  # p.df <- project_bias_filter(p.df)
  
  write.table(p.df, "00-processed_tables/project.txt", quote=F, sep='\t', row.names = F)
  
  return(p.df)
}

project.df <- get_project.df()


# View(project.df[project.df$filter_str == '11110',])
# 
# table(project.df$filter_str)
# boxplot(project.df$alignment_rate ~ project.df$f_bias)
# beeswarm::beeswarm(project.df$alignment_rate ~ project.df$f_bias, add=T)


# peaks -------------------------------------------------------------------

get_peak.df <- function() {
  message("loading profiles peaks...")
  
  p.df <- project.df
  
  out.df <- data.frame()
  
  for (project in p.df$project) {
    # message(project)
    # peak_file = file.path("../+annotations", project, "align/alignment.peak_table.txt")
    peak_file = file.path("../+annotations", project, "align/alignment.peak_summary.txt")
    
    if (!file.exists(peak_file)) {
      message("  ^^^ peak_file not found")
      next
    }
    
    # stop()
    df <- read.delim(peak_file)
    df <- df[df$peak != 'none',]
    df$abbv <- str_sub(df$project, 1, 5)
    out.df <- rbind(out.df, df)
    
  }
  
  return(out.df)
  
}

peak.df <- get_peak.df()



# libraries -----------------------------------------------------------------



get_library.df <- function() {
  message("loading libraries...")
  
  
  
  table_file = file.path("00-processed_tables", "libraries.txt")
  # if (file.exists(table_file) & !force) {
  #   out.df= read.delim(table_file)
  #   
  #   return(out.df)
  # }
  
  m.df <- metadata.df
  
  head(m.df)
  names(m.df)
  
  m.df <- m.df[,c('fungi_abbv','bioproject', 'Replicate group','srr')]  
  names(m.df) <- c('abbv','bioproject', 'rg','srr')
  
  m.df$project <- paste0(m.df$abbv,'.', m.df$bioproject)
  
  m.df[duplicated(m.df$srr),]
  
  rownames(m.df) <- m.df$srr
  
  write.table(m.df, table_file, quote=F, sep='\t', row.names=F)
  return(m.df)
}

library.df <- get_library.df()


get_alignment_details <- function() {
  dirs = get_dir_paths()
  
  
  a.df <- data.frame()
  for (bioproject in unique(library.df$bioproject)) {
    abbv = library.df$abbv[match(bioproject, library.df$bioproject)]
    project = paste0(abbv, ".", bioproject)
    message(project)
    
    aln_file = file.path(dirs$ann, project, 'align/library_stats.txt')
    if (!file.exists(aln_file)) next
    
    df <- read.delim(aln_file)
    
    a.df <- rbind(a.df, df)
    
    
  }
  
  a.df$total_aligned <- a.df$umap + a.df$mmap_wg + a.df$mmap_nw
  a.df$total_reads   <- a.df$umap + a.df$mmap_wg + a.df$mmap_nw + a.df$xmap_ma + a.df$xmap_nv + a.df$xmap_fr
  a.df$aln_rate <- a.df$total_aligned / a.df$total_reads
  
  m = match(library.df$srr, a.df$library)
  library.df$total_aligned <- a.df$total_aligned[m]
  library.df$total_reads   <- a.df$total_reads[m]
  library.df$aln_rate      <- a.df$aln_rate[m]
  return(library.df)
}

library.df <-get_alignment_details()


# metaloci ----------------------------------------------------------------


# get_metalocus.df <- function(force_overwrite=F) {
#   message("loading metaloci...")
#   
#   table_file = file.path("00-processed_tables", "metaloci.txt")
#   if (file.exists(table_file) & !force_overwrite) {
#     out.df= read.delim(table_file)
#     
#     return(out.df)
#   }
#   
#   
#   out.df <- data.frame()
#   for (abbv in unique(project.df$abbv)) {
#     
#     gff_file = str_glue("../metaloci/01out-meta_gffs/{abbv}.meta.gff3")
#     
#     message(str_glue("{abbv}.meta.gff3"))
#     
#     if (!file.exists(gff_file)) {
#       message("   ^^^ not found")  
#       next
#     }
#     # stop()
#     
#     df <- readGFF(gff_file)
#     df <- as.data.frame(df)
#     
#     if (nrow(df) == 0) next
#     
#     df$abbv <- abbv
#     
#     df$phase <- NULL
#     df$score <- NULL
#     df$source <- NULL
#     df$annotation_conditions <- NULL
#     df$annotation <- NULL
#     
#     bin <- binom_p(abbv)
#     if ('out' %in% names(bin)) {
#       df$bin_padj <- bin$out$padj[match(df$ID, rownames(bin$out))]
#       df$bin_pass <- df$bin_padj <= 0.05
#   
#     } else {
#       df$bin_padj <- NA
#       df$bin_pass <- NA
#       
#     }
#     
#     
#     out.df <- rbind(out.df, df)
#   }
#   
#   numeric_columns = c('rpm', 'rpkm','depth','member_annotations','member_projects','member_loci', 'median_depth','complexity','skew')
#   
#   for (c in numeric_columns) {
#     out.df[[c]] <- as.numeric(out.df[[c]])
#   }
#   
#   # out.df$name <- str_replace(out.df$metalocus, 'metalocus', out.df$abbv)
#   
#   out.df$primary <- out.df$primary == "True"
#   
#   
#   
#   
#   names(out.df)[names(out.df) == "ID"] <- "metalocus"
#   
#   out.df$sizing <- ifelse(out.df$sizecall %in% make_dicer_sizes(19:25), 'typical', 'atypical')
#   out.df$sizing[out.df$type == 'OtherRNA'] <- 'other'
#   
#   
#   
#   
#   ## third schema for replication
#   out.df$replication = "none"
#   out.df$replication[out.df$bin_padj < 0.1] = "binom"
#   out.df$replication[out.df$bin_padj < 0.01 & 
#                        !out.df$primary] = "binom"
#   
#   f = str_detect(out.df$replication, "binom") & out.df$member_projects > 1
#   out.df$replication[f] <- paste0(out.df$replication[f], "+project")
#   
#   f = str_detect(out.df$replication, "binom") & out.df$sizing == 'typical'
#   out.df$replication[f] <- paste0(out.df$replication[f], "+sizing")
#   
# 
#   table(out.df$replication)
#   
#   
#   
#   ## second schema for replication
#   # 
#   # l.df <- library.df
#   # l.df <- l.df[!duplicated(str_c(l.df$bioproject, l.df$rg)),]
#   # ann_tab = table(l.df$abbv)
#   # 
#   # out.df$p_ann_rep <- out.df$member_annotations / ann_tab[out.df$abbv]
#   # 
#   # 
#   # 
#   # out.df$replication <- "None"
#   # out.df$replication[out.df$primary & 
#   #                      out.df$member_projects >= 2 & 
#   #                      out.df$p_ann_rep > 0.1] <- "Pass_minimal"
#   # out.df$replication[out.df$primary & 
#   #                      out.df$member_projects >= 2 & 
#   #                      out.df$p_ann_rep > 0.2 & 
#   #                      out.df$member_annotations > 3] <- "Pass_primary"
#   # out.df$replication[!out.df$primary & 
#   #                      out.df$member_projects >= 4 &  
#   #                      out.df$p_ann_rep > 0.4 & 
#   #                      out.df$member_annotations > 6] <- "Pass_secondary"
#   
#   f = out.df$sizing == 'typical'
#   table(out.df$replication[f], out.df$abbv[f])
#   
#   header = names(out.df)
#   in_front = c('abbv', "metalocus", 'type', 'member_loci','member_annotations','member_projects', 'replication')
#   header = c(in_front, header[!header %in% in_front])
#   out.df <- out.df[,header]
#   
#   ## first idea for replication
#   
#   # l.df <- library.df[!duplicated(library.df$bioproject),]
#   # rep_proj <- table(l.df$abbv)
#   # 
#   # l.df <- library.df[!duplicated(paste(library.df$bioproject, library.df$rg)),]
#   # l.df <- l.df[!grepl("\\.", l.df$rg),]
#   # rep_loc <- table(l.df$abbv)
#   # 
#   # length(rep_proj[rep_proj >= 2])
#   # out.df$rep_projects <-  out.df$member_projects / rep_proj[out.df$abbv]
#   # out.df$rep_projects[rep_proj[out.df$abbv] < 3] <- NA
#   # 
#   # length(rep_loc[rep_loc >= 2])
#   # out.df$rep_loci <-  out.df$member_loci / rep_loc[out.df$abbv]
#   # # out.df$rep_loci[rep_loc[out.df$abbv] < 3] <- NA
#   # out.df$rep_loci[out.df$member_loci < 4] <- NA
#   # 
#   # out.df$replication = "None"
#   # # out.df$replication[!is.na(out.df$rep_loci)] <- 'rMIN_locus'
#   # # out.df$replication[out.df$rep_loci >= 0.33] <- 'r33_locus'
#   # out.df$replication[out.df$rep_loci >= 0.8] <- 'r80_locus'
#   # 
#   # # out.df$replication[!is.na(out.df$rep_projects)] <- 'rMIN_project'
#   # # out.df$replication[out.df$rep_projects >= 0.33] <- 'r33_project'
#   # out.df$replication[out.df$rep_projects >= 0.5] <- 'r50_project'
#   
#   f = out.df$sizing == 'typical'
#   table(out.df$abbv[f], out.df$replication[f])
#   
#   write.table(out.df, table_file, quote=F, sep='\t', row.names = F)
#   
#   return(out.df)
# }

get_metalocus.df <- function(force_overwrite=F) {
  message("loading metaloci...")
  
  table_file = file.path("00-processed_tables", "metaloci.txt")
  if (file.exists(table_file) & !force_overwrite) {
    out.df= read.delim(table_file)
    
    return(out.df)
  }
  
  
  out.df <- data.frame()
  for (abbv in unique(project.df$abbv)) {
    
    # gff_file = str_glue("../metaloci/01out-meta_gffs/{abbv}.meta.gff3")
    gff_file = str_glue("../metaloci/01out-meta_gffs_2026.02.26//{abbv}.meta.gff3")
    
    message(str_glue("{abbv}.meta.gff3"))
    
    if (!file.exists(gff_file)) {
      message("   ^^^ not found")  
      next
    }
    # stop()
    
    df <- readGFF(gff_file)
    df <- as.data.frame(df)
    
    if (nrow(df) == 0) next
    
    df$abbv <- abbv
    
    df$phase <- NULL
    df$score <- NULL
    df$source <- NULL
    df$annotation_conditions <- NULL
    df$annotation <- NULL
    
    # bin <- binom_p(abbv)
    # if ('out' %in% names(bin)) {
    #   df$bin_padj <- bin$out$padj[match(df$ID, rownames(bin$out))]
    #   df$bin_pass <- df$bin_padj <= 0.05
    #   
    # } else {
    #   df$bin_padj <- NA
    #   df$bin_pass <- NA
    #   
    # }
    # 
    
    out.df <- rbind(out.df, df)
  }
  
  out.df <- as.data.frame(lapply(out.df, type.convert, as.is=T))
  
  
  # out.df$name <- str_replace(out.df$metalocus, 'metalocus', out.df$abbv)
  
  out.df$primary <- out.df$primary == "True"
  
  
  
  
  names(out.df)[names(out.df) == "ID"] <- "metalocus"
  
  out.df$sizing <- ifelse(out.df$sizecall %in% make_dicer_sizes(19:25), 'typical', 'atypical')
  out.df$sizing[out.df$type == 'OtherRNA'] <- 'other'
  
  
  ## fourth schema for replication
  
  message('testing replication...')
  rep.df <- data.frame()
  for (abbv in unique(out.df$abbv)) {
    rep.df <- rbind(rep.df, test_metalocus_replication(abbv)$summary)
  }
  
  m <- match(out.df$metalocus, row.names(rep.df))
  # out.df$rep_project   <- rep.df$project_count[m]
  out.df$member_projects_p <- rep.df$project_p_count[m]
  out.df$rep_evidence  <- rep.df$evidence[m]
  out.df$rep_score     <- rep.df$rep_score[m]
  
  
  
  ## third schema for replication
  # out.df$replication = "none"
  # out.df$replication[out.df$bin_padj < 0.1] = "binom"
  # out.df$replication[out.df$bin_padj < 0.01 & 
  #                      !out.df$primary] = "binom"
  # 
  # f = str_detect(out.df$replication, "binom") & out.df$member_projects > 1
  # out.df$replication[f] <- paste0(out.df$replication[f], "+project")
  # 
  # f = str_detect(out.df$replication, "binom") & out.df$sizing == 'typical'
  # out.df$replication[f] <- paste0(out.df$replication[f], "+sizing")
  # 
  # 
  # table(out.df$replication)
  # 
  
  
  
  f = out.df$sizing == 'typical'
  table(out.df$rep_evidence[f], out.df$abbv[f])
  
  
  f = out.df$sizing == 'typical' & out.df$rep_score > 0
  table(out.df$rep_evidence[f], out.df$abbv[f])
  
  header = names(out.df)
  in_front = c('abbv', "metalocus", 'type', 'member_loci','member_annotations','member_projects','member_projects_p','rep_evidence','rep_score','sizing')
  header = c(in_front, setdiff(header,in_front))
  out.df <- out.df[,header]
  
  
  # f = out.df$sizing == 'typical'
  # table(out.df$abbv[f], out.df$replication[f])
  
  write.table(out.df, table_file, quote=F, sep='\t', row.names = F)
  
  return(out.df)
}


metalocus.df <- get_metalocus.df()


# make simple metaloci ----------------------------------------------------

make_simple_metaloci <- function() {
  
  passing_projects = c()

  dir.create('00-simple_metaloci')
  par(mar=c(4,4,2,2))
  par(mfrow=c(5,3))
  par(mgp=c(2,0.5,0))
  for (abbv in unique(metalocus.df$abbv)) {

    projects <- project.df[project.df$abbv == abbv & project.df$filter_str == '1111',]

    annotations = c()
    for (project in projects) {
      annotations = c(annotations, Sys.glob(str_glue("/Volumes/fungal_srnas/Annotations/{project}/tradeoff_*/loci.gff3")))
    }

    if (length(annotations) <= 5) next
    message(abbv)
    
    passing_projects = c(passing_projects, projects$project)

    gr.all <- GRanges()
    for (i in seq_along(annotations)) {
      gr = import.gff(annotations[i])
      if (length(gr) == 0) next
      gr$i <- i


      gr <- gr[!grepl("15|16|17|18", gr$type),]
      gr <- gr[!grepl("27|28|29|30|31|32|33|34|35", gr$type),]
      gr.all <- c(gr.all, gr[gr$type != "OtherRNA",])


    }

    strand(gr.all) <- "*"
    gr.all <- sort(gr.all)

    flat.gr <- reduce(gr.all)
    mcols(flat.gr)$ID <- str_c("simple_", abbv, "-", 1:length(flat.gr))
    mcols(flat.gr)$length <- width(flat.gr)
    mcols(flat.gr)$subloci_n <- countOverlaps(flat.gr, gr.all)
    plot(ecdf(width(flat.gr)), xlim=c(0,3000), ylim=c(0,1), main='locus width', xlab='nt')
    text(par()$usr[2]*0.95, par()$usr[4]*0.05, abbv, adj=c(1,0), cex=1.8, font=2)
    plot(ecdf(width(gaps(flat.gr))), xlim=c(0,3000), ylim=c(0,1), main='locus gap', xlab='nt')
    plot(ecdf(flat.gr$subloci_n), xlim=c(0,15), ylim=c(0,1), main='locus annotation count', xlab='annotations')

    export(flat.gr, str_glue('00-simple_metaloci/{abbv}.simple.gff3'), format='GFF3')
  }
  
  write.table(data.frame(passing_projects), file=str_glue('00-simple_metaloci/projects.txt'), row.names = F, col.names = F, quote=F)
}

make_simple_metaloci()
  

# loci -------------------------------------------------------------

## this first implementation is based only on a project-wide annotation, which was abandoned in favor of condition-specific annotations with metaloci
## these data will be loaded below from the metaloci analyzed files. unfortunately, this removes organisms where metaloci are not definable.

# import_annotations <- function(filter=T) {
#   m.df <- metalocus.df
#   
#   p.df <- project.df
#   
#   out.df <- data.frame()
#   
#   for (p in p.df$project) {
#     message(p)
#     
#     
#     ann_file = file.path("../+annotations", p, "tradeoff/loci.txt")
#     meta_file = str_glue("../metaloci/01out-meta_gffs/{p}.all.gff3")
#     
#     if (!file.exists(meta_file)) {message("   ^^^ metaloci file not found")}
#     if (!file.exists(ann_file)) {message("   ^^^ annotation file not found"); next}
#     
#     a.df <- read.delim(ann_file)
#     
#     if ('condition' %in% names(a.df)) a.df$condition <- NULL
#     
#     if (nrow(a.df) == 0 ) {message("   ^^^ annotation empty"); next}
#     
#     
#     a.df$project = p
#     a.df$abbv    = str_sub(p, 1, 5)
#     
#     out.df <- rbind(out.df, a.df)
#     
#   }
#   
#   
#   # if (filter) filter_loci()
#   
#   return(out.df) 
# }
# 
# filter_loci <- function(annotation.df) {
#   a.df <- annotation.df
#   s.df <- scale.df
#   s.df <- s.df[s.df$peak != "None",]
#   
#   
#   a.df$f_sizecall <- a.df$sizecall != "N"
#   table(a.df$project, a.df$f_sizecall)
#   
#   for (p in unique(a.df$project)){
#     sizes = s.df$size[s.df$project == p]
#     
#     f = a.df$project == p & a.df$f_sizecall
#     
#     
#     a.df$f_peak_size[f] <- as.numeric(str_sub(a.df$size_1n[f],2,3)) %in% sizes
#     
#   }
#   
#   table(a.df$project, a.df$f_peak_size)
#   
#   
#   a.df$f_abs_abundance <-  a.df$Reads > 100
#   
#   table(a.df$f_abs_abundance)
#   
#   a.df$f_all <- a.df$f_sizecall & a.df$f_peak_size & a.df$f_abs_abundance
#   
#   table(a.df$f_all)
#   table(p.df$project %in% a.df$project[a.df$f_all])
#   
#   write.table(a.df, "../+tables/loci.filtered.txt", quote=F, sep='\t', row.names = F)
#   
#   return(a.df)
#   
# }

# get_annotation.df <- function() {
#   
#   a.df <- 
#     import_annotations(p.df) %>% 
#     filter_loci()
#   return(a.df)
#   
# }

# annotation.df <- get_annotation.df()





## this version is based on the metaloci annotations
get_locus.df <- function(force=F) {
  
  message("loading loci...")
  
  out.df <- data.frame()
  
  
  table_file = file.path("00-processed_tables", "loci.txt")
  if (file.exists(table_file) & !force) {
    out.df= read.delim(table_file)
    
    return(out.df)
  }
  
  for (gff_file in Sys.glob("../metaloci/01out-meta_gffs/*.all.gff3")) {
  #   abbv = str_split
  # for (abbv in unique(project.df$abbv)) {
  #   message(abbv)
    # gff_file = str_glue("../metaloci/01out-meta_gffs/{abbv}.meta.gff3")
    
    # if (!file.exists(gff_file)) {message("^^^ meta ann not found"); next}
    
    message(basename(gff_file))
    
    df <- readGFF(gff_file)
    df <- as.data.frame(df)
    
    if (nrow(df) == 0) next
    
    # df$key = str_c(df$ID, df$project, df$annotation, sep='-')
    
    # df$abbv <- abbv
    # df$ml_name <- str_replace(df$metalocus, "metalocus", df$abbv)
    df$phase <- NULL
    df$score <- NULL
    df$source <- NULL
    df$annotation_conditions <- NULL
    
    out.df <- rbind(out.df, df)
  }
  
  header = names(out.df)
  in_front = c('metalocus', "ID", 'type')
  header = c(in_front, header[!header %in% in_front])
  out.df <- out.df[,header]
  
  out.df$abbv <- str_sub(out.df$metalocus, 1, 5)
  
  
  write.table(out.df, table_file, quote=F, sep='\t', row.names=F)
  
  return(out.df)
  
  
}

locus.df <- get_locus.df()

get_raw_locus.df <- function() {
  
  annotation_files <- Sys.glob("../+annotations/*/tradeoff_*/loci.txt")
  out.df = data.frame()
  for (file in annotation_files) {
    s = str_split(file, "/")[[1]]
    project = s[3]
    
    if (!project %in% project.df$project[project.df$f_pass]) next
    annotation = str_split(s[4], "_")[[1]][2]
    
    if (str_length(annotation) > 2) next
    
    message(file)
    abbv = str_sub(project, 1, 5)
    
    l.df <- read.delim(file)
    if (nrow(l.df) == 0) next
    
    l.df <- cbind(abbv=abbv, project=project,annotation=annotation, l.df)
    
    out.df <- rbind(out.df, l.df)
  }
  return(out.df)
}

raw_locus.df <- get_raw_locus.df()




# hairpins ----------------------------------------------------------------

get_hairpin.df <- function(force=F) {
  message("loading hairpins...")
  
  table_file = file.path("00-processed_tables", "hairpins.txt")
  if (file.exists(table_file) & !force) {
    hp.df= read.delim(table_file)
    
    table(hp.df$abbv, hp.df$hp_cat)
    return(hp.df)
  }
  
  
  hp.df <- data.frame()
  
  for (project in project.df$project) {
    for (cond in unlist(str_split(project.df$conditions[project.df$project == project], ","))) {
      
      message(str_glue("{project}.{cond}"))
      
      hp_file = file.path("../+annotations", project, "hairpin", cond, "hairpins.txt")
      
      
      if (!file.exists(hp_file)) {message("^^^ hp file not found"); next}
      
      df <- read.delim(hp_file)
      if (nrow(df) == 0) {message("^^^ hp file empty"); next}
      
      df$abbv    <- str_sub(project, 1,5)
      df$project <- project
      df$cond    <- cond
      
      table(df$ruling)
      
      # passing_rulings = c('x x xx xx x -',
      #                     'x x xx xx x x')
      # 
      # df <- df[df$ruling %in% passing_rulings,]
      
      df$pass_sum <- str_count(df$ruling, "x")
      df <- df[df$pass_sum > 4,]
      
      
      hp.df = rbind(hp.df, df)
      
    }
    
  }
  
  boolean_columns <- c('stranded','no_mas_structures', 'no_star_structures', 'star_found')
  for (c in boolean_columns) {
    hp.df[[c]] <- as.logical(hp.df[[c]])
  }
  
  
  numeric_columns <- c('mfe_per_nt')
  for (c in numeric_columns) {
    hp.df[[c]] <- as.numeric(hp.df[[c]])
  }
  
  # stranded
  # ┋ mfe_per_nt
  # ┋ ┋
  # ┋ ┋ mismatches_total
  # ┋ ┋ ┋mismatches_asymm
  # ┋ ┋ ┋┋largest_loop
  # ┋ ┋ ┋┋┋ 
  # ┋ ┋ ┋┋┋ mas_duplex_structure
  # ┋ ┋ ┋┋┋ ┋star_duplex_structure
  # ┋ ┋ ┋┋┋ ┋┋ 
  # ┋ ┋ ┋┋┋ ┋┋ constellation precision
  # ┋ ┋ ┋┋┋ ┋┋ ┋tight precision
  # ┋ ┋ ┋┋┋ ┋┋ ┋┋ 
  # ┋ ┋ ┋┋┋ ┋┋ ┋┋ star_found
  # ┋ ┋ ┋┋┋ ┋┋ ┋┋ ┋star_above_background
  # ┋ ┋ ┋┋┋ ┋┋ ┋┋ ┋┋
  # v v vvv vv vv vv
  
  # x x xxx xx xx xx
  # 0000000001111111
  # 1 3 567 90 23 56
  
  
  hp.df$hp_cat <- "(undescribed)"
  
  
  hp.df$hp_cat[str_detect(str_sub(hp.df$ruling, 12,14), '-')] <- 'imprecise'
  hp.df$hp_cat[str_detect(str_sub(hp.df$ruling, 16,17), '-')] <- 'imprecise'
  hp.df$hp_cat[str_detect(str_sub(hp.df$ruling, 5,8), '-')]   <- 'bad_duplex'
  hp.df$hp_cat[str_detect(str_sub(hp.df$ruling, 3,4), '-')]   <- 'bad_hairpin'
  hp.df$hp_cat[str_detect(str_sub(hp.df$ruling, 9,11), '-')]  <- 'bad_hairpin'
  hp.df$hp_cat[str_detect(str_sub(hp.df$ruling, 1,2), '-')]   <- 'unstranded'
  
  
  hp.df$hp_cat[hp.df$ruling == 'x x xxx xx xx xx'] <- "miRNA"
  hp.df$hp_cat[hp.df$ruling == 'x x xxx xx xx -x'] <- "near_miRNA"
  hp.df$hp_cat[hp.df$ruling == 'x x xx- xx xx xx' & hp.df$largest_loop <= 6] <- "near_miRNA"
  hp.df$hp_cat[hp.df$ruling == 'x x -xx xx xx xx' & hp.df$mismatches_total <= 8] <- "near_miRNA"
  hp.df$hp_cat[hp.df$ruling == 'x x x-x xx xx xx' & hp.df$mismatches_asymm <= 5] <- "near_miRNA"
  
  
  
  # hp.df[hp.df$hp_cat == '(undescribed)', ]
  
  table(hp.df$abbv, hp.df$hp_cat)
  
  
  
  hp.df$source_locus   <- str_c(hp.df$name, hp.df$project, hp.df$cond, sep='-')
  hp.df$metalocus      <- locus.df$metalocus[match(hp.df$source_locus, locus.df$ID)]
  hp.df$type           <- metalocus.df$type[match(hp.df$metalocus, metalocus.df$metalocus)]
  hp.df$context        <- metalocus.df$context[match(hp.df$metalocus, metalocus.df$metalocus)]
  hp.df$simple_context <- metalocus.df$simple_context[match(hp.df$metalocus, metalocus.df$metalocus)]
  hp.df$rpm            <- metalocus.df$rpm[match(hp.df$metalocus, metalocus.df$metalocus)]
  
  hp.df$hp_cat[!hp.df$type %in% str_c("RNA_", make_dicer_sizes(19:25))] <- "(atypical-sized-sRNA)"
  hp.df$hp_cat[hp.df$type == "OtherRNA"] <- "(non-sRNA)"
  
  table(hp.df$hp_cat, ml=!is.na(hp.df$metalocus))
  
  hp.df <- hp.df[!is.na(hp.df$metalocus),]
  
  hp.df$star_offset_left  <- as.numeric(hp.df$star_offset_left)
  hp.df$star_offset_right <- as.numeric(hp.df$star_offset_right)
  
  hp.df$hp_cat[hp.df$simple_context %in% c('tRNA', 'rRNA', 'spliceosomal')] <- "(structural RNA)"
  # hp.df <- hp.df[!hp.df$simple_context %in% c('tRNA', 'rRNA', 'spliceosomal'),]
  
  
  hp.df$p_struc_positions <- 1 - (str_count(hp.df$fold, '\\.') / str_length(hp.df$fold))
  
  hp.df$fold <- NULL
  hp.df$seq  <- NULL
  
  
  hp.df$sub <- 'native'
  hp.df$sub[str_detect(hp.df$sub_name, 'side')] <- 'side'
  hp.df$sub[str_detect(hp.df$sub_name, 'sub')] <- 'sub'
  
  table(hp.df$sub, hp.df$hp_cat)
  
  hp.df$replication <- metalocus.df$replication[match(hp.df$metalocus, metalocus.df$metalocus)]
  
  
  header = names(hp.df)
  in_front = c('metalocus', "source_locus", 'type', 'ruling', 'hp_cat', 'pass_sum', 'sub')
  header = c(in_front, header[!header %in% in_front])
  hp.df <- hp.df[,header]
  
  hp.df$name <- NULL
  
  
  hp.df[hp.df$source_locus == 'locus_1408-Bocin.PRJNA730711-E',]
  
  write.table(hp.df, table_file, quote=F, sep='\t', row.names=F)
  
  
  return(hp.df)
}


hairpin.df <- get_hairpin.df()




# context -----------------------------------------------------------------

# get_context.df_old <- function(force=F) {
#   message("loading context...")
#   
#   
#   processed_file = file.path("00-processed_tables", "context.txt")
#   if (file.exists(processed_file) & !force) {
#     context.df= read.delim(processed_file)
#     
#     return(context.df)
#   }
#   m.df <- metalocus.df
#   
#   context.df <- data.frame()
#   for (abbv in unique(metadata.df$abbv)) {
#     message(abbv)
#     
#     context_file = str_glue("../context/01out-intersections/{abbv}.context.txt")
#     if (!file.exists(context_file)) {
#       message('^^^ context file not found')
#       
#       next
#     }
#     
#     df <- read.delim(context_file)
#     
#     df = cbind(abbv, df)
#     context.df <- rbind(context.df, df)
#     
#   }
#   
#   head(context.df)
#   
#   table(context.df$relationship)
#   table(context.df$type)
#   table(context.df$stranding)
#   
#   context.df$context[context.df$relationship == 'intergenic'] <- 'intergenic'
#   f = grepl("near", context.df$relationship)
#   context.df$context[f] <- str_c(str_sub(context.df$relationship[f], 6, -1), "_", context.df$type[f], "_", context.df$stranding[f])
#   f = context.df$relationship == 'intersect'
#   context.df$context[f] <- str_c(context.df$type[f], "_", context.df$stranding[f])
#   
#   context.df$simplified[context.df$relationship == 'intergenic'] <- 'intergenic'
#   f = grepl("near", context.df$relationship)
#   context.df$simplified[f] <- str_c('near-', context.df$type[f])
#   f = context.df$relationship == 'intersect'
#   context.df$simplified[f] <- str_c(context.df$type[f])
#   
#   paste_not_na <- function(x) {
#     x = x[!is.na(x)]
#     paste(x, collapse='-')
#   }
#   
#   # context.df$context <- apply(context.df[, c('relationship','type','stranding')], 1, paste_not_na)
#     
#   # 
#   # names(context.df)[names(context.df) == 'type'] <- 'closest_type'
#   # names(context.df)[names(context.df) == 'distance'] <- 'closest_dist'
#   # names(context.df)[names(context.df) == 'category'] <- 'context'
#   # 
#   # 
#   # context.df$s_type <- metalocus.df$type[match(context.df$metalocus, m.df$metalocus)]
#   
#   
#   # context.df$simple_context <- str_replace(context.df$context, "sense_|antisense_|unstranded_|", "")
#   
#   write.table(context.df, processed_file, quote=F, row.names = F, sep='\t')
#   
#   return(context.df)
# }

# context.df <- get_context.df()


get_context.df <- function(force=F) {
  
  message("loading context...")
  
  processed_file = file.path("00-processed_tables", "context.txt")
  if (file.exists(processed_file) & !force) {
    context.df= read.delim(processed_file)
    
    return(context.df)
  }
  
  context.df <- data.frame()
  
  for (abbv in unique(metalocus.df$abbv)) {
  # for (abbv in c('Asapi')) {
      message(abbv)
      
      m.df <- metalocus.df[metalocus.df$abbv == abbv,]
      
      m.gr <- GRanges(paste0(m.df$seqid, ":", m.df$start, "-", m.df$end), strand=m.df$strand)
      
      dirs <- get_dir_paths()
      
      s.df = species.df[species.df$abbv == abbv,]
      ncbi_gff = str_glue("{dirs$gen}{abbv}.{s.df$accession}_{s.df$assembly_name}_genomic.gff3")
      rfam_gff = str_glue("../rfam/02out-rfam_gffs/{abbv}.rfam.gff3")
      te_gff   = str_glue("../TE_annotations/eg_out/{abbv}_EarlGrey/{abbv}_summaryFiles/{abbv}.filteredRepeats.gff")
    
      
      if (!file.exists(ncbi_gff)) { paste("ncbi_gff not found:", ncbi_gff); next }
      if (!file.exists(rfam_gff)) { paste("rfam_gff not found:", rfam_gff); next }
      if (!file.exists(te_gff))   { paste("te_gff not found:", te_gff);     next }
      
      
      ncbi.gr <- import.gff(ncbi_gff, 
                            feature.type	=c('mRNA'))
      rfam.gr <- import.gff(rfam_gff)
      te.gr   <- import.gff(te_gff)
      te.gr <- te.gr[te.gr$type != 'Simple_repeat',]
      
      if (!abbv %in% lookup.df$abbv) {
        # next
        message("warning: abbv not found in chr lookup table...")
      }
      
      ## fixing problems with genbank/refseq chromosome names
      
      fix_seqlevels <- function(g) {
        
        if (any(seqlevels(m.gr) %in% lookup.df$genbankAccession)) {
          target='genbankAccession'
          source='refseqAccession'
          
        } else if (any(seqlevels(m.gr) %in% lookup.df$refseqAccession)) {
          target='refseqAccession'
          source='genbankAccession'
          
        } else {
          return (NULL)
          stop("Problem with seqlevels... locus does not appear to match any genomic reference names")
          
        }
        
        if (length(g) == 0) return(g)
        
        if (any(seqlevels(g) %in% lookup.df[[source]])) {
          seqlevels(g) <- lookup.df[[target]][match(seqlevels(g), lookup.df[[source]])]
          
        }
        
        return(g)
      }
      
      
      
      ncbi.gr <- fix_seqlevels(ncbi.gr)
      te.gr   <- fix_seqlevels(te.gr)
      rfam.gr <- fix_seqlevels(rfam.gr)
      
      if (is.null(ncbi.gr)) next
      
      
      
      # print(table(ncbi.gr$type))
      # print(table(te.gr$type))
      # print(table(rfam.gr$type))
      
      
      c.df <- data.frame()
      
      for (subject_name in c('ncbi','te','rfam')) {
        message(paste0("  ",subject_name))
        
        
        subject.gr = switch(subject_name,
                          ncbi = ncbi.gr,
                          te   = te.gr,
                          rfam = rfam.gr)
        
        if (length(subject.gr) == 0) next
        
        
        int.df = as.data.frame(findOverlaps(m.gr, subject.gr, ignore.strand=T))
        names(int.df) <- c('mi','neighbor')
        int.df$relationship <- "intersect"
        int.df$strand <- as.vector(strand(m.gr))[int.df$mi]
        int.df$ostrand <- as.vector(strand(subject.gr))[int.df$neighbor]
        int.df$distance = 0
        
        precedes   = precede(m.gr, subject.gr, ignore.strand=T)
        follows    = follow(m.gr, subject.gr, ignore.strand=T)
        
        near.df <- data.frame(mi=rep(1:length(m.gr),2),
                              neighbor=c(precedes, follows), 
                              orientation = rep(c('left','right'),each=length(m.gr)),
                              strand = strand(m.gr))
        
        
        near.df$relationship[near.df$strand == '*'] <- 'unstranded'
        f = (near.df$orientation == 'left' & near.df$strand == "+") | 
          (near.df$orientation == 'right' & near.df$strand == "-")
        near.df$relationship[f] <- 'upstream'
        
        f = (near.df$orientation == 'left' & near.df$strand == "-") | 
          (near.df$orientation == 'right' & near.df$strand == "+")
        near.df$relationship[f] <- 'downstream'
        
        f = !is.na(near.df$neighbor)
        near.df <- near.df[f,]
        
        near.df$distance <- distance(m.gr[near.df$mi], subject.gr[near.df$neighbor], ignore.strand=T)
        near.df$ostrand <- as.vector(strand(subject.gr))[near.df$neighbor]
        
        
        int.df <- rbind(int.df, near.df[,names(int.df)])
        
        
        f = int.df$strand == int.df$ostrand
        int.df$stranding[f] <- 'sense'
        
        f = int.df$strand != int.df$ostrand
        int.df$stranding[f] <- 'antisense'
        
        f = int.df$strand == '*' | int.df$ostrand == '*'
        int.df$stranding[f] <- 'unstranded'
        
        int.df$metalocus <- m.df$metalocus[int.df$mi]
        int.df$stype <- m.df$type[int.df$mi]
        
        int.df$other <- subject.gr$ID[int.df$neighbor]
        int.df$otype <- subject.gr$type[int.df$neighbor]
        int.df$osource <- subject_name
        
        int.df$abbv <- abbv
        
        int.df$metalocus <- m.df$metalocus[int.df$mi]
        
        int.df <- int.df[,c('abbv','metalocus','stype','other','otype','osource', 'ostrand','relationship','stranding', 'distance')]
        
        int.df$stranding[int.df$distance > 2000] <- 'trans'
        
        c.df <- rbind(c.df, int.df)
      }
      
      c.df <- c.df[order(as.numeric(str_sub(c.df$metalocus, 7,-1))),]
      
      context.df <- rbind(context.df, c.df)
      
      
    
  }
  
  
  write.table(context.df, processed_file, quote=F, row.names = F, sep='\t')
  
  return(context.df)
  
}


context.df <- get_context.df(F)


add_context_to_metaloci <- function() {
  
  # c.df <- context.df[context.df$metalocus %in% metalocus.df$metalocus[metalocus.df$replication == 'binom+project+sizing'],]
  # c.df <- c.df[c.df$distance < 500,]
  # c.df <- c.df[c.df$stype != 'OtherRNA',]
  # 
  # c.df <- dcast(c.df, abbv + metalocus + stype ~ osource)
  # c.df
  
  
  a.df <- context.df
  a.df <- a.df[a.df$distance < 500,]
  a.df$agg_type <- as.vector(a.df$otype)
  
  a.df$agg_type[str_detect(a.df$agg_type, "^DNA")] <- "TE/DNA"
  a.df$agg_type[str_detect(a.df$agg_type, "^LINE")] <- "TE/LINE"
  a.df$agg_type[str_detect(a.df$agg_type, "^SINE")] <- "TE/SINE"
  a.df$agg_type[str_detect(a.df$agg_type, "^LTR")] <- "TE/LTR"
  a.df$agg_type[str_detect(a.df$agg_type, "^PLE")] <- "TE/PLE"
  a.df$agg_type[str_detect(a.df$agg_type, "^RC")] <- "TE/RC"
  a.df$agg_type[a.df$agg_type %in% c("Satellite", "Unknown",'Other')] <- "TE/Repeat"
  
  f = a.df$agg_type %in% c("rRNA",'snoRNA','snRNA','spliceosomal','tRNA','other')
  a.df$agg_type[f] <- paste0("Rfam/", a.df$agg_type[f])
  
  f = a.df$agg_type == 'mRNA'
  a.df$agg_type[f] <- paste0("ncbi/", a.df$agg_type[f])

  
  table(a.df$agg_type)
  
  # m = match(a.df$osource,c("rfam",'te','ncbi'))
  m = match(a.df$agg_type,
            c("Rfam/rRNA", 'Rfam/tRNA','Rfam/snRNA','Rfam/spliceosomal','Rfam/snoRNA','Rfam/other',
              'TE/LTR','TE/RC','TE/LINE','TE/DNA','TE/PLE','TE/SINE','TE/Repeat',
              'ncbi/mRNA'))
  a.df <- a.df[order(m),]
  
  take_first <- function(x) {
    x[1]
  }
  
  
  count_agg <- function(x) {
    x = str_split_fixed(x, "/",2)[,1]
    
    out = ''
    for (xx in unique(x)) {
      out = paste0(out, sum(x == xx),'-',xx, ';')
    }
    out
  }
  
  out.df <- a.df[!duplicated(a.df$metalocus),]
  out.df$context <- out.df$agg_type
  # out.df$stranding <- aa.df$stranding[match()]
  
  # out.df <- dcast(a.df, abbv + metalocus ~ 'context', value.var='agg_type', fun.aggregate = take_first)
  out.df$context_all <- dcast(a.df, abbv + metalocus ~ 'context_all', value.var='agg_type', fun.aggregate = count_agg)$context_all
  
  
  out.df <- out.df[order(as.numeric(str_sub(out.df$metalocus, 7,-1))),]
  out.df <- out.df[order(out.df$abbv),]
  
  metalocus.df$context <- out.df$context[match(metalocus.df$metalocus, out.df$metalocus)]
  metalocus.df$context_stranding <- out.df$stranding[match(metalocus.df$metalocus, out.df$metalocus)]
  metalocus.df$context_all <- out.df$context_all[match(metalocus.df$metalocus, out.df$metalocus)]
  
  metalocus.df$context[is.na(metalocus.df$context)] <- 'intergenic'
  metalocus.df$context_all[is.na(metalocus.df$context_all)] <- 'intergenic'
  
  return(metalocus.df)
}

metalocus.df <- add_context_to_metaloci()


# conservation ------------------------------------------------------------


get_conservation_df <- function(force=F) {
  
  message("loading conservation data...")
  
  
  processed_file = file.path("00-processed_tables", "conservation.txt")
  if (file.exists(processed_file) & !force) {
    conservation.df= read.delim(processed_file)
    
    return(conservation.df)
  }
  
  
  full.df <- read.delim("../old_conservation/01out-blast_output.txt")
  full.df$query_abbv = str_sub(full.df$qseqid, 1,5)
  
  
  out.df <- data.frame()
  for (abbv in unique(full.df$target_abbv)) {
    message(abbv)
    c.df <- full.df[full.df$target_abbv == abbv,]
    c.df <- c.df[c.df$target_abbv != c.df$query_abbv,]
    c.df <- c.df[order(c.df$evalue),]
    c.df <- c.df[!duplicated(c.df$qseqid),]
    
    c.df$corr_start <- apply(c.df[,c('sstart','send')], 1, min)
    c.df$corr_end <- apply(c.df[,c('sstart','send')], 1, max)
    
    
    gff_file = str_glue("../metaloci/01out-meta_gffs/{abbv}.meta.gff3")
    if (!file.exists(gff_file)) next
    
    target_gff <- import.gff(gff_file)
    c_gff <- GRanges(c.df$sseqid, IRanges(c.df$corr_start, c.df$corr_end))
    
    o = findOverlaps(c_gff, target_gff, select='first')
    
    c.df$subject_ml <- target_gff$ID[o]
    
    out.df <- rbind(out.df, c.df)
    
  }
  
  
  out.df <- out.df[order(out.df$query_abbv),]
  out.df$tlocus <- paste0(out.df$sseqid, ":", out.df$corr_start, "-", out.df$corr_end)
  
  out.df <- out.df[,c('query_abbv', 'qseqid', 'target_abbv','subject_ml', 'tlocus', 'length','mismatch', 'gapopen','evalue','bitscore')]
  
  names(out.df) <- c('q.abbv','q.metalocus','t.abbv','t.metalocus','t.locus','length','mismatch', 'gapopen','evalue','bitscore')
  
  out.df$q.replication <- metalocus.df$replication[match(out.df$q.metalocus, metalocus.df$metalocus)]
  out.df$t.replication <- metalocus.df$replication[match(out.df$t.metalocus, metalocus.df$metalocus)]
  
  out.df$q.sizing <- metalocus.df$sizing[match(out.df$q.metalocus, metalocus.df$metalocus)]
  out.df$t.sizing <- metalocus.df$sizing[match(out.df$t.metalocus, metalocus.df$metalocus)]
  
  out.df <- out.df[complete.cases(out.df),]
  
  table(out.df$q.sizing, out.df$t.sizing)
  
  # out.df[out.df$q.sizing == 'typical' & out.df$t.sizing == 'typical',]
  
  
  
  write.table(out.df, processed_file, quote=F, row.names = F, sep='\t')
  
  return(out.df)
}

conservation.df <- get_conservation_df()


# get_conservation_df_old <- function() {
# 
#   conservation.df <- data.frame()
#   gr.ls = list()
#   for (a in unique(metalocus.df$abbv)) {
#     gr <- readGFFAsGRanges(file.path("../metaloci/01out-meta_gffs", paste(a, ".meta.gff3", sep='')))
#     # gr$name <- str_replace(gr$ID, "metalocus", a)
#     gr.ls[[a]] <- gr
#   }
# 
#   for (a in unique(metalocus.df$abbv)) {
# 
#     for (b in unique(metalocus.df$abbv)) {
# 
#       if (a == b) next
# 
# 
#       message(paste(a, "x", b))
# 
#       # a.gr <- gr.ls[[a]]
#       # b.gr <- gr.ls[[b]]
#       intersection_file = file.path("../conservation/02out-gffs", paste(a, '_to_', b, '.gff3', sep=''))
# 
#       if (!file.exists(intersection_file)) {next}
# 
#       i.gr <- readGFFAsGRanges(intersection_file)
# 
#       i.df <- as.data.frame(findOverlaps(i.gr, gr.ls[[b]]))
# 
#       i.df$a = i.gr$ID[i.df$queryHits]
# 
#       f = match(i.df$a, gr.ls[[a]]$ID)
# 
#       i.df$a_type     <- gr.ls[[a]]$type[f]
#       i.df$a          <- gr.ls[[a]]$name[f]
#       i.df$a_contig   <- as.data.frame(gr.ls[[a]])$seqnames[f]
#       i.df$a_start    <- gr.ls[[a]]@ranges@start[f]
#       i.df$a_length   <- gr.ls[[a]]@ranges@width[f]
#       i.df$a_members  <- gr.ls[[a]]$member_loci[f]
#       i.df$a_projects <- gr.ls[[a]]$member_projects[f]
# 
# 
#       i.df$b = gr.ls[[b]]$ID[i.df$subjectHits]
# 
#       f = match(i.df$b, gr.ls[[b]]$ID)
# 
#       i.df$b_type     <- gr.ls[[b]]$type[f]
#       i.df$b          <- gr.ls[[b]]$name[f]
#       i.df$b_contig   <- as.data.frame(gr.ls[[b]])$seqnames[f]
#       i.df$b_start    <- gr.ls[[b]]@ranges@start[f]
#       i.df$b_length   <- gr.ls[[b]]@ranges@width[f]
#       i.df$b_members  <- gr.ls[[b]]$member_loci[f]
#       i.df$b_projects <- gr.ls[[b]]$member_projects[f]
# 
# 
#       i.df$pident    <- i.gr$pident[i.df$queryHits]
#       i.df$evalue    <- i.gr$evalue[i.df$queryHits]
# 
# 
#       if (any(is.na(i.df$a_type))) stop()
# 
#       conservation.df <- rbind(conservation.df, i.df)
# 
#     }
#   }
# 
#   for (c in c('evalue','pident','a_members','b_members','a_length','b_length')) {
#     conservation.df[[c]] <- as.numeric(conservation.df[[c]])
#   }
# 
#   return(conservation.df)
# }


# conservation_clusters ---------------------------------------------------

build_edge_clusters <- function(e.df) {
  
  edge.df <- conservation.df
  head(edge.df)
  edge.df <- edge.df[str_detect(edge.df$q.replication, "binom") &
                       str_detect(edge.df$t.replication, "binom"), ]
  edge.df <- edge.df[edge.df$q.sizing == 'typical' &
                       edge.df$t.sizing == 'typical', ]
  
  edge.df <- edge.df[,c('q.metalocus', 't.metalocus', 'length','evalue')]
  names(edge.df)[1:2] <- c('source','target')
  
  sort_paste <- function(x) {
    paste(sort(x), collapse=' ')
  }
  
  edge.df$sorted <- apply(edge.df[,c('source','target')], 1, sort_paste)
  edge.df$support <- 'uni'
  edge.df$support[duplicated(edge.df$sorted)] <- 'bi'
  
  
  e.df <- edge.df
  head(e.df)
  dim(e.df)
  
  n.df <- data.frame(metalocus=unique(e.df$source, e.df$target))
  n.df$abbv <- str_sub(n.df$metalocus, 1, 5)
  
  e.df$cluster = NA
  e.df$clustering_attempted = F
  cluster_i = 0
  
  
  while (sum(!e.df$clustering_attempted) > 0) {
    i = which(!e.df$clustering_attempted)[1]
    
    if (is.na(e.df$cluster[i])) {
      cluster_i = cluster_i + 1
      e.df$cluster[i] <- str_glue("Cl_{cluster_i}")
    }
    
    f = e.df$source == e.df$source[i] | e.df$target == e.df$source[i]
    e.df$cluster[f] <- e.df$cluster[i]
    
    f = e.df$source == e.df$target[i] | e.df$target == e.df$target[i]
    e.df$cluster[f] <- e.df$cluster[i]
    
    n.df$cluster[n.df$metalocus == e.df$target[i]] <- e.df$cluster[i]
    n.df$cluster[n.df$metalocus == e.df$source[i]] <- e.df$cluster[i]
    
    e.df$clustering_attempted[i] = T
    
    # reordering 
    e.df <- e.df[order(is.na(e.df$cluster), e.df$clustering_attempted),]
    head(e.df,80)  
    table(e.df$cluster)
  }
  
  e.df$clustering_attempted <- NULL
  
  tab <- as.data.frame(rbind(table(n.df$cluster, n.df$abbv)))
  tab$sum <- rowSums(tab)
  tab <- tab[order(-tab$sum),]
  
  list(edges=e.df, nodes=n.df, tab=tab)
  
}

cluster.ls <- build_edge_clusters()

# merging commands ----------------------------------------------------------------

# metalocus.df <- get_rulings(metalocus.df)
# metalocus.df$hp_cat <- hairpin.df$hp_cat[match(metalocus.df$rep_locus, hairpin.df$key)]
# metalocus.df$hp_cat[is.na(metalocus.df$hp_cat)] <- "(undescribed)"
