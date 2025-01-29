

library(reshape2)
library(stringr)
library(svglite)
library(ape)


# detach("package:layermap", unload = TRUE)
# devtools::install_github('NateyJay/layermap')
library(layermap)


source("00-functions.R")

get_meta.df <- function() {
  # meta_file = file.path("/Volumes/YASMA/master_table.xlsx")
  meta_file = file.path("master_table.xlsx")
  
  
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

meta.df <- get_meta.df()



# Loading the species tree ------------------------------------------------


dend <- ape::read.tree("../phylogenies/18s.raxml.bestTree")


# making a species table --------------------------------------------------

get_species.df <- function() {
  s.df <- readxl::read_excel("../phylogenies/Species_information.xlsx")
  s.df <- as.data.frame(s.df)
  head(s.df)
  names(s.df)[2] <- 'abbv'
  s.df <- s.df[!duplicated(s.df$abbv),]
  
  
  t.df <- read.delim("../phylogenies/01out-taxonomy_info.txt")
  t.df[duplicated(t.df$abbv),]
  t.df <- t.df[!duplicated(t.df$abbv),]
  head(t.df)
  
  m.df <- merge(t.df, s.df[,c('abbv','AKA','Common Name or Disease', 'Model', "Importance", "Pathogen", "Mutualist")], 
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
  
  return(m.df)  
}


species.df <- get_species.df()


project.df <- get_project.df()
project.df <- filter_projects(project.df)

library.df <- get_library.df()

scale.df <- get_peak_scales(filter=F)

annotation.df <- get_annotation.df()
annotation.df <- filter_loci(annotation.df)

peak.df <- get_peak.df()


# Color sets --------------------------------------------------------------


phylum_colors = c(
  "Basidiomycota"='brown',
  "Ascomycota"='lightblue',
  "Mucoromycota"='gold',
  "Microsporidia"='grey20'
)


host_colors <- c('Plant'= 'mediumseagreen',
                 'Human'= 'purple',
                 'Insect'= 'firebrick',
                 'Worm'='orange')


passing_abbv   = project.df$abbv[project.df$f_pass]
passing_genera = species.df$genus[species.df$abbv %in% unique(passing_abbv)]

phylogeny <- ape::read.tree("../phylogenies/18s.raxml.bestTree")
phylogeny$tip.label <- str_split_fixed(phylogeny$tip.label, "_", 3)[,1]


phylogeny$tip.label[which(!phylogeny$tip.label %in% passing_genera)]


phylogeny <- drop.tip(phylogeny, which(!phylogeny$tip.label %in% passing_genera))
phylogeny <- drop.tip(phylogeny, which(duplicated(phylogeny$tip.label)))






