

library(reshape2)
library(stringr)
library(svglite)
library(ape)
library(GenomicRanges)
library(rtracklayer)
library(Rsamtools)
library(genesectR)
library(beeswarm)
library(jsonlite)
library(poisbinom)

# BiocManager::install("seqbias")

# detach("package:layermap", unload = TRUE)
# devtools::install_github('NateyJay/layermap')
library(layermap)


source("00-functions.R")
source("00-preprocessing.R")

set.seed(42)



# getting network drives --------------------------------------------------

### code to provide valid network locations



# basic details -----------------------------------------------------------

l.df <- library.df

length(unique(l.df$abbv)) # species
nrow(l.df) # libraries
length(unique(paste(l.df$bioproject, l.df$rg))) # conditions/annotations
length(unique(l.df$bioproject)) # projects

m.df <- metalocus.df
length(unique(metalocus.df$abbv))
f = metalocus.df$replication != "None" & metalocus.df$sizing == 'typical'
length(unique(metalocus.df$abbv[f]))


# Color sets --------------------------------------------------------------


phylum_colors = c(
  "Basidiomycota"='brown',
  "Ascomycota"='lightblue',
  "Mucoromycota"='gold',
  "Microsporidia"='grey20'
)

phylum_pch = c(
  "Basidiomycota"=21,
  "Ascomycota"=22,
  "Mucoromycota"=23,
  "Microsporidia"=24
)





library(RColorBrewer)
n <- length(unique(species.df$class))
qual_col_pals = brewer.pal.info[brewer.pal.info$category == 'qual',]

class_colors = setNames(unlist(mapply(brewer.pal, qual_col_pals$maxcolors, rownames(qual_col_pals)))[1:n], unique(species.df$class))


lifestyle_colors <- c('Plant pathogen'= 'grey20',
                 'Human pathogen'= 'purple',
                 'Insect pathogen'= 'firebrick',
                 'Carnivore'='orange',
                 'Endophyte'='seagreen',
                 'Saprotroph'='lemonchiffon3')

host_colors <- c('Plant'= 'mediumseagreen',
                 'Human'= 'purple',
                 'Insect'= 'firebrick',
                 'Worm'='orange',
                 'None'='black')


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
  `19` = 'lavenderblush',
  `20` = "lightblue",
  `21` = "blue",
  `22` = "mediumseagreen",
  `23` = "orange",
  `24` = "tomato",
  `25` = "darkred"
)

hairpin_colors = setNames(c('black','slateblue','red','gold','seagreen'), c('miRNA', 'near_miRNA', 'imprecise','bad_duplex','bad_hairpin'))



# assembly lookups --------------------------------------------------------




# Loading and processing metadata -----------------------------------------
# 
# 
# project.df <- get_project.df()
# project.df <- filter_projects()
# 
# library.df <- get_library.df()
# 
# scale.df <- get_peak_scales(filter=F)
# 
# # annotation.df <- get_annotation.df()
# # annotation.df <- filter_loci(annotation.df)
# 
# annotation.df <- get_new_annotation.df()
# 
# peak.df <- get_peak.df()
# 
# ml_lookup <- get_ml_lookup()
# metaloci.df <- get_metaloci.df()
# 
# hairpin.df <- get_hairpin.df()
# 
# metaloci.df <- get_contexts(metaloci.df)
# # metaloci.df <- get_rulings(metaloci.df)
# metaloci.df$hp_cat <- hairpin.df$hp_cat[match(metaloci.df$rep_locus, hairpin.df$key)]
# metaloci.df$hp_cat[is.na(metaloci.df$hp_cat)] <- "(undescribed)"
# 
# conservation.df <- get_conservation_df()

# hairpin.df$ml_name <- metaloci.df$name[match(hairpin.df$key, metaloci.df$rep_locus)]




# View(metaloci.df[metaloci.df$type %in% str_glue("RNA_{make_dicer_sizes(19:25)}") &
#                    metaloci.df$ruling != '-',])


# table(metaloci.df$ruling)

# Trimming phylogeny ------------------------------------------------------


# passing_abbv   = project.df$abbv[project.df$f_pass]
# passing_genera = species.df$genus[species.df$abbv %in% unique(passing_abbv)]
# 
# 
# phylogeny <- ape::read.tree("../phylogenies/18s.raxml.bestTree")
# phylogeny$tip.label <- str_split_fixed(phylogeny$tip.label, "_", 3)[,1]
# 
# phylogeny$tip.label[phylogeny$tip.label == "Magnaporthe"]
# 
# phylogeny$tip.label[which(!phylogeny$tip.label %in% passing_genera)]
# passing_genera[!passing_genera %in% phylogeny$tip.label]
# 
# phylogeny <- drop.tip(phylogeny, which(!phylogeny$tip.label %in% passing_genera))
# phylogeny <- drop.tip(phylogeny, which(duplicated(phylogeny$tip.label)))




# New phylogeny -----------------------------------------------------------

