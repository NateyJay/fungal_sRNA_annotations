

library(reshape2)
library(stringr)


# detach("package:layermap", unload = TRUE)
# devtools::install_github('NateyJay/layermap')
library(layermap)





meta.df <- readxl::read_excel("/Volumes/YASMA/master_table.xlsx", skip=1)
meta.df <- as.data.frame(meta.df)
meta.df <- meta.df[!is.na(meta.df$`project-rg`),]

meta.df$abbv <- str_c(str_sub(meta.df$fungi_species, 1,2),
                      str_sub(str_split_fixed(meta.df$fungi_species, " ", 2)[,2], 1,3),
                      sep='')


head(meta.df)


spec.df <- meta.df[, c('abbv','fungi_species', 'project-rg')]
spec.df <- dcast(spec.df, abbv + fungi_species ~ .)
names(spec.df)[3] <- 'rg_count'



head(spec.df)

length(unique(spec.df$abbv))

spec.df[duplicated(spec.df$abbv),]

spec.df[spec.df$abbv == 'Crneo',]
spec.df[spec.df$abbv == 'Fugra',]
spec.df[spec.df$abbv == 'Fuoxy',]
spec.df[spec.df$abbv == 'Maory',]




















