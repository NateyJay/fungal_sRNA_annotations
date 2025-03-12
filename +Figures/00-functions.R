


get_meta.df <- function() {
  meta_file = file.path("/Volumes/YASMA/master_table.xlsx")
  # meta_file = file.path(path)
  
  
  
  
  if (file.exists(meta_file)) {
    meta.df <- readxl::read_excel(meta_file, skip=1)
    
  } else {
    message("/Volumes/YASMA/master_table.xlsx not found!")
    message("  -> working from backup file")
    # scp njohnson@darwin:/home2/njohnson/fungi_annotations/batch_scripts/master_table.xlsx ./backup.xlsx
    meta.df <- readxl::read_excel("backup.xlsx", skip=1)
    
  }
  
  meta.df <- as.data.frame(meta.df)
  meta.df <- meta.df[!is.na(meta.df$`project-rg`),]
  
  meta.df$abbv <- str_c(str_sub(meta.df$fungi_species, 1,2),
                        str_sub(str_split_fixed(meta.df$fungi_species, " ", 2)[,2], 1,3),
                        sep='')
  
  # unique(meta.df$`Replicate group`)
  
  meta.df$has_dicer_mutant <- str_detect(meta.df$`Replicate group`, "\\.")
  head(meta.df)
  
  return(meta.df)
}


