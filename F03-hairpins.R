

hairpin.df <- get_hairpin.df()


hp.df <- hairpin.df


table(hp.df$abbv, hp.df$ruling)


head(hp.df)

table(hp.df$hp_cat)

head(hp.df)



# preparing for download --------------------------------------------------

# hairpin.df <-  get_hairpin.df()
hp.df <- hairpin.df

# hp.df <- hp.df[!str_detect(hp.df$sub_name, "t"),]

# hp.df <- hairpin.df
hp.df$seq <- NULL
hp.df$fold <- NULL
hp.df <- hp.df[hp.df$project %in% project.df$project[project.df$f_pass],]

hp.df$ml_name <- ml_lookup$ml_name[match(hp.df$key, ml_lookup$key)]
hp.df$type    <- metaloci.df$type[match(hp.df$ml_name, metaloci.df$name)]
hp.df$context <- metaloci.df$context[match(hp.df$ml_name, metaloci.df$name)]
hp.df$simple_context <- metaloci.df$simple_context[match(hp.df$ml_name, metaloci.df$name)]

# table(hp.df$type, hp.df$hp_cat)
table(hp.df$abb, hp.df$hp_cat)


# hp.df[is.na(hp.df$type),]
# sum(is.na(hp.df$type))
hp.df <- hp.df[!is.na(hp.df$type),]

table(hp.df$type)
table(hp.df$hp_cat)
table(hp.df$abbv,hp.df$hp_cat)

hp.df <- hp.df[hp.df$type != 'OtherRNA',]
hp.df <- hp.df[hp.df$hp_cat %in% c('miRNA', 'near_miRNA', 'imprecise'),]
hp.df <- hp.df[!hp.df$simple_context %in% c('tRNA', 'rRNA', 'spliceosomal'),]

# table(hp.df$context, hp.df$hp_cat)
table(hp.df$abbv,hp.df$hp_cat)
table(hp.df$abbv, hp.df$simple_context)



hp.df$hairpin_file <- str_c(hp.df$name, hp.df$sub_name, sep='.')
f = str_ends(hp.df$hairpin_file, "\\.")
hp.df$hairpin_file[f] <- str_sub(hp.df$hairpin_file[f], 1, -2)
hp.df$hairpin_darwin_path <- str_c(      hp.df$project,
                                  "hairpin", 
                                  hp.df$cond,
                                  "folds", 
                                  hp.df$hairpin_file, sep='/')


write.table(paste(hp.df$hairpin_darwin_path, ".eps", sep=''), "03-hairpin_eps_files.txt", quote=F, row.names = F, col.names = F)
write.table(paste(hp.df$hairpin_darwin_path, ".txt", sep=''), "03-hairpin_txt_files.txt", quote=F, row.names = F, col.names = F)
write.table(paste(hp.df$hairpin_darwin_path, ".depths.txt", sep=''), "03-hairpin_dtxt_files.txt", quote=F, row.names = F, col.names = F)


system("rsync -arv --files-from=../fungal_sRNA_annotations/03-hairpin_eps_files.txt njohnson@darwin:/home2/njohnson/fungi_annotations/annotations/ ../+annotations")
system("rsync -arv --files-from=../fungal_sRNA_annotations/03-hairpin_txt_files.txt njohnson@darwin:/home2/njohnson/fungi_annotations/annotations/ ../+annotations")
system("rsync -arv --files-from=../fungal_sRNA_annotations/03-hairpin_dtxt_files.txt njohnson@darwin:/home2/njohnson/fungi_annotations/annotations/ ../+annotations")

for (tp in unique(hp.df$hp_cat)) {
  file = file.path("../hairpins", tp)
  dir.create(file, showWarnings = FALSE)
}


for (suffix in c(".eps", ".txt", ".depths.txt")) {
  message(str_glue("copying: {suffix} files"))

  hp.df$hairpin_local_path <- str_c(hp.df$ml, hp.df$key, sep='-')
  f = hp.df$sub_name != ''
  hp.df$hairpin_local_path[f] <- str_c(hp.df$hairpin_local_path[f], hp.df$sub_name[f], sep='.')
  hp.df$hairpin_local_path <- str_c(hp.df$hairpin_local_path, suffix, sep='')
  hp.df$hairpin_local_path <- str_c("../hairpins", hp.df$hp_cat, hp.df$hairpin_local_path, sep='/')
  
  to_copy = sum(file.exists(file.path("../+annotations", paste(hp.df$hairpin_darwin_path, suffix, sep=''))))
  message(str_glue("  {to_copy} files ready to copy"))
  already_found = sum(file.exists(hp.df$hairpin_local_path))
  
  message(str_glue("  {already_found} already done"))
  
  
  
  did_copy = sum(file.copy(  file.path("../+annotations", paste(hp.df$hairpin_darwin_path, suffix, sep='')), hp.df$hairpin_local_path))
  message(str_glue("  {did_copy} copied now"))

}

