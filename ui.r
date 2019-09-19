library(shiny)
library(ggplot2)
library(DT)

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
  
  navbarPage("Navigation",
             tabPanel("Hist",
                      sidebarLayout(
                        sidebarPanel(
                          selectInput('xcol', 'X Variable', names(iris)),
                          selectInput('ycol', 'Y Variable', names(iris),
                                      selected = names(iris)[[2]]),
                          numericInput('clusters', 'Cluster count', 3, min = 1, max = 3)),
                        mainPanel(headerPanel('Iris k-means clustering'),
                                  checkboxGroupInput("checkGroup",
                                                     label = h3("Species"),
                                                     choices = list("Setosa" = 1,
                                                                    "Versicolor" = 2,
                                                                    "Virginica" = 3),
                                                     selected = 1),
                                  plotOutput("plot1")
                                  )
                      ),
                      fluidRow(downloadButton('downloadPlot','Download Plot'))
             ),
             tabPanel("About", fluidRow(column(6, includeMarkdown("about.rmd")),
                                        column(6, img(src='iris.png', #height = , width = , 
                                                      align = "right"),
                                               tags$small("Iris germanica (Purple bearded Iris), Wakehurst Place, UK.  ",
                                                          a(href = "http://commons.wikimedia.org/wiki/User:Diliff",
                                                            "User: Diliff")))))
  )
))
