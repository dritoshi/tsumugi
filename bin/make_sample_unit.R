rm(list = ls())

library(pvclust)
library(tsne)

setwd("/Users/itoshi/Projects/gdeg/SVF/All_DEG/")
exp = read.table("all_deg.txt")

sample.names = unlist(lapply(strsplit(colnames(exp), "_"), function(x) x[3]))
unit.names   = unlist(lapply(strsplit(colnames(exp), "_"), function(x) x[4]))

write.table(
  data.frame(
    cell.name    = colnames(exp),
    sample.name = sample.names,
    unit.name   = unit.names
  ),
  file = "tsumugi/data/raw/sample_info.txt",
  sep = "\t", quote = F,
  row.names = F
)
