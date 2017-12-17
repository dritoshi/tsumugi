rm(list = ls())

library(ggplot2)
library(plotly)
library(dendextend)
library(ggdendro)

load("data/exp.rda")

# Load dendogram data
my.mat = t(exp.cls)
my.hover.mat = matrix(
  paste(
    paste(
      rownames(my.mat),
      paste("Class", 1:nrow(my.mat), sep = " "),
      sep = ":"
    ),
    colnames(my.mat),
    signif(my.mat, 3),
    sep = "'</br>'"
  ),
  nrow = nrow(my.mat), ncol = ncol(my.mat)
)
x = as.matrix(scale(my.mat))
dd.col = as.dendrogram(hclust(dist(x)))
dd.row = as.dendrogram(hclust(dist(t(x))))

# Cut dd.col 
dd.col = cut(dd.col, h = 6)$upper
ggdend.col = as.ggdend(dd.col)
leaf.heights = dplyr::filter(ggdend.col$nodes, !is.na(leaf))$height
leaf.seqments.idx = which(ggdend.col$segments$yend %in% leaf.heights)
ggdend.col$segments$yend[leaf.seqments.idx] = max(ggdend.col$segments$yend[leaf.seqments.idx])
ggdend.col$segments$col[leaf.seqments.idx] = "black"
ggdend.col$labels$label = 1:nrow(ggdend.col$labels)

ggdend.col$labels$y = max(ggdend.col$segments$yend[leaf.seqments.idx])
ggdend.col$labels$x = ggdend.col$segments$x[leaf.seqments.idx]
ggdend.col$labels$col = "black"
ggdend.col$segments$lwd = 0.5

ggdend.row = dendro_data(dd.row)
ggdend.row$labels$label = ""
ggdend.row$labels$col = "black"
ggdend.row$segments$lwd = 0.5

# plot dendrograms by ggplot2
py = ggplot() +
  geom_segment(data = ggdend.col$segments, aes(x = x, y = y, xend = xend, yend = yend)) +
  coord_flip() +
  annotate(
      "text", size = 4, hjust = 1, x = ggdend.col$label$x, y = ggdend.col$label$y,
      label = ggdend.col$label$label, colour = ggdend.col$label$col
    ) +
  labs(x = "", y = "")+
  theme_minimal() +
  theme(axis.text = element_blank(), axis.ticks = element_blank(), panel.grid = element_blank())
px = ggplot() + 
  geom_segment(data = ggdend.row$segments, aes(x = x, y = y, xend = xend, yend = yend)) +
  annotate(
    "text", size = 4, hjust = 1, x = ggdend.row$label$x, y = ggdend.row$label$y,
     label = ggdend.row$label$label, colour = ggdend.row$label$col
    ) +
  labs(x = "", y = "") +
  labs(x = "", y = "")+
  theme_minimal() +
  theme(axis.text = element_blank(), axis.ticks = element_blank(), panel.grid = element_blank())

# Make a heatmap
col.ord = order.dendrogram(dd.col)
row.ord = order.dendrogram(dd.row)
my.mat = my.mat[col.ord, row.ord]
my.hover.mat = my.hover.mat[col.ord, row.ord]

heatmap.plotly = plot_ly() %>% 
  add_heatmap(
    z = ~my.mat,
    x = factor(colnames(my.mat), lev = colnames(my.mat)),
    y = factor(rownames(my.mat), lev = rownames(my.mat)),
    hoverinfo = 'text',
    text = my.hover.mat
)

# Plotting it all together
eaxis = list(showticklabels = FALSE, showgrid = FALSE, zeroline = FALSE)
p_empty = plot_ly() %>% layout(margin = list(l = 200), xaxis = eaxis, yaxis = eaxis)
all.together = plotly::subplot(heatmap.plotly, py, nrows = 1, margin = 0.01)

print(all.together)

sample.names = unlist(lapply(strsplit(colnames(exp), "_"), function(x) x[3]))
unit.names   = unlist(lapply(strsplit(colnames(exp), "_"), function(x) x[4]))

save(list = ls(), file = "data/exp2.rda")
