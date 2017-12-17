rm(list = ls())

library(pvclust)
library(tsne)

setwd("/Users/itoshi/Projects/gdeg/SVF/All_DEG/tsumugi")
exp = read.table("data/raw/all_deg.txt")
class.info  = read.table(file = "data/raw/class_info.txt",  header = T)
sample.info = read.table(file = "data/raw/sample_info.txt", header = T)

metadata = merge(class.info, sample.info, by.x = "cell.name", by.y = "cell.name")
data = list(
  expression = exp,
  metadata   = metadata
)
saveRDS(data, file = "data/exp.rds")


exp.tsne = tsne(t(exp), k = 3)
#plot(exp.tsne[,1:2], pch = 21, col = as.character(cls))

exp.cls = matrix(0, nrow = nrow(exp), ncol = length(cls.types))
for (i in 1:length(cls.types)) {
  
  exp.cls[,i] = rowMeans(exp[,cls == cls.types[i]])
}
colnames(exp.cls) = cls.types
rownames(exp.cls) = rownames(exp)
exp.pv  = pvclust(exp.cls)
gene.pv = pvclust(t(exp.cls))

save(list = ls(), file = "exp.rda")
