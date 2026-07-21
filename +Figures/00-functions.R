



get_aspect_ratio <- function() {
  
  xrang = (par()$usr[2] - par()$usr[1])
  yrang = (par()$usr[4] - par()$usr[3]) 
  xp    = (par()$plt[2] - par()$plt[1])
  yp    = (par()$plt[4] - par()$plt[3])
  
  ar = (yrang / yp) / (xrang / xp) * par()$din[1] / par()$din[2]
  return(ar)
}

get_dir_paths <- function() {
  
  ann_dir = '/Users/jax/fungal_annotations/annotations/'
  gen_dir = '/Users/jax/fungal_annotations/Genomes/'
  
  if (dir.exists(ann_dir) & dir.exists(gen_dir)) return(list(ann=ann_dir, gen=gen_dir))
  
  gen_dir = '/Volumes/fungal_srnas/Genomes/'
  ann_dir = '/Volumes/fungal_srnas/Annotations/'
  
  if (dir.exists(ann_dir) & dir.exists(gen_dir)) return(list(ann=ann_dir, gen=gen_dir))
  
  stop("sRNA directories not found! Are you connected to the NAS or sshfs?")
}


get_gff_files <- function(abbv) {
  dirs = get_dir_paths()
  
  ncbi_gff = Sys.glob(paste0(dirs$gen, abbv, "*_genomic.gff3"))[1]
  rfam_gff = str_glue("../rfam/02out-rfam_gffs/{abbv}.rfam.gff3")
  te_gff = str_glue("../TE_annotations/eg_out/{abbv}_EarlGrey/{abbv}_summaryFiles/{abbv}.filteredRepeats.gff")
  
  return(list(ncbi=ncbi_gff,
              rfam=rfam_gff,
              te=te_gff))
}


# library.df <- get_library.df()





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







# get_metaloci.df <- function() {
#   out.df <- data.frame()
#   
#   # for (gff_file in Sys.glob("../metaloci/*.meta.gff3")) {
#   #   abbv = str_split
#   for (abbv in unique(project.df$abbv)) {
#     message(abbv)
# 
#     gff_file = str_glue("../metaloci/01out-meta_gffs/{abbv}.meta.gff3")
# 
#     if (!file.exists(gff_file)) {message("^^^ meta ann not found"); next}
#     
#     df <- readGFF(gff_file)
#     df <- as.data.frame(df)
#     
#     if (nrow(df) == 0) next
#     
#     df$length <- df$end - df$start
#     df$abbv <- abbv
#     df$name <- str_replace(df$ID, "metalocus", abbv)
#     
#     
#     out.df <- rbind(out.df, df)
#   }
#   
#   for (c in c('fracTop', 'rpm', 'depth', 'member_loci', 'member_projects')) {
#     out.df[[c]] <- as.numeric(out.df[[c]])
#   }
#   
#   return(out.df)
# }
# 
# get_ml_lookup <- function() {
#   out.df <- data.frame()
#   
#   # for (gff_file in Sys.glob("../metaloci/*.meta.gff3")) {
#   #   abbv = str_split
#   for (abbv in unique(project.df$abbv)) {
#     message(abbv)
#     
#     gff_file = str_glue("../metaloci/{abbv}.gff3")
#     
#     if (!file.exists(gff_file)) {message("^^^ meta ann not found"); next}
#     
#     df <- readGFF(gff_file)
#     df <- as.data.frame(df)
#     
#     if (nrow(df) == 0) next
#     
#     df$key = str_c(df$ID, df$project, df$annotation, sep='-')
#     
#     df$abbv <- abbv
#     df$ml_name <- str_replace(df$metalocus, "metalocus", df$abbv)
#     
#     out.df <- rbind(out.df, df)
#   }
#   
#   
#   return(out.df)
#     
#   
# }