## cleanup
# rm */hairpin/*/folds/*.eps
# rm ../hairpins/*/*.eps






# what contexts are they? -------------------------------------------------



hp.df <- hairpin.df
ml.df <- metaloci.df


ml.df <- ml.df[ml.df$type != "OtherRNA",]
ml.df

table(ml.df$hp_cat, ml.df$simple_context)

ml.df[ml.df$simple_context %in% c("intergenic", "near-genic") & 
        ml.df$hp_cat %in% c("miRNA","near_miRNA"),]



# most failed rules -------------------------------------------------------

# hairpin.df <- get_hairpin.df()

hp.df <- hairpin.df

table(hp.df$hp_cat)

hp.df <- hp.df[!str_detect(hp.df$hp_cat, "\\("),]


df <- str_split_fixed(str_remove_all(hp.df$ruling, " "), '', 11)

df <- as.data.frame(df == 'x')

names(df) <- c('stranded','mfe_per_nt','mismatches_total','mismatches_asymm',
               'largest_loop','mas_duplex_structure','star_duplex_structure',
               'costellation_precision','tight_precision','star_found', "star_above_background")

df$key <- hp.df$key
df$ml_name <- hp.df$ml_name
df <- melt(df, id.vars = c('key', 'ml_name'))

df <- dcast(df, variable ~ value)

df$proportion = df$`TRUE` / (df$`TRUE` + df$`FALSE`)



par(mfrow=c(8,1), mar=c(1,5,1,2))

for (i in 5:max(hp.df$pass_sum)) {
  
  f = hp.df$pass_sum == i
  val = hp.df$star_constellation_depth[f] / hp.df$not_constellation_depth[f]
  val <- val[!is.na(val)]
  plot(density(val), main=i)
}


# looking at imprecise hairpins -------------------------------------------


hp.df <- hairpin.df
# hp.df <- hp.df[hp.df$hp_cat == 'imprecise',]


plot(1,1,type='n', xlim=c(0.8,1), ylim=c(0,1), xlab='pstruc')

par(lwd=2)
lines(ecdf(hp.df$p_struc[hp.df$hp_cat == 'miRNA']), verticals=T, do.points=F, col='black')
lines(ecdf(hp.df$p_struc[hp.df$hp_cat == 'near_miRNA']), verticals=T, do.points=F, col='slateblue')
lines(ecdf(hp.df$p_struc[hp.df$hp_cat == 'imprecise']), verticals=T, do.points=F, col='red')


plot(ecdf(hp.df$rpm), verticals=T, do.points=F, xlim=c(0,1000), ylim=c(0,1))
plot(ecdf(hp.df$mfe_per_nt), verticals=T, do.points=F, xlim=c(-1,0), ylim=c(0,1))


hp.df <- hp.df[hp.df$hp_cat == 'imprecise' & hp.df$p_struc > 0.97 & hp.df$rpm > 1000,]
table(hp.df$simple_context)


plot(ecdf(hp.df$p_struc_positions), verticals=T, do.points=F, xlim=c(0,1), ylim=c(0,1), xlab='p_struc_positions')

pixelPlot(hp.df$rpm, hp.df$p_struc_positions, xlim=c(0,10000), ylim=c(0,1))
pixelPlot(hp.df$p_struc_positions, hp.df$rpm, xlim=c(0,10000), ylim=c(0,1))

pixelPlot(hp.df$p_struc_positions, hp.df$primary_hairpin_length, ylim=c(0,300), xlim=c(0,1))

table(hp.df$sub)

pixelPlot(hp.df$p_struc_positions[hp.df$sub == 'native'], hp.df$primary_hairpin_length[hp.df$sub == 'native'], ylim=c(0,300), xlim=c(0,1), xlab='p_struc_positions', ylab='primary_hairpin_length')

par(mfrow=c(1,1))
plot(density(hp.df$p_struc))
plot(density(hp.df$p))

# df <- read.delim("../+annotations/Cocin.PRJNA560364/hairpin/A/folds/locus_415.depths.txt")
# df <- read.delim("../hairpins/miRNA/Cocin-1622-locus_1868-Cocin.PRJNA560364-B.sub0.depths.txt")
df <- read.delim("../hairpins/near_miRNA/Cocin-1531-locus_1767-Cocin.PRJNA560364-B.depths.txt")
df$struc <- !str_detect(df$fold, "\\.")
df$pdepth <- df$depth / max(df$depth)

