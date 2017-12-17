library(shiny)

# Define UI for application that draws a heatmap and biplot
#ui <- navbarPage(
ui <- fluidPage(
  
  #theme = shinytheme("cerulean"),

  # Application title
  titlePanel('Tsumugi (紬)'),
  # title = 'Tsumugi',
      
  # Show a plot of the generated distribution
  #mainPanel(
    # h2("Dimension reduction"),
    # plotlyOutput("biplot"),
    #is(my.exp),
    # h2("Heatmap of cluster average with dendrogram"),
    # plotlyOutput("heatplot"),

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
  #)
  #verbatimTextOutput("hover_biplot"),
  #verbatimTextOutput("hover_heatplot")
)