get_project.df <- function(filter = T, annotations_dir = "../+annotations") {
  m.df <- meta.df
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
# project.df <- get_project.df()



get_library.df <- function() {
  m.df <- meta.df
  
  head(m.df)
  names(m.df)
  
  m.df <- m.df[,c('fungi_abbv','bioproject', 'Replicate group','srr')]  
  names(m.df) <- c('abbv','bioproject', 'rg','srr')
  
  m.df[duplicated(m.df$srr),]
  
  rownames(m.df) <- m.df$srr
  
  
  return(m.df)
}

# library.df <- get_library.df()


get_peak.df <- function() {
  p.df <- project.df
  
  out.df <- data.frame()
  
  for (project in p.df$project) {
    message(project)
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


get_peak_scales <- function(filter=F) {
  p.df <- project.df
  
  out.df <- data.frame()
  
  for (project in p.df$project) {
    message(project)
    peak_file = file.path("../+annotations", project, "align/alignment.peak_table.txt")
    
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
    
    out.df <- rbind(out.df, df)
    
  }
  
  out.df$abbv <- str_sub(out.df$project, 1, 5)
  
  return(out.df)
}
# scale.df <- get_peak_scales(filter=F)


get_profile.df <- function() {
  p.df <- project.df
  
  out.df <- data.frame
  
  sizes  = 15:50
  csizes = as.character(sizes)
  
  out.df <- data.frame()
  
  for (project in p.df$project) {
    message(project)
    profile_file = file.path("../+annotations", project, "align/alignment.depth.txt")
    
    if (!file.exists(profile_file)) {
      message("  ^^^ profile_file not found")
      next
    }
    
    df <- read.delim(profile_file)
    
    df <- dcast(df, rg ~ length, fun.aggregate = sum, value.var='abundance')
    
    for (s in csizes) {
      if (! s %in% names(df)) {
        df[[s]] <- rep(NA, nrow(df))
      }
    }
    
    df$project = project
    names(df)[1] <- 'srr'
    df$rg <- library.df[df$srr, 'rg']
    df <- df[,c('project','srr', 'rg', csizes)]
    
    df[,csizes] <- df[,csizes] / rowSums(df[,csizes], na.rm=T)
    
    out.df <- rbind(out.df, df)
    
    
  }
  
  out.df$abbv <- str_sub(out.df$project, 1, 5)
  
  return(out.df)
  
}
# profile.df <- get_profile.df()

filter_projects <- function(p.df) {
  
  # p.df <- project.df
  
  rownames(p.df) <- p.df$project
  
  p.df <- p.df[complete.cases(p.df),]
  p.df$total_aligned <- rowSums(p.df[,c('umap', 'mmap_wg', 'mmap_nw')])
  p.df$alignment_rate <- p.df$total_aligned / rowSums(p.df[,c('umap', 'mmap_wg', 'mmap_nw', 'xmap_nw', 'xmap_ma', 'xmap_nv')])
  
  # absolute alignment >= 1M reads
  p.df$f_abs_alignment <- p.df$total_aligned >= 1000000
  table(p.df$f_abs_alignment)
  
  # relative alignment >= 0.05
  p.df$f_rel_alignment <- p.df$alignment_rate >= 0.05
  table(p.df$f_rel_alignment)
  
  table(`abs`=p.df$f_abs_alignment, `rel`=p.df$f_rel_alignment)
  
  k.df <- get_peak_scales()
  k.df <- k.df[k.df$peak != "None", c('project','size','peak')]
  
  
  # has a peak
  p.df$f_has_peak <- p.df$project %in% k.df$project
  table(p.df$f_has_peak)
  
  k.df <- k.df[k.df$size < 18 | k.df$size > 32,]
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

filter_loci <- function(annotation.df) {
  a.df <- annotation.df
  s.df <- scale.df
  s.df <- s.df[s.df$peak != "None",]
  
  
  a.df$f_sizecall <- a.df$sizecall != "N"
  table(a.df$project, a.df$f_sizecall)
  
  for (p in unique(a.df$project)){
    sizes = s.df$size[s.df$project == p]
    
    f = a.df$project == p & a.df$f_sizecall
    
    
    a.df$f_peak_size[f] <- as.numeric(str_sub(a.df$size_1n[f],2,3)) %in% sizes
    
  }
  
  table(a.df$project, a.df$f_peak_size)
  
  
  a.df$f_abs_abundance <-  a.df$Reads > 100
  
  table(a.df$f_abs_abundance)
  
  a.df$f_all <- a.df$f_sizecall & a.df$f_peak_size & a.df$f_abs_abundance
  
  table(a.df$f_all)
  table(p.df$project %in% a.df$project[a.df$f_all])
  
  write.table(a.df, "../+tables/loci.filtered.txt", quote=F, sep='\t', row.names = F)
  
  return(a.df)
  
}

get_annotation.df <- function(filter=T) {
  
  p.df <- project.df
  
  out.df <- data.frame()
  
  for (p in p.df$project) {
    message(p)
    
    ann_file = file.path("../+annotations", p, "tradeoff/loci.txt")
    
    if (!file.exists(ann_file)) {message("   ^^^ annotation file not found"); next}
    
    a.df <- read.delim(ann_file)
    
    if ('condition' %in% names(a.df)) a.df$condition <- NULL
    
    if (nrow(a.df) == 0 ) {message("   ^^^ annotation empty"); next}
    
    
    a.df$project = p
    a.df$abbv    = str_sub(p, 1, 5)
    
    out.df <- rbind(out.df, a.df)
    
  }
  
  
  # if (filter) filter_loci()
  
  return(out.df) 
}

# annotation.df <- get_annotation.df()




# 
# annotation.df <- filter_loci()


get_metaloci.df <- function() {
  out.df <- data.frame()
  
  # for (gff_file in Sys.glob("../metaloci/*.meta.gff3")) {
  #   abbv = str_split
  for (abbv in unique(project.df$abbv)) {
    message(abbv)

    gff_file = str_glue("../metaloci/{abbv}.meta.gff3")

    if (!file.exists(gff_file)) {message("^^^ meta ann not found"); next}
    
    df <- readGFF(gff_file)
    df <- as.data.frame(df)
    
    if (nrow(df) == 0) next
    
    df$length <- df$end - df$start
    df$abbv <- abbv
    df$name <- str_replace(df$ID, "metalocus", abbv)
    
    
    out.df <- rbind(out.df, df)
  }
  
  for (c in c('fracTop', 'rpm', 'depth', 'member_loci', 'member_projects')) {
    out.df[[c]] <- as.numeric(out.df[[c]])
  }
  
  return(out.df)
}

get_ml_lookup <- function() {
  out.df <- data.frame()
  
  # for (gff_file in Sys.glob("../metaloci/*.meta.gff3")) {
  #   abbv = str_split
  for (abbv in unique(project.df$abbv)) {
    message(abbv)
    
    gff_file = str_glue("../metaloci/{abbv}.gff3")
    
    if (!file.exists(gff_file)) {message("^^^ meta ann not found"); next}
    
    df <- readGFF(gff_file)
    df <- as.data.frame(df)
    
    if (nrow(df) == 0) next
    
    df$key = str_c(df$ID, df$project, df$annotation, sep='-')
    
    df$abbv <- abbv
    df$ml_name <- str_replace(df$metalocus, "metalocus", df$abbv)
    
    out.df <- rbind(out.df, df)
  }
  
  
  return(out.df)
    
  
}

get_conservation_df <- function() {
  
  conservation.df <- data.frame()
  gr.ls = list()
  for (a in unique(metaloci.df$abbv)) {
    gr <- readGFFAsGRanges(file.path("../metaloci", paste(a, ".meta.gff3", sep='')))
    gr$name <- str_replace(gr$ID, "metalocus", a)
    gr.ls[[a]] <- gr
  }
  
  for (a in unique(metaloci.df$abbv)) {
    
    for (b in unique(metaloci.df$abbv)) {
      
      if (a == b) next
      
      message(paste(a, "x", b))
      
      # a.gr <- gr.ls[[a]]
      # b.gr <- gr.ls[[b]]
      intersection_file = file.path("../conservation/02out-gffs", paste(a, '_to_', b, '.gff3', sep=''))
      
      if (!file.exists(intersection_file)) {next}
      
      i.gr <- readGFFAsGRanges(intersection_file)
      
      i.df <- as.data.frame(findOverlaps(i.gr, gr.ls[[b]]))
      
      i.df$a = i.gr$ID[i.df$queryHits]
      
      f = match(i.df$a, gr.ls[[a]]$ID)
      
      i.df$a_type     <- gr.ls[[a]]$type[f]
      i.df$a          <- gr.ls[[a]]$name[f]
      i.df$a_contig   <- as.data.frame(gr.ls[[a]])$seqnames[f]
      i.df$a_start    <- gr.ls[[a]]@ranges@start[f]
      i.df$a_length   <- gr.ls[[a]]@ranges@width[f]
      i.df$a_members  <- gr.ls[[a]]$member_loci[f]
      i.df$a_projects <- gr.ls[[a]]$member_projects[f]
      
      
      i.df$b = gr.ls[[b]]$ID[i.df$subjectHits]
      
      f = match(i.df$b, gr.ls[[b]]$ID)
      
      i.df$b_type     <- gr.ls[[b]]$type[f]
      i.df$b          <- gr.ls[[b]]$name[f]
      i.df$b_contig   <- as.data.frame(gr.ls[[b]])$seqnames[f]
      i.df$b_start    <- gr.ls[[b]]@ranges@start[f]
      i.df$b_length   <- gr.ls[[b]]@ranges@width[f]
      i.df$b_members  <- gr.ls[[b]]$member_loci[f]
      i.df$b_projects <- gr.ls[[b]]$member_projects[f]
      
      
      i.df$pident    <- i.gr$pident[i.df$queryHits]
      i.df$evalue    <- i.gr$evalue[i.df$queryHits]
      
      
      if (any(is.na(i.df$a_type))) stop()
      
      conservation.df <- rbind(conservation.df, i.df)
      
    }
  }
  
  for (c in c('evalue','pident','a_members','b_members','a_length','b_length')) {
    conservation.df[[c]] <- as.numeric(conservation.df[[c]])
  }
  
  return(conservation.df)
}


get_new_annotation.df <- function() {
  out.df <- data.frame()
  for (abbv in unique(project.df$abbv)) {
    
    gff_file = str_glue("../metaloci/{abbv}.gff3")
    
    if (!file.exists(gff_file)) next
    # stop()
    
    df <- readGFF(gff_file)
    df <- as.data.frame(df)
    
    if (nrow(df) == 0) next
    
    df$abbv <- abbv
    
    
    out.df <- rbind(out.df, df)
  }
  
  for (c in c('fracTop', 'rpm', 'depth')) {
    out.df[[c]] <- as.numeric(out.df[[c]])
  }
  
  out.df$name <- str_replace(out.df$metalocus, 'metalocus', out.df$abbv)
  
  return(out.df)
}




get_hairpin.df <- function() {
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
  # ┋ ┋ mismatches_total
  # ┋ ┋ ┋mismatches_asymm
  # ┋ ┋ ┋┋largest_loop
  # ┋ ┋ ┋┋┋ mas_duplex_structure
  # ┋ ┋ ┋┋┋ ┋star_duplex_structure
  # ┋ ┋ ┋┋┋ ┋┋ constellation precision
  # ┋ ┋ ┋┋┋ ┋┋ ┋tight precision
  # ┋ ┋ ┋┋┋ ┋┋ ┋┋ star_found
  # ┋ ┋ ┋┋┋ ┋┋ ┋┋ ┋star_above_background
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
  
  hp.df$key            <- str_c(hp.df$name, hp.df$project, hp.df$cond, sep='-')
  hp.df$ml_name        <- ml_lookup$ml_name[match(hp.df$key, ml_lookup$key)]
  hp.df$type           <- metaloci.df$type[match(hp.df$ml_name, metaloci.df$name)]
  hp.df$context        <- metaloci.df$context[match(hp.df$ml_name, metaloci.df$name)]
  hp.df$simple_context <- metaloci.df$simple_context[match(hp.df$ml_name, metaloci.df$name)]
  hp.df$rpm            <- metaloci.df$rpm[match(hp.df$ml_name, metaloci.df$name)]
  
  hp.df$hp_cat[!hp.df$type %in% str_c("RNA_", make_dicer_sizes(19:25))] <- "(atypical-sized-sRNA)"
  hp.df$hp_cat[hp.df$type == "OtherRNA"] <- "(non-sRNA)"
  
  hp.df <- hp.df[!is.na(hp.df$ml_name),]
  
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
  
  return(hp.df)
}

get_contexts <- function(metaloci.df) {
  ml.df <- metaloci.df
  # p.df <- project.df
  context.df <- data.frame()
  for (abbv in unique(ml.df$abbv)) {
    message(abbv)
    
    context_file = str_glue("../context/01out-intersections/{abbv}.context.txt")
    if (!file.exists(context_file)) {
      message('^^^ context file not found')
      # ml.df <- ml.df[ml.df$abbv != abbv,]
      next
    }
    
    df <- read.delim(context_file)
    df$abbv <- abbv
    
    context.df <- rbind(context.df, df)
    
  }
  
  names(context.df)[names(context.df) == 'type'] <- 'closest_type'
  names(context.df)[names(context.df) == 'distance'] <- 'closest_dist'
  names(context.df)[names(context.df) == 'category'] <- 'context'
  
  ml.df <- merge(ml.df, context.df[,c('cluster','abbv', 'closest_type','closest_dist','context')], by.x=c("abbv", "ID"), by.y=c("abbv",'cluster'), all.x=T)
  
  ml.df$simple_context <- str_replace(ml.df$context, "sense_|antisense_|unstranded_|", "")
  
  
  
  return(ml.df)
}

# get_rulings <- function(metaloci.df) {
# 
#   m = match(metaloci.df$rep_locus, hairpin.df$key)
#   metaloci.df$ruling <- hairpin.df$ruling[m]
# 
#   metaloci.df$hairpin_type <- '(insufficient)'
#   metaloci.df$hairpin_type[is.na(metaloci.df$ruling)] <- '-'
#   metaloci.df$hairpin_type[metaloci.df$ruling == 'x x xx xx x -'] <- 'near_miRNA'
#   metaloci.df$hairpin_type[metaloci.df$ruling == 'x x xx xx x x'] <- 'miRNA'
#   metaloci.df$hairpin_type[metaloci.df$type == 'OtherRNA'] <- '(overruled)'
# 
#   # metaloci.df$rep_project <- str_split_fixed(metaloci.df$rep_locus, "-", 3)[,2]
#   # metaloci.df$hairpin_file <- str_c(hairpin.df$name[m], hairpin.df$sub_name[m], "eps", sep='.')
#   # metaloci.df$hairpin_file <- str_replace(metaloci.df$hairpin_file, "\\.\\.", "\\.")
#   # metaloci.df$hairpin_file <- str_c("njohnson@darwin:/home2/njohnson/fungi_annotations/annotations",
#   #                                   str_split_fixed(metaloci.df$rep_locus, "-", 3)[,2],
#   #                                   "hairpin",
#   #                                   str_split_fixed(metaloci.df$rep_locus, "-", 3)[,3],
#   #                                   "folds",
#   #                                   metaloci.df$hairpin_file, sep='/')
#   # metaloci.df$hairpin_file[is.na(metaloci.df$hairpin_file)] <- ''
#   metaloci.df$hairpin_length <- hairpin.df$length[m]
# 
#   return(metaloci.df)
# }

# get_mir.df <- function() {
#   
#   out.df <- data.frame()
#   
#   for (hairpin_file in Sys.glob("../+annotations/*/hairpin/hairpins.txt")) {
#     
#     message(hairpin_file)
#     
#     s = str_split_fixed(hairpin_file, "/", 6)
#   
#     project   = s[,3]
#     condition = str_split_fixed(s[,4], "_",2)[,2]
#     
#     df <- read.delim(hairpin_file)
#     
#     if (nrow(df) == 0) {message("   ^^^ file empty"); next}
#     
#     df$condition = condition
#     df$project   = project
#     
#     out.df <- rbind(out.df, df)
#   }
#   
#   out.df$precision <- as.numeric(out.df$precision)
#   out.df$precision <- round(out.df$precision, 3)
#   
#   out.df$mfe_per_nt <- as.numeric(out.df$mfe_per_nt)
#   out.df$mfe_per_nt <- round(out.df$mfe_per_nt, 3)
#   
#   return(out.df)
# }





get_aggregated_profiles <- function() {
  p.df <- profile.df
  
  stop("here I need to formalize the aggregation steps. I'm thinking another function for the filtering steps.")
  
}

# a.df <- annotation.df
# merge_annotations <- function(a.df) {
#   
#   for (abbv in unique(a.df$abbv)) {
#     
#     projects = unique(a.df$project[a.df$abbv == abbv])
#     
#     ap.df <- a.df[a.df$abbv == abbv,]
#     
#     gr = GRanges(ap.df$Locus)
#     
#     findOverlaps()
#     
#     
#     
#   }
#   
#   
# }



get_genome.df <- function() {
  
  
  out.df <- data.frame()
  for (fa_file in Sys.glob("../+genomes/*.fa")) {
    
    base = str_sub(basename(fa_file), 7, -12)
    assembly = strsplit(base, "_")[[1]][3]
    genbank  = str_remove(base, paste("_", assembly, sep=''))
    idx_file = paste(fa_file, ".fai", sep='')
    gff_file = str_replace(fa_file, ".fa", '.gff')
    # message(idx_file)
    # if (!file.exists(idx_file)) {message("^^^ not found"); stop()}
    
    
    
    abbv = str_sub(strsplit(idx_file, "/")[[1]][3], 1, 5)
    df <- read.delim(idx_file, header = F)
    names(df) <- c('contig','length','tot_pos','x','xx')
    df$abbv <- abbv
    df$genbank = genbank
    df$assembly = assembly
    df$has_idx = file.exists(idx_file)
    df$has_annotation = file.exists(gff_file)
    df <- df[,c('abbv', 'contig','length', 'tot_pos', 'genbank','assembly','has_idx','has_annotation')]
  
    out.df <- rbind(out.df, df)
  }
  
  return(out.df)
}

# helpers -----------------------------------------------------------------

make_dicer_sizes <- function(size_range) {
  
  ones   = as.character(size_range)
  if (length(size_range) == 1) return(ones)
  twos   = str_c(ones[1:(length(ones)-1)], ones[2:(length(ones)-0)], sep='_')
  
  if (length(size_range) == 2) return(c(ones, twos))
  threes = str_c(ones[1:(length(ones)-2)], ones[2:(length(ones)-1)], ones[3:(length(ones)-0)], sep='_')
  
  return(c(ones,twos,threes))
}





# plotting functions ------------------------------------------------------



pixelPlot <- function(x, y, xlim=NULL, ylim=NULL, zlim=NULL, n = 51, 
                      xlab='', ylab='', main='',
                      log=10,
                      color_scale= 'Oslo',
                      pal_reverse = F) {# hcl.colors(200, 'OrRd', rev=T),
  # col.line='black',                      white_zero=T, 
  
  
  color_n = 200
  if (length(color_scale) == 1) {
    
    if (!(str_detect(color_scale, "^#") | 
          color_scale %in% colors() |
          color_scale %in% hcl.pals())) {
      stop("color_scale must be a vector of colors, or a single color to use for the scale generation")
    }
    
    if (color_scale %in% hcl.pals()) {
      color_scale = hcl.colors(color_n, color_scale, rev=pal_reverse)
    } else {
      ramp <- colorRampPalette(c("white", color_scale))
      color_scale = ramp(color_n)
      
    }
    
    
  } else if (!(all(str_detect(color_scale, "^#") | color_scale %in% colors()))) {
    message(paste(color_scale[which(!(str_detect(color_scale, "^#") | color_scale %in% colors()))], collapse=', '))
    stop('colors in color_scale do not match hex codes or colors()')
    
  }
  
  
  count_all = length(x)
  
  if (is.null(xlim)) xlim=c(min(x, na.rm=T)*0.8, max(x, na.rm=T)*1.2)
  if (is.null(ylim)) ylim=c(min(y, na.rm=T)*0.8, max(y, na.rm=T)*1.2)
  
  xrange = xlim[2] - xlim[1]
  yrange = ylim[2] - ylim[1]
  
  f = x >= xlim[1] & x <= xlim[2] & y >= ylim[1] & y <= ylim[2]
  x <- x[f]
  y <- y[f]
  
  # if (white_zero) {
  #   color_scale = c('white', color_scale)
  # }
  
  
  xy_to_image <- function(x, y, n, base) {
    
    xi = floor((x - xlim[1]) / (xrange / n)) + 1
    yi = floor((y - ylim[1]) / (yrange / n)) + 1
    
    tab = table(paste(xi, yi))
    
    
    mat = c()
    for (xxi in 1:n) {
      for (yyi in 1:n) {
        
        val = unname(tab[paste(xxi,yyi)])
        if (is.na(val)) {
          val = 0
        } 
        mat = c(mat, val)
      }
    }
    
    
    
    mat = matrix(mat, nrow=n, byrow=T)
    log_mat = log(mat, base) + 1
    
    # log_mat[is.infinite(log_mat)] <- 0
    
    
    xbreaks = ((0:n) / n * xrange) + xlim[1]
    ybreaks = ((0:n) / n * yrange) + ylim[1]
    
    ls = list(mat=mat,
              log_mat=log_mat,
              xbreaks = xbreaks,
              ybreaks = ybreaks)
    
    
    
    return(ls)
  }
  
  img.ls <- xy_to_image(x,y, n=n, base=log)
  
  
  if (as.logical(log)) {
    mat = img.ls$log_mat
  } else {
    mat = img.ls$mat
  }
  
  
  if (is.null(zlim)) zlim = c(0, max(mat))
  
  mat[mat > zlim[2]] <- zlim[2]
  
  image(x= img.ls$xbreaks,
        y= img.ls$ybreaks,
        z= mat,
        col=color_scale,
        xlab=xlab, ylab=ylab,
        zlim=zlim,
        las=1)
  
  mtext(main, 3, line=0.5, adj=c(0), cex=0.8, font=2)
  
  log_text_format <- function(x, log) {
    out = as.expression( sapply(x, function(x) bquote(.(log)^.(x))) )
    out[x%%1!=0] <- ''
    return(out)
  }
  
  
  ticks <- axisTicks(c(0,zlim[2]), log=as.logical(log))
  
  if (as.logical(log)) {
    # ticks <- c(0, ticks)
    ticks = log(ticks, log)
    legend_labels <- log_text_format(ticks, log)
    
  } else {
    legend_labels <- ticks
    
  }
  
  
  
  lx1 = xlim[2] + xrange*0.05
  lx2 = lx1 + xrange*0.05
  ly1 = ylim[2] - yrange*0.5
  ly2 = ylim[2]
  
  
  xpd = par()$xpd
  par(xpd=T)
  
  rect(lx1, 
       ly1 + (1:length(color_scale)-1)/length(color_scale) * yrange/2,
       lx2,
       ly2,
       col=color_scale,
       border=NA)
  rect(lx1, ly1, lx2, ly2, col=NA)
  
  
  
  ty = ticks / zlim[2] * yrange / 2 + ly1 
  
  text(lx2, ty, legend_labels, pos=4)
  
  par(xpd=xpd)
  
  # mtext("Genes per pixel", side=4, line=1.5, cex=0.6, at=dim/2)
  
  
  
  box()
  
  
  img.ls$zlim = zlim
  img.ls$color_scale = color_scale
  img.ls$count_all = count_all
  img.ls$count_plotted = sum(img.ls$mat)
  img.ls$percent_plotted = round(img.ls$count_plotted / img.ls$count_all * 100,1)
  
  return(img.ls)
  
  # points(x,y, pch=19, col=scales::alpha('black', 0.2), cex=0.2)
  
}