plot(1,1,type='n', xlim=c(0,max(df$depth)), ylim=c(0,1))
lines(ecdf(df$depth[df$struc]), verticals=T, do.points=F)
lines(ecdf(df$depth[!df$struc]), verticals=T, do.points=F, col='red')





# some simple figures -----------------------------------------------------


hp.df <- hairpin.df


plot_precision_density <- function(save=F) {

  hp.df$type <- metaloci.df$type[match(hp.df$key, metaloci.df$rep_locus)]
  hp.df$ml <- metaloci.df$name[match(hp.df$key, metaloci.df$rep_locus)]
  table(hp.df$type)
  
  hp.df <- hp.df[!is.na(hp.df$type),]
  hp.df <- hp.df[hp.df$type != 'OtherRNA',]
  
  
  
  hp.df$metalocus <- metaloci.df$name[match(hp.df$key, metaloci.df$rep_locus)]
  hp.df$rpm       <- metaloci.df$rpm[match(hp.df$key, metaloci.df$rep_locus)]
  
  
  lwd = 2
  
  file_name = "03-A-precision_density.svg"
  if (save) svglite(file_name, 3.6, 3.1)
  
  par(mar=c(4,5,4,2), xpd=F)
  plot(1,1, type='n', xlim=c(0,1), ylim=c(0,10), ylab='density', xlab='precision', las=1)
  
  for (n in names(hairpin_colors)) {
    lines(density(hp.df$precision[hp.df$hp_cat == n]), col=hairpin_colors[n], lwd=lwd)
  }
  
  legend('topleft', 
         names(hairpin_colors),
         title='Hairpin class',
         lwd=lwd, inset=0.02,
         col=hairpin_colors, cex=0.6)

  if (save) dev.off()
  if (save) ADsvg(file_name)

}

plot_precision_density(F)






# hairpin types -----------------------------------------------------------



hp.df <- hairpin.df


plot_hairpin_type <- function(save=F) {
  
    
  hp.df$type <- metaloci.df$type[match(hp.df$key, metaloci.df$rep_locus)]
  hp.df$ml <- metaloci.df$name[match(hp.df$key, metaloci.df$rep_locus)]
  table(hp.df$type)
  
  hp.df <- hp.df[!is.na(hp.df$type),]
  hp.df <- hp.df[hp.df$type != 'OtherRNA',]
  
  
  hp.df$metalocus <- metaloci.df$name[match(hp.df$key, metaloci.df$rep_locus)]
  hp.df$rpm       <- metaloci.df$rpm[match(hp.df$key, metaloci.df$rep_locus)]
  
  hp.df <- hp.df[rev(order(hp.df$pass_sum)),]
  dim(hp.df)
  hp.df <- hp.df[!is.na(hp.df$metalocus),]
  hp.df <- hp.df[!duplicated(hp.df$metalocus),]
  
  tab <- table(hp.df$abbv, hp.df$hp_cat)
  tab <- tab[, names(hairpin_colors)]
  
  tab = tab[rev(rownames(tab)),]
  
  ptab = tab / rowSums(tab)
  
  
  file_name = "F03-B-hairpin_types.svg"
  if (save) svglite(file_name, 3.6, 6.77)
  
  par(mfrow=c(1,2))
  par(mar=c(4,7,4,0.5))
  barplot(t(ptab), horiz = T, las=1,
          col=hairpin_colors)
  
  par(mar=c(4,0.5,4,4))
  barplot(t(tab), horiz = T, las=1,
          col=hairpin_colors,
          names.arg = rep('', nrow(tab)))
  legend('topright',names(hairpin_colors), fill=hairpin_colors, cex=0.55)
  
  
  if (save) dev.off()
  if (save) ADsvg(file_name)

}

plot_hairpin_type(F)

#

# miRNAs ------------------------------------------------------------------


hp.df <- hairpin.df


hp.df <- hp.df[hp.df$hp_cat %in% c('miRNA', 'near_miRNA'),]
tab = table(hp.df$abbv, hp.df$hp_cat)

tab <- as.data.frame(tab)
names(tab)[1] <- 'abbv'
tab$species <- species.df$species[match(tab$abbv, species.df$abbv)]

tab <- dcast(tab, abbv + species ~ Var2, value.var = 'Freq')
tab




# Precision plot ----------------------------------------------------------



hp.df <- hairpin.df



hp.df$type <- metaloci.df$type[match(hp.df$key, metaloci.df$rep_locus)]
hp.df$ml <- metaloci.df$name[match(hp.df$key, metaloci.df$rep_locus)]
table(hp.df$type)

hp.df <- hp.df[!is.na(hp.df$type),]
hp.df <- hp.df[hp.df$type != 'OtherRNA',]


