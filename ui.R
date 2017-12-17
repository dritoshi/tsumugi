library(shiny)

ui <- fluidPage(
  
  # Application title
  titlePanel('Tsumugi (紬)'),

  fluidRow(
    column(10, plotlyOutput(outputId = "biplot", height = "600px"))
  ),
  fluidRow(
    column(10, plotlyOutput(outputId = "heatplot", height = "200px"))     
  ),
  fluidRow(
    column(5, plotlyOutput(outputId = "unit_barplot",   height = "300px")),
    column(5, plotlyOutput(outputId = "sample_barplot", height = "300px"))
  )
)
