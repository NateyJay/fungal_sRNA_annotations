#!/usr/bin/env Rscript


setwd("../enhanced_search/")


df <- read.delim("03out-output_table.keywords.txt")


names(df) <- stringr::str_replace(names(df), "X.", "[")
names(df) <- stringr::str_replace(names(df), "\\.\\.", "] ")


x.df <- readxl::read_excel("/Volumes/YASMA/master_table.xlsx", skip=1)
x.df <- as.data.frame(x.df)



# names(df)
# 
# names(df)[names(df) %in% names(x.df)]
# 
# names(df)[!names(df) %in% names(x.df)]


for (n in names(x.df)[!names(x.df) %in% names(df)]) {
  # print(n)
  df[[n]] = ""
}

df <- df[,names(x.df)]

# head(df)



not_found_in_excel = !df$srr %in% x.df$srr

message(stringr::str_glue("{sum(not_found_in_excel)} new entries not found in excel"))


not_found_in_new = !x.df$srr %in% df$srr
message(stringr::str_glue("{sum(not_found_in_new)} excel entries not found in new table (are these without publications?)"))


found_in_both = x.df$srr %in% df$srr
message(stringr::str_glue("{sum(found_in_both)} entries found in both documents"))

message("")
df <- df[!df$srr %in% x.df$srr,]

data <- rbind(c(1,1,2,3), c(1,1, 3, 4), c(1,4,6,7))
clip <- pipe("pbcopy", "w")
message(stringr::str_glue("writing {nrow(df)} lines to the clipboard"))
write.table(df, file=clip, quote=F, row.names = F, sep='\t', col.names = F)
close(clip)

# for (i in 1:nrow(df)) {
#   row = df[i,]
#   row=paste(row, collapse='\t')
#   print(row)
#   
#   if (i==3) stop()
# }