hp.df$metalocus <- metaloci.df$name[match(hp.df$key, metaloci.df$rep_locus)]
hp.df$rpm       <- metaloci.df$rpm[match(hp.df$key, metaloci.df$rep_locus)]

hp.df <- hp.df[rev(order(hp.df$pass_sum)),]
dim(hp.df)
hp.df <- hp.df[!is.na(hp.df$metalocus),]
hp.df <- hp.df[!duplicated(hp.df$metalocus),]

# hp.df[hp.df$hp_cat == 'miRNA',]



par(mar=c(5,5,5,5), mfrow=c(1,1))
# f = hp.df$hp_cat %in% c('bad_duplex')
pixelPlot(hp.df$precision, hp.df$rpm, ylim=c(0,100), zlim=c(0,10), log=F,
          xlab='precision', ylab='rpm', xlim=c(0,1),
          n=40)


plot(hp.df$precision, hp.df$rpm, ylim=c(0,300))



# star frequency ----------------------------------------------------------
# 
# alt.df <- read.delim("../hairpins/01out-alt_stars.txt")
# 
# 
# a.df <- alt.df
# 
# table(found_new_star=a.df$alt_depth > 0)
# 
# a.df <- a.df[a.df$alt_depth > 0,]
# 
# a.df$star_prop <- as.numeric(a.df$star_prop)
# a.df$alt_prop <- as.numeric(a.df$alt_prop)
# 
# a.df <- a.df[complete.cases(a.df),]
# 
# plot(density(a.df$alt_prop))
# lines(density(a.df$star_prop), col='red')

# hairpin.df <- get_hairpin.df()



hp.df <- hairpin.df

hp.df <- hp.df[rev(order(hp.df$pass_sum)),]
hp.df <- hp.df[!duplicated(hp.df$ml_name),]
hp.df <- hp.df[!is.na(hp.df$context),]


hp.df <- hp.df[!hp.df$simple_context %in% c('tRNA', 'rRNA', 'spliceosomal'),]
hp.df <- hp.df[hp.df$hp_cat %in% c('miRNA', 'near_miRNA','imprecise'),]
hp.df <- hp.df[!hp.df$type %in% c('OtherRNA'),]


hp.df$hp_cat <- factor(hp.df$hp_cat, levels=c('miRNA', 'near_miRNA','imprecise'))
head(hp.df)

barplot(table(hp.df$hp_cat, hp.df$mismatches_total), beside=T, main='total mismatches')
barplot(table(hp.df$hp_cat, hp.df$mismatches_asymm), beside=T, main='asymm mismatches')

# hp.df$

par(mar=c(4,5,4,2))
par(mfrow=c(2,1))

barplot(prop.table(table(hp.df$hp_cat, hp.df$star_offset_left), 1), beside=T, main='star_offset_left',
        col = hairpin_colors[1:3],
        ylab='prop')

barplot(prop.table(table(hp.df$hp_cat, hp.df$star_offset_right), 1), beside=T, main='star_offset_right',
        col = hairpin_colors[1:3], 
        ylab='prop')



hp.df$star
hp.df$star_length <- str_length(hp.df$star)
hp.df$mas_length <- str_length(hp.df$mas)

table(hp.df$hp_cat, hp.df$mas_length)
table(hp.df$type, hp.df$hp_cat)

par(mfrow=c(1,1))

# plot(1,1,type='n', xlim=c(-7, 30), ylim=c(0,100))

out.df = data.frame()
for (i in 1:nrow(hp.df)) {
  left   = hp.df$star_offset_left[i]
  right  = hp.df$star_offset_right[i]
  length = hp.df$mas_length[i]
  
  x = -10:35
  out = rep(0, length(x))
  names(out) = x
  
  out[as.character(left:(length+right))] <- 1
  # return(out)
  
  out.df = rbind(out.df, out)
  
  rownames(out.df)[nrow(out.df)] = hp.df$ml_name[i]
  
}

names(out.df) <- as.character(-10:35)


row.df <- out.df
row.df$ml_name <- rownames(row.df)
row.df$abbv <- hp.df$abbv[match(row.df$ml_name, hp.df$ml_name)]
row.df$hp_cat <- hp.df$hp_cat[match(row.df$ml_name, hp.df$ml_name)]
row.df$simple_context <- hp.df$simple_context[match(row.df$ml_name, hp.df$ml_name)]


par(mfrow=c(1,1))
lp <- layermap(out.df,
               palette = 'greens',
               row.df=row.df,
               row_groups = 'hp_cat')
lp <- lp_names(lp, 3)
lp <- lp_group_names(lp, 2, 'hp_cat')




barplot(table(hp.df$mas_length))


