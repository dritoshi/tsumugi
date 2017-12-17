rm(list = ls())

setwd("/Users/itoshi/Projects/gdeg/SVF/All_DEG/tsumugi")

data = readRDS("data/tsne.rds")

df = merge(
  data$metadata, t(data$expression),
  by.x = "cell.name", by.y = "row.names"
)

cls.types = unique(sort(data$metadata$class.name))
exp.cls = matrix(0, nrow = nrow(data$expression), ncol = length(cls.types))
for (i in 1:length(cls.types)) {
  exp.cls[,i] = rowMeans(exp[,cls == cls.types[i]])
}
colnames(exp.cls) = cls.types
rownames(exp.cls) = rownames(exp)


