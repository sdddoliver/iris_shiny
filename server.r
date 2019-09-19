library(shiny)
library(ggplot2)

# Define server logic required to draw a histogram
function(input, output, session) {
  # Combine the selected variables into a new data frame
  selectedData <- reactive({
    iris[, c(input$xcol, input$ycol)]
  })
  
  clusters <- reactive(
    kmeans(selectedData(), input$clusters)
  )
  
  output$plot1 <- renderPlot({
    #new colors, it's all purple
    palette(c("#9803fc", "#ba03fc", "#d703fc", "#fc03c6", "#6b023e", "#4d0b43",
              "#2c0b4d", "#9693e6", "#999999"))
    par(mar = c(5.1, 4.1, 0, 1),
        bg = "#fc03c6")
    plot(selectedData(),
         col = clusters()$cluster,
         pch = 20,
         cex = 3)
    points(clusters()$centers,
           pch = 4,
           cex = 4,
           lwd = 4,
           bg = "#2c0b4d", 
           col = "#9693e6")
  })
  
  output$downloadPlot <- downloadHandler(
    filename = 'irishist.png',
    content = function(file){ggsave(file, output$plot1)},
    contentType = "image/png"
  )
}
