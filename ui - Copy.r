library(shiny)
library(ggplot2)

shinyUI(fluidPage(
  theme = "prtty.css",
  tags$head(tags$style(
    HTML(
      "
    @import url('//fonts.googleapis.com/css?family=Modak&display=swap');
      h1 {
        font-family: 'Modak', cursive;
        font-weight: 500;
        line-height: 1.1;
        color: #e8b715;
      }
    "
    )
  )),
  
  headerPanel('Iris k-means clustering'),
  
  sidebarPanel(
    selectInput('xcol', 'X Variable', names(iris)),
    selectInput('ycol', 'Y Variable', names(iris),
                selected = names(iris)[[2]]),
    numericInput('clusters', 'Cluster count', 3,
                 min = 1, max = 3)
  ),
  mainPanel(plotOutput('plot1'))
))