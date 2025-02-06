

library(reshape2)
library(stringr)
library(svglite)
library(ape)
library(GenomicRanges)
library(rtracklayer)
library(Rsamtools)


# detach("package:layermap", unload = TRUE)
# devtools::install_github('NateyJay/layermap')
library(layermap)


source("00-functions.R")


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




size_colors = c(
  `non` = "grey",
  `20` = "lightblue",
  `21` = "blue",
  `22` = "mediumseagreen",
  `23` = "orange",
  `24` = "tomato",
  `25` = "darkred"
)



# Loading metadata from master --------------------------------------------


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
  
  m.df$species <- str_replace(m.df$species, "Pyricularia", "Magnaporthe")
  
  return(m.df)  
}


species.df <- get_species.df()



# Loading and processing metadata -----------------------------------------


project.df <- get_project.df()
project.df <- filter_projects(project.df)

library.df <- get_library.df()

scale.df <- get_peak_scales(filter=F)

annotation.df <- get_annotation.df()
# annotation.df <- filter_loci(annotation.df)

new_annotation.df <- get_new_annotation.df()

peak.df <- get_peak.df()
hairpin.df <- get_hairpin.df()

metaloci.df <- get_metaloci.df()

m = match(metaloci.df$rep_locus, hairpin.df$key)
metaloci.df$ruling <- hairpin.df$ruling[m]
metaloci.df$ruling[is.na(metaloci.df$ruling)] <- '-'
metaloci.df$ruling[metaloci.df$ruling == 'x x xx xx x -'] <- 'near_miRNA'
metaloci.df$ruling[metaloci.df$ruling == 'x x xx xx x x'] <- 'miRNA'
metaloci.df$ruling[metaloci.df$type == 'OtherRNA'] <- '-'

metaloci.df$rep_project <- str_split_fixed(metaloci.df$rep_locus, "-", 3)[,2]
metaloci.df$hairpin_name <- str_c(hairpin.df$name[m], hairpin.df$sub_name[m], "eps", sep='.')
metaloci.df$hairpin_name <- str_replace(metaloci.df$hairpin_name, "\\.\\.", "\\.")
metaloci.df$hairpin_name <- str_c("njohnson@darwin:/home2/njohnson/fungi_annotations/annotations", 
                                  str_split_fixed(metaloci.df$rep_locus, "-", 3)[,2],
                                  "hairpin", 
                                  str_split_fixed(metaloci.df$rep_locus, "-", 3)[,3],
                                  "folds", 
                                  metaloci.df$hairpin_name, sep='/')
metaloci.df$hairpin_name[is.na(metaloci.df$hairpin_name)] <- ''

View(metaloci.df[metaloci.df$type %in% str_glue("RNA_{make_dicer_sizes(19:25)}") &
                   metaloci.df$ruling != '-',])

metaloci.df$hairpin_length <- hairpin.df$length[m]

table(metaloci.df$ruling)

# Trimming phylogeny ------------------------------------------------------


passing_abbv   = project.df$abbv[project.df$f_pass]
passing_genera = species.df$genus[species.df$abbv %in% unique(passing_abbv)]


phylogeny <- ape::read.tree("../phylogenies/18s.raxml.bestTree")
phylogeny$tip.label <- str_split_fixed(phylogeny$tip.label, "_", 3)[,1]

phylogeny$tip.label[phylogeny$tip.label == "Magnaporthe"]

phylogeny$tip.label[which(!phylogeny$tip.label %in% passing_genera)]
passing_genera[!passing_genera %in% phylogeny$tip.label]

phylogeny <- drop.tip(phylogeny, which(!phylogeny$tip.label %in% passing_genera))
phylogeny <- drop.tip(phylogeny, which(duplicated(phylogeny$tip.label)))






