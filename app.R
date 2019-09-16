library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(
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
                 min = 1, max = 9)
  ),
  mainPanel(plotOutput('plot1'))
))



# Define server logic required to draw a histogram
server <- function(input, output, session) {
  # Combine the selected variables into a new data frame
  selectedData <- reactive({
    iris[, c(input$xcol, input$ycol)]
  })
  
  clusters <- reactive({
    kmeans(selectedData(), input$clusters)
  })
  
  output$plot1 <- renderPlot({
    #new colors, it's all purple
    palette(c("#9803fc", "#ba03fc", "#d703fc", "#fc03c6", "#6b023e", "#4d0b43",
        "#2c0b4d", "#9693e6", "#999999"))
    par(mar = c(5.1, 4.1, 0, 1),
        bg = "#fc03c6")
    plot(selectedData(),
         col = clusters()$cluster,
         pch = 20,
         cex = 3
         )
    points(clusters()$centers,
           pch = 4,
           cex = 4,
           lwd = 4,
           bg = "#2c0b4d", 
           col = "#9693e6")
  })
  
}

# Run the application
shinyApp(ui = ui, server = server)
