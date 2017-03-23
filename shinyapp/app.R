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
      textInput("wordinput", label = h3("Type in partial sentence:")),
      h5("Instructions: Put in a partial sentence or several words. This application will predict the next-word based on the n-gram words analysis."),
      h5("Application Description: This application is aimed at predicting next-word using n-gram words analysis and simple backoff prediction methods."),
      h5("This application is for the Coursera Data Science Capstone Course."),
      h5("Code and relative data could be found at",a("My Github", href="https://github.com/kentryo/data-science-capstone/"))
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h3("The top 3 predicted next-words are:"),
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

