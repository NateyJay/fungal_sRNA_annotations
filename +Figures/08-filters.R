## filters.R

# describes filters used in libraries, projects, and otherwise



# project filters ---------------------------------------------------------


p.df <- project.df

table(p.df$filter_str)

tab =table(p.df$abbv[p.df$filter_str == '1111'])
tab[order(-tab)]
