library(fpp3)
library(readr)
library(ggplot2)
library(quantmod)
library(plotly)
library(shinythemes)
library(shinyWidgets)
library(dplyr)
library(tidyquant)


# Read zipped data
stocks <- read_csv("nyse_stocks.csv.zip")
View(stocks)
# Convert to `tsibble()`
stocks$date <- as.Date(stocks$date)
stocks <- tsibble(stocks, index = date, key = symbol)

# 1 stock
selected_stock <- "AAPL"

stocks %>%
  filter(symbol == selected_stock) %>%
  autoplot(open) +
  labs(title = selected_stock)

# Multiple stocks
selected_stocks <- c("GOOG", "AAPL")

stocks %>%
  filter(symbol %in% selected_stocks) %>%
  autoplot(open)


data <- getSymbols(input$select_stock,
                   from = input$selected_dates[1],
                   to = input$selected_dates[2],
                   auto.assign = FALSE)

