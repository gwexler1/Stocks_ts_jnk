library(fpp3)

#Read Data
stocks<- read.csv('nyse_stocks.csv')
View(stocks)
head(stocks)

#Convert to tsibble()
stocks$date<- as.Date(stocks$date)
stocks<- tsibble(stocks, index = date, key = symbol)

#1 Stock
selected_stocks = c('GOOG', 'APPL')

stocks%>%
  filter(symbol %in% selected_stocks) %>%
autoplot()+
  labs(title = selected_stocks)
  
  