# get_contexts <- function(metaloci.df) {
#   ml.df <- metaloci.df
#   # p.df <- project.df
#   context.df <- data.frame()
#   for (abbv in unique(ml.df$abbv)) {
#     message(abbv)
#     
#     context_file = str_glue("../context/01out-intersections/{abbv}.context.txt")
#     if (!file.exists(context_file)) {
#       message('^^^ context file not found')
#       # ml.df <- ml.df[ml.df$abbv != abbv,]
#       next
#     }
#     
#     df <- read.delim(context_file)
#     df$abbv <- abbv
#     
#     context.df <- rbind(context.df, df)
#     
#   }
#   
#   names(context.df)[names(context.df) == 'type'] <- 'closest_type'
#   names(context.df)[names(context.df) == 'distance'] <- 'closest_dist'
#   names(context.df)[names(context.df) == 'category'] <- 'context'
#   
#   ml.df <- merge(ml.df, context.df[,c('cluster','abbv', 'closest_type','closest_dist','context')], by.x=c("abbv", "ID"), by.y=c("abbv",'cluster'), all.x=T)
#   
#   ml.df$simple_context <- str_replace(ml.df$context, "sense_|antisense_|unstranded_|", "")
#   
#   
#   
#   return(ml.df)
# }

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
  for (fa_file in Sys.glob("../+genomes/*genomic.fa")) {
    
    base = str_sub(basename(fa_file), 7, -12)
    assembly = strsplit(base, "_")[[1]][3]
    genbank  = str_remove(base, paste("_", assembly, sep=''))
    idx_file = paste(fa_file, ".fai", sep='')
    
    
    gff_file = str_replace(fa_file, ".fa", '.gff')
    message(idx_file)
    if (!file.exists(idx_file)) {message("^^^ not found"); next}
    
    
    
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

# genome.df <- get_genome.df()

# metaloci functions ------------------------------------------------------


get_metalocus_mats <- function(abbv) {
  
  # ml_file = str_glue("../metaloci/01out-meta_gffs/{abbv}.all.gff3")
  ml_file = str_glue("../metaloci/01out-meta_gffs_2026.02.26/{abbv}.all.gff3")
  if (!file.exists(ml_file)) return()
  m.df <- rtracklayer::readGFF(ml_file)
  m.df$sample <- str_c(str_split_fixed(m.df$project, "\\.", 2)[,2], m.df$annotation, sep='.')
  
  ls = list()
  
  o.df <- dcast(m.df, metalocus ~ sample, value.var='sample', fun.aggregate = length) 
  o.df <- o.df[order(as.numeric(str_split_fixed(o.df$metalocus, "-", 2)[,2])),]
  rownames(o.df) <- o.df$metalocus
  o.df$metalocus <- NULL
  o.df <- as.matrix(o.df)
  
  ls$annotation <- o.df
  
  o.df <- dcast(m.df, metalocus ~ project, value.var='sample', fun.aggregate = length)
  o.df <- o.df[order(as.numeric(str_split_fixed(o.df$metalocus, "-", 2)[,2])),]
  rownames(o.df) <- o.df$metalocus
  o.df$metalocus <- NULL
  o.df <- as.matrix(o.df)
  ls$project <- o.df
  
  return(ls)
  
  barplot(table(rowSums(m.df)))
  
  
  return(m.df)
}


test_metalocus_replication <- function(abbv, padj=0.01) {
  
  # This function looks through pres/abs matricies of metaloci across projects and annotations to identify if they are reproducible.  
  # 
  # This is a multi-tier test, with significance based on a one-tailed poisson binomial probability, scaled for the likelihood for an annotation to identify a metalocus in its sample (out of all metaloci). Basically: given the number of detects, how likely is it that we find this many annotations by chance? 
  # 
  # The first tier (1-overall) uses this test (padj) across all annotations, ignoring inter-project reproducibility, and is probably quite weak. 
  # 
  # The second tier ignores the test, and simply identifies loci which are shared between multiple projects. 
  # 
  # The third tier, performs poisson binomial tests (padj) on each project, and identifies if a project significantly produces a given metalocus. Subsequently, we aggregate the number of projects which are significant in this regard
  # 
  # Tiers are classified (greedily). 
  # 
  # A rep-score is calculated based on project detections and significant project detections:
  #   
  #   (log2(project_count)/2 + log2(project_p_count+1) ) - 1
  # 
  # Scores above 0 show enough replication for us to consider them, and this scales upwards with the strength of evidence (diminishing returns due to log). A minimally passing project (0.5) could have support in 2 projects, but only significant detection in 1 of those projects. 
  
  
  
  mat.ls <- get_metalocus_mats(abbv)
  
  if (is.null(mat.ls)) return()
  amat = mat.ls$annotation
  pmat <- mat.ls$project
  
  colnames(pmat) <- str_sub(colnames(pmat), 7,-1)
  pmat[pmat > 1] <- 1
  amat[amat > 1] <- 1
  
  head(pmat)
  head(amat)
  
  
  background = apply(amat, 2, mean)
  overall_pval <- ppoisbinom(rowSums(amat), pp=background, lower_tail = F)
  overall_padj <- p.adjust(overall_pval, method='BH')
  
  
  within_mat = pmat
  within_mat[] <- NA
  
  
  for (project in colnames(pmat)) {
    cf = str_detect(colnames(amat), paste0("^", project))
    rf = pmat[,project] > 0
    
    background = colSums(amat[rf,cf, drop=F]) / nrow(pmat)
    totals = rowSums(amat[rf,cf, drop=F])
    
    within_pvals = ppoisbinom(totals, pp=background, lower_tail = F)
    
    # within_mat[rf,project] <- within_pvals
    within_mat[rf,project] <- p.adjust(within_pvals, method = 'BH')
    
  }
  
  
  
  wmat <- within_mat
  wmat[is.na(wmat)] <- 1

  
  between = apply(wmat, 1, function(x) sum(x < padj ))
  # names(between) <- "pass_count"
  # between_count <- sum(between >= 2)
  
  out.ls <- list()
  out.ls$project_within_p <- wmat
  out.ls$project <- pmat
  
  df <- as.data.frame(apply(wmat, 1, function(x) min(x, na.rm=T)))
  names(df) <- 'best_within_p'
  df$project_count <- rowSums(pmat)
  df$project_p_count <- apply(wmat, 1, function(x) sum(x < padj ))
  
  
  df$overall_pval <- overall_pval
  df$overall_padj <- overall_padj
  df$overall_pass <- overall_padj < padj

  table(project=df$project_count >=2,
        project_p = df$project_p_count >= 2)
  
  df$evidence <- as.numeric(df$overall_pass)*0.5 + as.numeric(df$project_count >=2) + as.numeric(df$project_p_count >= 2)
  df$evidence_strict <- paste0('tier-',as.numeric(df$project_count >=2) + as.numeric(df$project_p_count >= 2))
  
  df$evidence = '0-none'
  if (nrow(amat) > 1) df$evidence[df$overall_pass] <- '1-annotation_pb'
  df$evidence[df$project_count >= 2] <- '2-project_count'
  df$evidence[df$project_p_count >= 2] <- '3-project_pb'
  
  ## calculating rep score
  df$rep_score = log2(df$project_count)/2 + log2(df$project_p_count+1)
  df$rep_score[is.infinite(df$rep_score)] <- 0
  df$rep_score <- round(df$rep_score, 2)-1
  df$rep_score[df$rep_score < 0] <- 0
  
  out.ls$plot <- function() {
    par(mfrow=c(2,2))
    conf = out.ls$summary$project_p_count
    e = ecdf(conf)
    plot(e, main=str_glue("{out.ls$abbv} (padj<{out.ls$padj})"), xlim=c(-0.5, out.ls$project_n+0.5), ylim=c(0,1),
         las=1, xlab='Conf. projects', ylab='Prop.', axes=F)
    box()
    axis(2, las=1)
    axis(1, at=0:out.ls$annotation_n)
    t = paste0(round(100-e(knots(e))*100,1), 
               '%\n', 
               sapply(0:out.ls$project_n, function(x) sum(conf > x)))
    par(xpd=T)
    text(knots(e), e(knots(e)), t, pos=2, cex=0.8, col=ifelse(knots(e) >= 2, 'red', 'black'))
    
    tab = table(out.ls$summary$evidence_strict)
    b = barplot(tab, las=1, main='support')
    text(b, tab, tab, col='red', cex=0.8, pos=3)
    par(xpd=F)
    
    hist(out.ls$summary$rep_score)
    plot(density(out.ls$summary$rep_score))
    
    text(par()$usr[2]*0.15, par()$usr[4]*0.8, paste0("<-",
                                                     sum(out.ls$summary$rep_score == 0), 
                                                     "\n", 
                                                     sum(out.ls$summary$rep_score > 0),
                                                     "->"), 
         adj=c(0,0))
    
    par(mfrow=c(1,1))
    
  }
  out.ls$summary <- df
  out.ls$abbv <- abbv
  out.ls$padj <- padj
  out.ls$project_n <- ncol(pmat)
  out.ls$annotation_n <- ncol(amat)
  
  return(out.ls)
  
}

binom_p <- function(abbv, q=0.5, p=0.05) {
  
  ## calculating mean value of lower half of data
  mat.ls <- get_metalocus_mats(abbv)
  mat = mat.ls$annotation
  pmat <- mat.ls$project
  
  if (type(mat) == 'character') return(list(plot=function() {return()}))
  mat[mat > 1] <- 1
  pmat[pmat > 1] <- 1
  # mat = pmat
  
  # mat = cbind(mat, pmat)
  
  # plot(ecdf(rowSums(mat)), xlab='n annotations', main='Annotation replication for loci')
  # text(par()$usr[2]*0.95, par()$usr[4]*0.05, abbv, font=2, adj=c(1,0))
  
  o = order(rowSums(mat))[1:floor(nrow(mat)*q)]
  f_hat = mean(as.vector(mat[o,]))
  f_hat_full = mean(as.vector(mat))
  cat("f value:", f_hat)
  
  ## finding pvals from this binary distribution
  totals <- rowSums(mat, na.rm=TRUE)
  n_loci <- nrow(mat)
  n_samp <- ncol(mat)
  
  pvals <- rep(0, n_loci)
  for (i in seq_len(n_loci)) {
    k <- totals[i]
    
    pvals[i] <- pbinom(k, size=n_samp, prob=f_hat, lower.tail=FALSE)
    
  }
  
  out.df = data.frame(row.names = rownames(mat), total=rowSums(mat), pval=pvals)
  out.df$padj <- p.adjust(out.df$pval, method="BH")
  out.df$sig05 <- out.df$padj <= 0.05
  out.df$sig01 <- out.df$padj <= 0.01
  
  
  thresholds = data.frame()
  for (padj in c(0.1, 0.05, 0.01, 0.001)) {
    t = min(c(n_samp+1, out.df$total[out.df$padj <= padj]))
    select = padj==p
    thresholds = rbind(thresholds,data.frame(padj=padj, t=t, select=select))
  }
  
  threshold = thresholds$t[thresholds$select]
  
  random_dist = rbinom(10000, size=n_samp, prob=f_hat)
  random = ecdf(random_dist)
  real   = ecdf(out.df$total)
  
  make_plot = function() {
    par(pch=19, lwd=1.5, font=2, las=1)
    plot(1,1, type='n', xlab='Replicated projects', ylab='Cumulative Prop.',
         xlim=c(0.5,n_samp), ylim=c(0,1), main=abbv, axes=F)
    axis(2)
    axis(1, at=1:n_samp)
    box()
    
    lines(1:n_samp, random(1:n_samp), type='o', cex=0.5, 'grey75')
    lines(1:n_samp, real(1:n_samp), type='o', cex=0.5, col='goldenrod')
    abline(v=threshold-0.5, col='blue', lty=3)
    
    text(threshold-0.5, 0.1, 
         str_c(as.character(sum(out.df$total < threshold)), "\nfail"),
         pos=2, col='red')
    text(threshold-0.5, 0.1, 
         str_c(as.character(sum(out.df$total >= threshold)), "\npass"), 
         pos=4, col='goldenrod')
    legend('right', c('samples', 'random'), lwd=2,col=c('goldenrod','black'), inset=0.02, cex=0.6)
  }
  
  ls = list(abbv=abbv, out=out.df,random=random_dist, n_samp=n_samp, n_loci=n_loci, thresholds=thresholds, plot=make_plot)
  
  return(ls)
  
}
# 
res = binom_p('Bocin')
res$plot()
# res = binom_p('Scscl')
# res$plot()
# res = binom_p('Scpom')
# res$plot()
# 
# res = binom_p('Asapi')
# res$plot()
# 
# res = binom_p('Fugra')
# res$plot()




poibin_p <- function(abbv) {
  library(poibin)
  
  ## calculating mean value of lower half of data
  mat.ls <- get_metalocus_mats(abbv)
  amat = mat.ls$annotation
  pmat <- mat.ls$project
  
  if (type(amat) == 'character') return(list(plot=function() {return()}))
  
  amat[amat > 1] <- 1
  pmat[pmat > 1] <- 1
  
  
  calc_padj <- function(mat) {
    col_probs = apply(mat, 2, mean)
    n_loci <- nrow(mat)
    n_samp <- ncol(mat)
    
    
    method = "DFT-CF"
    pvals <- rep(0, n_loci)
    for (i in seq_len(n_loci)) {
      k <- totals[i]
      
      pvals[i] <- 1-ppoibin(k, pp=col_probs, method = method)
      
    }
    
    
    out.df = data.frame(row.names = rownames(mat), total=rowSums(mat), pval=pvals)
    
    out.df$padj <- p.adjust(out.df$pval, method="BH")
    out.df$sig05 <- out.df$padj <= 0.05
    out.df$sig01 <- out.df$padj <= 0.01
    
    table(out.df$total, out.df$sig05)
    
    plot(ecdf(out.df$total), main=abbv)
    
    lines(1:ncol(mat), ppoibin(1:ncol(mat), pp=col_probs, method = method), col='red', lwd=2)
    return(out.df)
  }
  
  
  a.df <- calc_padj(amat)
  p.df <- calc_padj(pmat)
  
  a.df$sig01 <- NULL
  p.df$sig01 <- NULL
  
  names(a.df) <- c('an', 'apval', 'apadj','asig05')
  names(p.df) <- c('pn', 'ppval', 'ppadj','psig05') 
  
  out.df <- cbind(a.df, p.df)
  head(out.df)
  
  print(table(project=out.df$psig05, annotation=out.df$asig05))
  
  
  
}


# par(mfrow=c(3,2),
#     par=c(1,3,0.5,0.5))
# poibin_p('Bocin')
# poibin_p('Scscl')
# poibin_p('Fugra')
# poibin_p('Necra')
# poibin_p('Scpom')
# poibin_p('Nocer')
# poibin_p('Scpom')




# helpers -----------------------------------------------------------------

make_dicer_sizes <- function(size_range) {
  
  ones   = as.character(size_range)
  if (length(size_range) == 1) return(ones)
  twos   = str_c(ones[1:(length(ones)-1)], ones[2:(length(ones)-0)], sep='_')
  
  if (length(size_range) == 2) return(c(ones, twos))
  threes = str_c(ones[1:(length(ones)-2)], ones[2:(length(ones)-1)], ones[3:(length(ones)-0)], sep='_')
  
  return(c(ones,twos,threes))
}

fix_seqlevels <- function(g, seqids) {
  
  if (any(seqids %in% lookup.df$genbankAccession)) {
    target='genbankAccession'
    source='refseqAccession'
    
  } else if (any(seqids %in% lookup.df$refseqAccession)) {
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



get_gff_grrs <- function(abbv, refseqids=NULL) {
  message (abbv)
  

  dirs <- get_dir_paths()
  s.df = species.df[species.df$abbv == abbv,]
  ncbi_gff = str_glue("{dirs$gen}{abbv}.{s.df$accession}_{s.df$assembly_name}_genomic.gff3")
  
  ncbi_fasta = str_glue("{dirs$gen}{abbv}.{s.df$accession}_{s.df$assembly_name}_genomic.fa")
  rfam_gff = str_glue("../rfam/02out-rfam_gffs/{abbv}.rfam.gff3")
  te_gff   = str_glue("../TE_annotations/eg_out/{abbv}_EarlGrey/{abbv}_summaryFiles/{abbv}.filteredRepeats.gff")
  
  for (gff in c(ncbi_gff, rfam_gff, te_gff)) {
    if (!file.exists(gff)) return(paste("GFF not found:", gff))
  }
  
  out.ls <- list()
  
  out.ls$ncbi.gene <- import.gff(ncbi_gff, feature.type	= 'gene')
  out.ls$ncbi.mRNA <- import.gff(ncbi_gff, feature.type	= 'mRNA')
  out.ls$ncbi.exon <- import.gff(ncbi_gff, feature.type	= 'exon')
  out.ls$rfam      <- import.gff(rfam_gff)
  out.ls$te        <- import.gff(te_gff)
  out.ls$te <- out.ls$te[out.ls$te$type != 'Simple_repeat',]
  out.ls$te <- out.ls$te[out.ls$te$type != 'Unknown']
  
  ref_seqs = scanFaIndex(ncbi_fasta)
  tile.gr <- unlist(tile(ref_seqs, width=300))
  tile.gr <- tile.gr[!overlapsAny(tile.gr, c(out.ls$ncbi.gene, out.ls$rfam, out.ls$te))]
  tile.gr[sample(1:length(tile.gr),500),]
  
  out.ls$rand <- tile.gr
  
  ## fixing problems with genbank/refseq chromosome names
  
  if (! is.null(refseqids)) {
    for (n in names(out.ls)) {
      gffs_to_fix = names(out.ls)
    }
  } else {
    message("  no refseq ids supplied -> normalizing to the ncbi entry seqlevels.")
    gffs_to_fix = c('te','rfam')
    refseqids <- seqlevels(ref_seqs)
  }
  
  for (n in gffs_to_fix) {
    out.ls[[n]] = fix_seqlevels(out.ls[[n]], seqids=refseqids)
  }

  
  return(out.ls)
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



# upset plot --------------------------------------------------------------

# 
# x <- p.df$filter_str
# 
# upset <- function(x) {
#   
#   x <- str_replace(x, "NA", "0")
#   
#   tab = table(x)
#   
#   tab <- tab[order(-tab)]
#   
# }



