rm(list = ls())

library(tsne)

setwd("/Users/itoshi/Projects/gdeg/SVF/All_DEG/tsumugi")

data = readRDS("data/exp.rds")
tsne = tsne(t(data$expression), k = 3)
data = c(data, tsne)
saveRDS(data, "data/tsne.rds")