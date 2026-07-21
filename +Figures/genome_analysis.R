#genome analysis


abbv = 'Cocin'
import_genome <- function(abbv) {
  
  genome_base <- Sys.glob(paste0("../+genomes/",abbv,"*_genomic.fa"))
  
  if (length(genome_base) > 1) stop("genome base is longer than 1 entry")
  
  genome_base = str_sub(genome_base, 1, -4)
  
  message("    reading annotations ...")
  
  # genome index
  index.df <- read.delim(paste0(genome_base, ".fa.fai"), header=F)
  names(index.df) <- c('contig','length','index', 'bases_per_line','bytes_per_line')
  
  # gene annotations
  gene.gr <- import.gff(paste0(genome_base, ".gff3"), feature.type='gene')

  # rfam annotations
  rfam.gr <- import.gff(paste0("../rfam/02out-rfam_gffs/", abbv, ".rfam.gff3"))
  table(rfam.gr$type)
  
  # TE annotations
  te.gr <- import.gff(paste0("../TE_annotations/eg_out/",abbv,"_EarlGrey/",abbv,"_summaryFiles/",abbv,".filteredRepeats.gff"))
  table(te.gr$type)
  te.gr <- te.gr[te.gr$type != 'Simple_repeat',]
  
  # sRNA annotations
  df <- metalocus.df[metalocus.df$abbv == abbv,]
  cf = c('abbv','metalocus','type','member_annotations','bin_pass','sizing')

  srna.gr <- GRanges(df$seqid, 
          IRanges(df$start, end = df$end),
          strand=df$strand)
  mcols(srna.gr) <- df[,cf]
  other.gr <- srna.gr[srna.gr$type == 'OtherRNA',]
  srna.gr <- srna.gr[srna.gr$type != 'OtherRNA',]
  srna.gr <- srna.gr[srna.gr$bin_pass == T,]
  
  
  message("    assessing genomic space ...")
  
  tile.gr <- tileGenome(seqlengths= setNames(index.df$length,index.df$contig), tilewidth =  100,
                        cut.last.tile.in.chrom= TRUE)

  
  
  hits <- findOverlaps(tile.gr, gene.gr)
  tile.gr$gene <- NA
  tile.gr$gene[hits@from] <- as.vector(gene.gr$Name[hits@to])
  
  hits <- findOverlaps(tile.gr, other.gr)
  tile.gr$other <- NA
  tile.gr$other[hits@from] <- other.gr$type[hits@to]
  
  hits <- findOverlaps(tile.gr, srna.gr)
  tile.gr$sRNA <- NA
  tile.gr$sRNA[hits@from] <- srna.gr$type[hits@to]
  
  hits <- findOverlaps(tile.gr, te.gr)
  tile.gr$TE <- NA
  tile.gr$TE[hits@from] <- as.vector(te.gr$type[hits@to])
  
  hits <- findOverlaps(tile.gr, rfam.gr)
  tile.gr$Rfam <- NA
  tile.gr$Rfam[hits@from] <- as.vector(rfam.gr$type[hits@to])
  
  
  message("    tabulating ...")
  
  tab.df <- as.data.frame(mcols(tile.gr))
  tab.df$other <- NULL
  tab.df[!is.na(tab.df)] <- 1
  tab.df[is.na(tab.df)] <- 0
  
  tab.df$summary <- apply(tab.df, 1, paste, collapse='')
  
  tab = table(tab.df$summary)
  # names(tab)
  # for (t in names(tab)) { message(paste(t, tab[t]))}
  
  # sum(tab) * 100
  
  tab <- sort(tab)
  
  # barplot(c(apply(tab.df[,1:4], 2, function(x) sum(as.numeric(x), na.rm=T)), none=as.vector(tab['0000'])))
  
  message("    plotting ...")
  
  par(las=1)
  layout(mat=matrix(c(2,1), nrow=1), widths=c(.5,1))
  
  b = barplot(tab, horiz=T, main=abbv)
  
  
  p.df <- data.frame(cat=rep(1:4, each=length(b)), 
                     bari=rep(1:length(b), 4))
  p.df$plot <- as.logical(as.numeric(str_sub(names(tab)[p.df$bari], p.df$cat, p.df$cat)))
  
  p.df$x1 <- p.df$cat
  p.df$x2 <- p.df$x1 + 1
  p.df$y1 <- p.df$bari
  p.df$y2 <- p.df$y1 + 1
  
  p.df$col[p.df$plot] <- 'red'
  
  plot(1,1,type='n', xlim=c(0.7,5.3), ylim=c(1,max(p.df$y2)), axes=F, xlab='', ylab='')
  rect(p.df$x1, p.df$y1, p.df$x2, p.df$y2, border='black', col=p.df$col)
  
  mtext(c("gene",'sRNA','TE','Rfam'),
        side=3,
        at=unique(p.df$cat)+0.5, las=2)
    
  
}


