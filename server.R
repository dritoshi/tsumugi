library(shiny)

source("helpers.R")
load("data/exp2.rda")

server = function(input, output, session) {

  ##################################################
  ## Heatmap of cluster average with dendrogram
  output$heatplot = renderPlotly({
    my.hover.mat = matrix(
      paste(
        paste0("Class: ", cls.types),
        colnames(my.mat),
        signif(my.mat, 3),
        sep = "\n"
      ),
      nrow = nrow(my.mat), ncol = ncol(my.mat)
    )

    p = plot_ly(source = "heatplot") %>% 
      add_heatmap(
        z = ~my.mat,
        x = factor(colnames(my.mat), lev = colnames(my.mat)),
        y = factor(rownames(my.mat), lev = rownames(my.mat)),
        hoverinfo = 'text',
        text = my.hover.mat
      )

    # Plotting it all together
    eaxis = list(showticklabels = FALSE, showgrid = FALSE, zeroline = FALSE)
    p_empty = plot_ly() %>% 
      layout(margin = list(l = 200), xaxis = eaxis, yaxis = eaxis)

    p
  })

  ##################################
  ## Biplot of Dimension reduction
  output$biplot = renderPlotly({
    df.tsne = data.frame(
      cell.name = colnames(exp),
      Val1 = exp.tsne[,1],
      Val2 = exp.tsne[,2],
      cluster = as.character(cls),
      sample = sample.names,
      unit   = unit.names
    )
    df.tsne = transform(
      df.tsne,
      cluster = factor(cluster, levels = c(as.character(0:length(cls.types)-1)))
    )
    my.hover = paste(
      df.tsne$cell.name,
      paste0("Class: ",  df.tsne$cluster),
      paste0("Sample: ", df.tsne$sample),        
      paste0("Unit: ",   df.tsne$unit),
      sep = "\n"
    )    
    
    s = event_data("plotly_hover", source = "heatplot")
    if (length(s)) {
      gene = s[["x"]]
      # cluster.num =  s[["y"]]
      gene.exp = as.numeric(exp[gene,]) # extract gene expression
      plot_ly(
        data = df.tsne, x = ~Val1, y = ~Val2, color = ~gene.exp,
        type = "scatter", mode = "marker",
        hoverinfo = 'text', text = my.hover
      )
    } else {
      plot_ly(
        data = df.tsne, x = ~Val1, y = ~Val2, color = ~cluster,
        type = "scatter", mode = "marker",
        hoverinfo = 'text', text = my.hover
      )      
    }
  })

  ###################################
  ## barplot of unit info.
  output$unit_barplot = renderPlotly({
    df.tsne = data.frame(
      cell.name = colnames(exp),
      Val1 = exp.tsne[,1],
      Val2 = exp.tsne[,2],
      cluster = as.character(cls),
      sample = sample.names,
      unit   = unit.names
    )
    df.tsne = transform(
      df.tsne,
      cluster = factor(cluster, levels = c(as.character(0:length(cls.types)-1)))
    )    
    g = ggplot(df.tsne, aes(cluster)) + 
      geom_bar(aes(fill = unit), position = position_stack(reverse = TRUE)) +
      coord_flip() +
      theme(legend.position = "top")
    ggplotly(g)

  })  

  ###################################
  ## barplot of sample.
  output$sample_barplot = renderPlotly({
    df.tsne = data.frame(
      cell.name = colnames(exp),
      Val1 = exp.tsne[,1],
      Val2 = exp.tsne[,2],
      cluster = as.character(cls),
      sample = sample.names,
      unit   = unit.names
    )
    df.tsne = transform(
      df.tsne,
      cluster = factor(cluster, levels = c(as.character(0:length(cls.types)-1)))
    )    
    g = ggplot(df.tsne, aes(cluster)) + 
      geom_bar(aes(fill = sample), position = position_stack(reverse = TRUE)) +
      coord_flip() + 
      theme(legend.position = "top")
    ggplotly(g)

  })   
}