passing_abbv   = project.df$abbv[project.df$f_pass]
passing_genera = species.df$genus[species.df$abbv %in% unique(passing_abbv)]

s.df <- species.df
s.df$p_name <- str_replace(s.df$species, " ", "_")


# https://doi.org/10.1016/j.cub.2021.01.074
p <- ape::read.tree("../phylogenies/Fungi_ncbi.scaled.tree")
p$genera <- str_split_fixed(p$tip.label, "_", 3)[,1]

# found
s.df$p_name[s.df$p_name %in% p$tip.label]
# not found
s.df$p_name[!s.df$p_name %in% p$tip.label]

passing_genera[!passing_genera %in% p$genera]


to_keep <- p$tip.label[p$genera %in% passing_genera]

p = keep.tip(p, to_keep)
length(p$tip.label)
p$genera <- str_split_fixed(p$tip.label, "_", 3)[,1]


to_keep <- p$tip.label[which(!duplicated(p$genera))]

p = keep.tip(p, to_keep)
length(p$tip.label)
p$genera <- str_split_fixed(p$tip.label, "_", 3)[,1]

p$tip.label <- p$genera

phy = p


# Genus phylogeny ---------------------------------------------------------

# https://doi.org/10.1016/j.cub.2021.01.074
p <- ape::read.tree("../phylogenies/Fungi_ncbi.scaled.tree")
p$genera <- str_split_fixed(p$tip.label, "_", 3)[,1]

# phy found in genera
unique(p$genera[p$genera %in% genera])

# genera found in phy
genera[genera %in% p$genera]

# genera not found in phy
genera[!genera %in% p$genera]

p$tip.label <- p$genera
w = which(!duplicated(p$genera) & p$genera %in% genera)
phy_trimmed <- keep.tip(p, w)





# Species phylogeny -------------------------------------------------------


# https://doi.org/10.1016/j.cub.2021.01.074
p <- ape::read.tree("../phylogenies/Fungi_ncbi.scaled.tree")
p$tip.label


species.df$tree_species <- sapply(species.df$species, function(x) str_replace(x, " ", "_"))
species.df <- species.df[species.df$abbv %in% conservation.df$t.abbv |
               species.df$abbv %in% conservation.df$q.abbv,]

# list all problem species
species.df$tree_species[!species.df$tree_species %in% p$tip.label]

# Athelia_rolfsii
species.df$species[species.df$genus == 'Athelia']
p$tip.label[str_detect(p$tip.label, regex('athelia', ignore_case = T))]
# no good candidate

# Blumeria_hordei
species.df$species[species.df$genus == 'Blumeria']
p$tip.label[str_detect(p$tip.label, regex('Blumeria', ignore_case = T))]
# genus mate already in use

# Gigaspora_margarita
species.df$species[species.df$genus == 'Gigaspora']
p$tip.label[str_detect(p$tip.label, regex('Gigaspora', ignore_case = T))]
species.df$tree_species[species.df$tree_species == 'Gigaspora_margarita'] <- "Gigaspora_rosea"

# Mucor_lusitanicus
species.df$species[species.df$genus == 'Mucor']
p$tip.label[str_detect(p$tip.label, regex('Mucor', ignore_case = T))]
species.df$tree_species[species.df$tree_species == 'Mucor_lusitanicus'] <- "Mucor_circinelloides"

# Nosema_bombycis
species.df$species[species.df$genus == 'Nosema']
p$tip.label[str_detect(p$tip.label, regex('Nosema', ignore_case = T))]
# not in use already?
species.df$tree_species[species.df$tree_species == 'Nosema_bombycis'] <- "Nosema_ceranae"


# Pichia_fermentans
species.df$species[species.df$genus == 'Pichia']
p$tip.label[str_detect(p$tip.label, regex('Pichia', ignore_case = T))]
# many -> Pichia_heedii (no pastoris)
species.df$tree_species[species.df$tree_species == 'Pichia_fermentans'] <- "Pichia_heedii"

# Pleurotus_cornucopiae
species.df$species[species.df$genus == 'Pleurotus']
p$tip.label[str_detect(p$tip.label, regex('Pleurotus', ignore_case = T))]
species.df$tree_species[species.df$tree_species == 'Pleurotus_cornucopiae'] <- "Pleurotus_ostreatus"

# Puccinia_graminis
species.df$species[species.df$genus == 'Puccinia']
p$tip.label[str_detect(p$tip.label, regex('Puccinia', ignore_case = T))]
species.df$tree_species[species.df$tree_species == 'Puccinia_graminis'] <- "Puccinia_triticina"

# Sanghuangporus_vaninii
species.df$species[species.df$genus == 'Sanghuangporus']
p$tip.label[str_detect(p$tip.label, regex('Sanghuangporus', ignore_case = T))]
species.df$tree_species[species.df$tree_species == 'Sanghuangporus_vaninii'] <- "Sanghuangporus_baumii"


w = which(p$tip.label %in% species.df$tree_species)
species.phy <- keep.tip(p, w)