import_genome("Bocin")
import_genome("Fugra")
import_genome("Scscl")



gr <- import.gff("../TE_annotations/annotations/GCA_000149925.1_ASM14992v1_genomic.fna.mod.EDTA.TEanno.gff3")
sum(width(gr))

gr <- import.gff("../TE_annotations/eg_out/Pugra_EarlGrey/Pugra_summaryFiles/Pugra.filteredRepeats.gff")





# integrating all annotations ---------------------------------------------

integrate_annotations <- function(abbv) {
  
  dirs <- get_dir_paths()
  
  message("  ", abbv)
  
  dir.create("../integrated_annotations", showWarnings = FALSE)
  
  genome_base <- Sys.glob(paste0(dirs$gen,abbv,"*_genomic.fa"))
  
  if (length(genome_base) > 1) stop("genome base is longer than 1 entry")
  
  genome_base = str_sub(genome_base, 1, -4)
  
  message("    reading annotations ...")
  
  # genome index
  index_file = paste0(genome_base, ".fa.fai")
  if (!file.exists(index_file)) return()
  
  index.df <- read.delim(index_file, header=F)
  names(index.df) <- c('contig','length','index', 'bases_per_line','bytes_per_line')
  
  # gene annotations
  gene_gff = paste0(genome_base, ".gff3")
  if (!file.exists(gene_gff)) return()
  
  gene.gr <- import.gff(gene_gff, feature.type='gene')
  prom.gr <- promoters(gene.gr, upstream=1000, downstream = 0)
  prom.gr <- setdiff(prom.gr, gene.gr)
  prom.gr <- reduce(prom.gr)
  prom.gr$type <- 'promoter'
  prom.gr$source <- 'granges'
  
  
  # rfam annotations
  rfam_gff = paste0("../rfam/02out-rfam_gffs/", abbv, ".rfam.gff3")
  if (!file.exists(rfam_gff)) return()
  
  rfam.gr <- import.gff(rfam_gff)
  rfam.gr <- rfam.gr[rfam.gr$type != 'other',]
  rfam.gr$rfam_type <- rfam.gr$type
  rfam.gr$type <- 'structural'
  
  
  # TE annotations
  te_file =paste0("../TE_annotations/eg_out/",abbv,"_EarlGrey/",abbv,"_summaryFiles/",abbv,".filteredRepeats.gff")
  if (!file.exists(te_file)) return()
  te.gr <- import.gff(te_file)
  te.gr <- te.gr[te.gr$type != 'Simple_repeat',]
  te.gr <- te.gr[te.gr$type != 'Unknown',]
  
  te.gr$te_type <- te.gr$type
  
  if (length(te.gr) == 0) {message("  ! no TEs!"); return()}
  te.gr$type <- 'TE'
  
  # sRNA annotations
  df <- metalocus.df[metalocus.df$abbv == abbv,]
  cf = c('abbv','metalocus','type','member_annotations','bin_pass','sizing')
  
  srna.gr <- GRanges(df$seqid, 
                     IRanges(df$start, end = df$end),
                     strand=df$strand)
  mcols(srna.gr) <- df[,cf]
  other.gr <- srna.gr[srna.gr$type == 'OtherRNA',]
  srna.gr <- srna.gr[srna.gr$type != 'OtherRNA',]
  srna.gr <- srna.gr[!is.na(srna.gr$bin_pass) & srna.gr$bin_pass == T,]
  
  srna.gr$srna_type <- srna.gr$type
  if (length(srna.gr) > 0) srna.gr$type <- 'sRNA_metalocus'  
  

  ## merging all annotations  
  message("    merging ...")
  
  ls <- GRangesList(gene=gene.gr, promoter=prom.gr, srna=srna.gr,rfam=rfam.gr, te=te.gr)
    
  out.gr <- unlist(ls)
  # sortSeqlevels(out.gr)
  out.gr <- sort(out.gr, by=~seqnames + start)
  out.gr
  
  message("    exporting ...")
  export.gff3(out.gr, str_glue("../integrated_annotations/{abbv}.integrated.gff3"))
    
}

