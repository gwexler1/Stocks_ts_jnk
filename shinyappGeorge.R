library(shiny)
library(fpp3)
library(readr)
library(ggplot2)
library(quantmod)
library(plotly)
library(shinythemes)
library(shinyWidgets)
library(dplyr)
library(tidyquant)

ui <- fluidPage(
  titlePanel("Stocks!"),
  selectInput("select_stock", label = h3("Select Stock"), 
              choices = unique(stocks$symbol), 
              selected = 1),
  dateRangeInput("selected_dates", label = h3("Date range"), start= min(stocks$date), end = max(stocks$date)),
  
    selectInput("select_data", label = h3("Select Data"), 
                choices = c('open','close','high','low'), 
                selected = 1),
  
  hr(),
  fluidRow(column(3, verbatimTextOutput("value"),verbatimTextOutput("date"), verbatimTextOutput('data'), 
                  plotOutput("plot", width = "100%")))
)
  



server <- function(input, output, session) {
  output$value <- renderPrint({ 
    model <- stocks[input$select_stock==stocks$symbol, ]
    model <- model[input$selected_dates == stocks$date, ]
    model <- model[, input$select_data]
    
    model})
  output$date <- renderPrint({ input$selected_dates })
  output$data <- renderPrint({ 
    input$select_data })
  output$plot <- renderPlot({ data <- getSymbols(input$select_stock,
                                                from = input$selected_dates[1],
                                                to = input$selected_dates[2],
                                                auto.assign = FALSE)

  chart_Series(data) 
 
  },height = 500, width = 800
 
  )}
  

shinyApp(ui, server)
