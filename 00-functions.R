


get_meta.df <- function() {
  meta_file = file.path("/Volumes/YASMA/master_table.xlsx")
  # meta_file = file.path(path)
  
  
  # if (! file.exists(meta_file)) {
  #   message("/Volumes/YASMA/master_table.xlsx not found!")
  #   message("  -> working from backup file meta_backup.txt")
  #   return(read.delim("meta_backup.txt"))
  # }
  
  meta.df <- readxl::read_excel(meta_file, skip=1)
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
  for (abbv in unique(project.df$abbv)) {
    
    gff_file = str_glue("../metaloci/{abbv}.meta.gff3")
    
    if (!file.exists(gff_file)) next
    
    df <- readGFF(gff_file)
    df <- as.data.frame(df)
    
    if (nrow(df) == 0) next
    
    df$abbv <- abbv
    
    
    out.df <- rbind(out.df, df)
  }
  
  for (c in c('fracTop', 'rpm', 'depth', 'member_loci', 'member_projects')) {
    out.df[[c]] <- as.numeric(out.df[[c]])
  }
  
  return(out.df)
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
  hairpin.df <- data.frame()
  
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
      
      df <- df[,c("abbv", "project", 'cond',
                  "name","sub_name","locus","contig","start","stop","strand","stranded","length","mas", "star", "mfe",
                  "ruling","struc_count","unstruc_count","p_struc","mpn_pass","mismatches_asymm","mismatches_total","no_mas_structures","no_star_structures","precision",         "star_found") ]
      
      table(df$ruling)
      
      passing_rulings = c('x x xx xx x -',
                          'x x xx xx x x')
      
      df <- df[df$ruling %in% passing_rulings,]
      
      
      hairpin.df = rbind(hairpin.df, df)
      
    }
    
  }
  
  hairpin.df$key <- str_c(hairpin.df$name, hairpin.df$project, hairpin.df$cond, sep='-')
  return(hairpin.df)
}

get_context.df <- function() {
  ml.df <- metaloci.df
  p.df <- project.df
  context.df <- data.frame()
  for (abbv in unique(ml.df$abbv)) {
    message(abbv)
    
    context_file = str_glue("../context/01out-intersections/{abbv}.context.txt")
    if (!file.exists(context_file)) {
      message('^^^ context file not found')
      ml.df <- ml.df[ml.df$abbv != abbv,]
      next
    }
    
    df <- read.delim(context_file)
    df$abbv <- abbv
    
    context.df <- rbind(context.df, df)
    
  }
  
  ml.df <- merge(ml.df, context.df[,c('cluster','abbv','mRNA_distance','category')], by.x=c("abbv", "ID"), by.y=c("abbv",'cluster'), all=T)
}

get_mir.df <- function() {
  
  out.df <- data.frame()
  
  for (hairpin_file in Sys.glob("../+annotations/*/hairpin/hairpins.txt")) {
    
    message(hairpin_file)
    
    s = str_split_fixed(hairpin_file, "/", 6)
  
    project   = s[,3]
    condition = str_split_fixed(s[,4], "_",2)[,2]
    
    df <- read.delim(hairpin_file)
    
    if (nrow(df) == 0) {message("   ^^^ file empty"); next}
    
    df$condition = condition
    df$project   = project
    
    out.df <- rbind(out.df, df)
  }
  
  out.df$precision <- as.numeric(out.df$precision)
  out.df$precision <- round(out.df$precision, 3)
  
  out.df$mfe_per_nt <- as.numeric(out.df$mfe_per_nt)
  out.df$mfe_per_nt <- round(out.df$mfe_per_nt, 3)
  
  return(out.df)
}





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
  for (idx_file in Sys.glob("../+genomes/*.fai")) {
    
    abbv = str_sub(strsplit(idx_file, "/")[[1]][3], 1, 5)
    df <- read.delim(idx_file, header = F)
    names(df) <- c('contig','length','tot_pos','x','xx')
    df$abbv <- abbv
    df <- df[,c('abbv', 'contig','length', 'tot_pos')]
  
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