abbvs = unique(metalocus.df$abbv)

for (abbv in abbvs) {
  integrate_annotations(abbv)
  
}

integrate_annotations("Gimar")





# Scratch -----------------------------------------------------------------


gr <- import.gff("../+genomes/Scscl.GCA_000146945.2_ASM14694v2_genomic.gff3")

head(gr)
table(gr$type)

regions <- reduce(gr[gr$type == 'region',])
mRNAs   <- reduce(gr[gr$type == 'mRNA',])


sum(width(regions))
sum(width(mRNAs))


p.df <- project.df[project.df$abbv == 'Scscl',]

p.df$RPKmRNA <- p.df$total_aligned /  sum(width(mRNAs)) * 1000
p.df$RPKG <- p.df$total_aligned /  sum(width(regions))* 1000


seqlengths(regions) <- width(regions)

windows = unlist(tileGenome(seqinfo(regions), tilewidth=300))

x <- sample(length(windows), 10000, replace = F)







test_annotation_metrics <- function(project = "Scscl.PRJNA477286",
                                    annotation = 'A') {
  
  libraries = library.df[library.df$bioproject == bioproject &
                           library.df$rg == annotation, 'srr']
  

  
  bioproject = str_sub(project, 7, -1)
  abbv       = str_sub(project, 1, 5)
  
  
  bamfile <- str_glue("/Volumes/fungal_srnas/Annotations/{abbv}.{bioproject}/align/alignment.bam")
  l.df <- read.delim(str_glue("/Volumes/fungal_srnas/Annotations/{abbv}.{bioproject}/align/library_stats.txt"))
  
  
  sgr <- import.gff(str_glue("/Volumes/fungal_srnas/Annotations/{abbv}.{bioproject}/tradeoff_{annotation}/loci.gff3"))
  sgr$rpm <- as.numeric(sgr$rpm)
  sgr$rpkm = sgr$rpm / width(sgr) * 1000
  
  total_aligned = sum(l.df[l.df$library %in% libraries, 
                           c("umap",'mmap_wg','mmap_nw')])
  
  
  
  # param = ScanBamParam(which=mRNAs)
  # param = ScanBamParam(which=windows[x,])
  #                      # what = scanBamWhat())
  #                      # what = c('qname','groupid'))
  # 
  # bm <- countBam(bamfile, param=param)
  # bm
  # 
  # plot(density(bm$records), xlim=c(0,1000))
  # 
  # plot(ecdf(bm$records), xlim=c(0,1000), ylim=c(0,1))
  # 
  # bm$rpk <- bm$records / width(mRNAs) * 1000
  # bm$rpkm <- round(bm$rpk / total_aligned * 1000000,2)
  # 
  # plot(ecdf(bm$rpk), xlim=c(0,1000), ylim=c(0,1))
  # plot(ecdf(bm$rpkm), xlim=c(0,1000), ylim=c(0,1))
  # cdf <- ecdf(bm$rpkm)
  
  sgr$cdf <- cdf(sgr$rpkm)
  
  sgr$sized <- ifelse(sgr$type %in% c(
    'RNA_21',
    'RNA_22',
    'RNA_23',
    'RNA_24',
    'RNA_21_22',
    'RNA_22_23',
    'RNA_23_24',
    'RNA_21_22_23',
    'RNA_22_23_24'), 'sized','not')
  sgr$sized[sgr$type == 'OtherRNA'] <- 'other'

  out.ls <- list()  
  table(sgr$type, sgr$sized)
  out.ls$cdf9 = table(sgr$sized, cdf=sgr$cdf > 0.9)
  out.ls$skew9 = table(sgr$sized, skew9=sgr$skew > 0.9)
  out.ls$skew4 = table(sgr$sized, skew4=sgr$skew > 0.4)
  out.ls$skew2 = table(sgr$sized, skew2=sgr$skew > 0.2)
  out.ls$skew2size = table(sgr$sizecall, skew2=sgr$skew > 0.2)
  out.ls$skew1 = table(sgr$sized, skew1=sgr$skew > 0.1)
  return(out.ls)
}



