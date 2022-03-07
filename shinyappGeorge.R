library(shiny)


ui <- fluidPage(
  selectInput("select_stock", label = h3("Select Stock"), 
              choices = unique(stocks$symbol), 
              selected = 1),
  dateRangeInput("selected_dates", label = h3("Date range")),
  
  hr(),
  fluidRow(column(3, verbatimTextOutput("value"),verbatimTextOutput("date")))

)


server <- function(input, output, session) {
  output$value <- renderPrint({ 
    input$select_stock })
  output$date <- renderPrint({ input$selected_dates })
}

shinyApp(ui, server)