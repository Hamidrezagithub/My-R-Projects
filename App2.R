
 library(shiny)
library(tidyverse)
library(readr)
state.data <- read.csv("US_state_economic_data_1980_2018.csv")

ui <- fluidPage(
  selectInput(inputId = "state", label= "Please select a state", choices=state.data$state_name),
  selectInput(inputId = "year", label= "Please select a year", choices=state.data$year),
  
  textOutput(outputId = "text"),
  tableOutput(outputId = "table"),
  dataTableOutput(outputId = "datatable")
)

server <- function(input, output, server) {
  output$text <- renderText(
    {
      state.data.selected <- subset(state.data, state_name==input$state &year==input$year)
      paste("The unemployment rate in", input$state, "is", state.data.selected$Unemploymentrate)
    }
  )
  output$table <- renderTable(
    {
      state.data.selected <- subset(state.data, state_name==input$state &year==input$year)
    }
  )
  
  output$datatable <- renderDataTable(
    {
      state.data.selected.2 <- subset(state.data, state_name==input$state)
    }
  )
}
shinyApp(ui, server)