project.df[project.df$abbv == 'Scscl',]
test_annotation_metrics(annotation='B')
test_annotation_metrics(project = 'Scscl.PRJNA607657', annotation='A')
test_annotation_metrics(project = 'Scscl.PRJNA379694', annotation='A')
test_annotation_metrics(project = 'Scscl.PRJNA678586', annotation='A')

project.df[project.df$abbv == 'Bocin',]
test_annotation_metrics(project = 'Bocin.PRJNA1092616', annotation='A')
test_annotation_metrics(project = 'Bocin.PRJNA431815', annotation='A')
test_annotation_metrics(project = 'Bocin.PRJNA730711', annotation='A')
test_annotation_metrics(project = 'Bocin.PRJNA1092616', annotation='A')


project.df[project.df$abbv == 'Scpom',]
test_annotation_metrics(project = 'Scpom.PRJNA168300', annotation='A')
test_annotation_metrics(project = 'Scpom.PRJNA122193', annotation='A')
test_annotation_metrics(project = 'Scpom.PRJNA168300', annotation='A')
test_annotation_metrics(project = 'Scpom.PRJNA168300', annotation='A')


project.df[project.df$abbv == 'Cocin',]
test_annotation_metrics(project = 'Cocin.PRJNA477255', annotation='A')
test_annotation_metrics(project = 'Cocin.PRJNA477255', annotation='B')
test_annotation_metrics(project = 'Cocin.PRJNA560364', annotation='A')
test_annotation_metrics(project = 'Cocin.PRJNA560364', annotation='B')


project.df[project.df$abbv == 'Fugra',]
test_annotation_metrics(project = 'Fugra.PRJNA253151', annotation='B')
test_annotation_metrics(project = 'Fugra.PRJNA888203', annotation='A')


project.df[project.df$abbv == 'Nocer',]
test_annotation_metrics(project = 'Nocer.PRJNA408312', annotation='A')
test_annotation_metrics(project = 'Nocer.PRJNA487111', annotation='A')


project.df[project.df$abbv == 'Asapi',]
test_annotation_metrics(project = 'Asapi.PRJNA560456', annotation='A')


project.df[project.df$abbv == 'Necra',]
test_annotation_metrics(project = 'Necra.PRJNA125805', annotation='A')
test_annotation_metrics(project = 'Necra.PRJNA190099', annotation='A')
test_annotation_metrics(project = 'Necra.PRJNA207075', annotation='A')

### why not just filter those that are small?

## skewed loci are bad, they should be filtered. 
## loci with sizecalls smaller than 19 are N loci, and not inherently bad.






df = as.data.frame(sgr[sgr$sized=='sized' & sgr$skew > 0.1,])
df$depth <- as.numeric(df$depth)
df$seqnames <- paste0(df$seqnames, ":", as.numeric(df$start)-1500, "-", as.numeric(df$end)+1500)
names(df)[1] <- 'locus'


View(df)


df <- read.delim("/Volumes/fungal_srnas/Annotations/Bocin.PRJNA342517/align/alignment.depth.txt")
head(df)
df <- dcast(df, length ~ rg, value.var='abundance', fun.aggregate = sum)
head(df)
df
