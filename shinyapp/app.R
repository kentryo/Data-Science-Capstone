#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
source("prediction model.R")

# Define UI for application that draws a histogram
ui <- fluidPage(
   
  titlePanel("N-gram Word Prediction"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      textInput("wordinput", label = h3("Input partial sentence"))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      textOutput("wordprediction")
    )
   )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    output$wordprediction <- renderPrint({prediction(input$wordinput)})
}

# Run the application 
shinyApp(ui = ui, server = server)

