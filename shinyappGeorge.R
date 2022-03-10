library(shiny)


ui <- fluidPage(
  selectInput("select_stock", label = h3("Select Stock"), 
              choices = unique(stocks$symbol), 
              selected = 1),
  dateRangeInput("selected_dates", label = h3("Date range"), start= min(stocks$date), end = max(stocks$date)),
  
    selectInput("select_data", label = h3("Select Data"), 
                choices = c('open','close','high','low'), 
                selected = 1),
  
  hr(),
  fluidRow(column(3, verbatimTextOutput("value"),verbatimTextOutput("date"), verbatimTextOutput('data'), plotOutput("plot")))
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
  output$plot <- renderPlot({
    plot(stocks[input$select_stock==stocks$symbol, ],model[input$selected_dates == stocks$date, ],model[, input$select_data] )
  })
  

data <- getSymbols(input$select_stock,
                   from = input$selected_dates[1],
                   to = input$selected_dates[2],
                   auto.assign = FALSE
)

chartseries(data, theme = chartTheme("white"),
            type = "line", log.scale = input$log, TA = NULL)


}


shinyApp(ui, server)
