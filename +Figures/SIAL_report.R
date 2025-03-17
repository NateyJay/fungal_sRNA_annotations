



# lifestyle_counts --------------------------------------------------------

s.df <- species.df

par(mar=c(5,10,4,2))
barplot(table(s.df$clean_lifestyle), horiz=T, las=1, xlab="Species Count", main='Fungal lifestyles')


# how many projects per species?

m.df <- meta.df
m.df$key <- str_c(meta.df$bioproject, meta.df$abbv)
m.df <- m.df[!duplicated(m.df$key),]

table(m.df$abbv)


m.df <- meta.df
m.df$class <- species.df$class[match(m.df$abbv, species.df$abbv)]
m.df$key <- str_c(meta.df$bioproject, meta.df$class)
m.df <- m.df[!duplicated(m.df$key),]

table(m.df$class)



# density plot of all loci counts -----------------------------------------


a.df <- annotation.df
a.df$phylum <- species.df$phylum[match(a.df$abbv, species.df$abbv)]

# plot(density(table(a.df$project)))
plot(1,1,type='n', main="All annotations", xlab="Locus count", ylab='Prop.',
     xlim=c(0,5000), ylim=c(0,1), lwd=2)


for (phylum in names(phylum_colors)) {
  lines(ecdf(table(a.df$project[a.df$phylum == phylum])), verticals=T, do.points=F, main="All annotations", xlab="Locus count", ylab='Prop.',
       xlim=c(0,5000), ylim=c(0,1),
       col=phylum_colors[phylum], lwd=2.5)
  
}

lines(ecdf(table(a.df$project)), verticals=T, do.points=F, main="All annotations", xlab="Locus count", ylab='Prop.',
     xlim=c(0,5000), ylim=c(0,1), lwd=2.5)




# post filtering ----------------------------------------

p.df <- project.df
p.df <- p.df[!is.na(p.df$f_pass) & p.df$f_pass,]

dim(p.df)
length((unique(p.df$abbv)))

table(p.df$ab)

m.df <- meta.df[meta.df$bioproject %in% str_sub(p.df$project, 7,-1),]
m.df <- m.df[!duplicated(m.df$`project-rg`),]

table(table(m.df$abbv) > 1)
29/ (29+7)






