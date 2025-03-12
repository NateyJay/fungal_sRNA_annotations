

library(reshape2)
library(stringr)
library(svglite)
library(ape)
library(GenomicRanges)
library(rtracklayer)
library(Rsamtools)
library(genesectR)


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


context_colors <- c(intergenic='grey',
                    `near-genic`= 'gold',
                    unstranded_genic = 'cyan',
                    antisense_genic = 'purple',
                    sense_genic = 'firebrick')


deep_context_colors <- c(intergenic='grey',
                    `near-genic`= 'gold',
                    rRNA = 'lightblue2',
                    tRNA = 'darkseagreen1',
                    mRNA = 'snow',
                    spliceosomal='orange')


size_colors = c(
  `non` = "grey",
  `20` = "lightblue",
  `21` = "blue",
  `22` = "mediumseagreen",
  `23` = "orange",
  `24` = "tomato",
  `25` = "darkred"
)

hairpin_colors = setNames(c('black','slateblue','red','gold','seagreen'), c('miRNA', 'near_miRNA', 'imprecise','bad_duplex','bad_hairpin'))


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

# annotation.df <- get_annotation.df()
# annotation.df <- filter_loci(annotation.df)

annotation.df <- get_new_annotation.df()

peak.df <- get_peak.df()

ml_lookup <- get_ml_lookup()
metaloci.df <- get_metaloci.df()

hairpin.df <- get_hairpin.df()

metaloci.df <- get_contexts(metaloci.df)
# metaloci.df <- get_rulings(metaloci.df)
metaloci.df$hp_cat <- hairpin.df$hp_cat[match(metaloci.df$rep_locus, hairpin.df$key)]
metaloci.df$hp_cat[is.na(metaloci.df$hp_cat)] <- "(undescribed)"

conservation.df <- get_conservation_df()

# hairpin.df$ml_name <- metaloci.df$name[match(hairpin.df$key, metaloci.df$rep_locus)]




# View(metaloci.df[metaloci.df$type %in% str_glue("RNA_{make_dicer_sizes(19:25)}") &
#                    metaloci.df$ruling != '-',])


# table(metaloci.df$ruling)

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






