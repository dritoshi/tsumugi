rm(list = ls())

setwd("/Users/itoshi/Projects/gdeg/SVF/All_DEG")
exp = read.table("all_deg.txt")
cls = read.table(file = "cls.txt", header = FALSE)
cls = as.numeric(cls[1,])
write.table(
  data.frame(
    cell.name  = colnames(exp),
    class.name = cls
  ),
  file = "tsumugi/data/raw/class_info.txt",
  sep = "\t", quote = F,
  row.names = F
)
#cls.types = unique(sort(cls))