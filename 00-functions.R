


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
  
  k.df <- k.df[k.df$size < 18,]
  # no slope
  p.df$f_no_slope <- !p.df$project %in% k.df$project & p.df$f_has_peak
  table(p.df$f_no_slope)
  
  head(p.df)
  
  
  f.df <- p.df[,c('f_abs_alignment', 'f_rel_alignment', 'f_has_peak', 'f_no_slope')]
  f.df <- as.data.frame(t(apply(f.df, 1, as.numeric)))
  
  p.df$filter_str <- apply(f.df, 1, paste, collapse='')
  p.df$f_pass <- apply(f.df, 1, sum) == 4
  
  return(p.df) 
}

get_project.df <- function(filter = T) {
  m.df <- meta.df
  
  head(m.df)  
  
  m.df <- m.df[,c('fungi_abbv','bioproject')]  
  names(m.df) <- c('abbv','bioproject')
  
  m.df$project <- str_c(m.df$abbv, m.df$bioproject, sep='.')
  m.df <- m.df[!duplicated(m.df$project),]
  
  rownames(m.df) <- m.df$project
  
  
  aln.df <- data.frame()
  for (p in m.df$project) {
    
    project_file = file.path("../+annotations", p, "align/project_stats.txt")
    
    if (!file.exists(project_file)) next
    
    df <- read.delim(project_file)
    aln.df <- rbind(aln.df, df)
  }
  
  
  m.df <- merge(m.df, aln.df, by='project', all.x=T)
  
  m.df$abbv <- str_sub(m.df$project, 1, 5)
  
  if (filter) m.df <- filter_projects(m.df)
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



filter_loci <- function() {
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
    
    if (nrow(a.df) == 0 ) {message("   ^^^ annotation empty"); next}
    
    
    a.df$project = p
    a.df$abbv    = str_sub(p, 1, 5)
    
    out.df <- rbind(out.df, a.df)
    
  }
  
  
  if (filter) filter_loci()
  
  return(out.df) 
}

# annotation.df <- get_annotation.df()




# 
# annotation.df <- filter_loci()


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
