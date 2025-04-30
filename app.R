library(shiny)
library(shinythemes)
library(shinyWidgets)
library(httr)
library(dplyr)
library(DT)
library(plotly)
library(lubridate)

# Sample list of stock symbols for demonstration
stock_symbols <- c("AAPL", "MSFT", "GOOGL", "AMZN", "FB", "TSLA", "NFLX", "INTC", "AMD", "NVDA")

ui <- fluidPage(
  theme = shinytheme("flatly"),  # Applying a Bootstrap theme
  titlePanel("Alpha Vantage Stock Data Dashboard"),
  
  sidebarLayout(
    sidebarPanel(
      pickerInput("stock_symbol", "Select Stock Symbols:",
                  choices = stock_symbols, 
                  options = list(`actions-box` = TRUE, `live-search` = TRUE),
                  multiple = TRUE),
      dateRangeInput("date_range", "Select Date Range:",
                     start = Sys.Date() - 30, end = Sys.Date()),
      actionButton("goButton", "Get Data", icon = icon("refresh")),
      downloadButton("downloadData", "Download Data", icon = icon("download"))
    ),
    
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Plot", plotlyOutput("stockPlot")),
                  tabPanel("Summary", DTOutput("summaryTable"))
      )
    )
  )
)

server <- function(input, output, session) {
  data <- eventReactive(input$goButton, {
    req(input$stock_symbol)  # Ensure that there is at least one symbol selected
    all_data <- lapply(input$stock_symbol, function(symbol) {
      req <- paste0("https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=",
                    symbol, "&apikey=77YQU4Y9CBQRHAW4")  # Replace with your API key
      response <- httr::GET(req)
      data <- httr::content(response, "parsed")
      df <- data$`Time Series (Daily)`
      if(is.null(df)) return(NULL)
      df <- do.call(rbind.data.frame, df)
      names(df) <- c("open", "high", "low", "close", "volume")
      df$date <- rownames(df)
      rownames(df) <- NULL
      df$symbol <- symbol
      df <- transform(df, 
                     date = as.Date(date), 
                     close = as.numeric(close), 
                     volume = as.numeric(volume))
      df
    })
    do.call(rbind, all_data)
  }, ignoreNULL = FALSE)
  
  output$stockPlot <- renderPlotly({
    req(data())
    if(nrow(data()) == 0) return(NULL)
    p <- ggplot(data(), aes(x = date, y = close, color = symbol)) +
      geom_line() +
      labs(title = "Closing Prices by Stock",
           x = "Date", y = "Close Price") +
      theme_minimal()
    ggplotly(p)
  })
  
  output$summaryTable <- renderDT({
    req(data())
    if (nrow(data()) == 0) return(NULL)
    data() %>%
      group_by(symbol, month = floor_date(date, "month")) %>%
      summarise(
        MaxClose = max(close, na.rm = TRUE),
        MinClose = min(close, na.rm = TRUE),
        AverageClose = mean(close, na.rm = TRUE),
        StdDevClose = sd(close, na.rm = TRUE),
        TotalVolume = sum(volume, na.rm = TRUE),
        CountDays = n(),
        .groups = 'drop'
      ) %>%
      datatable(options = list(pageLength = 10, scrollX = TRUE))
  })
  
  output$downloadData <- downloadHandler(
    filename = function() { paste("stock-data-", Sys.Date(), ".csv", sep="") },
    content = function(file) {
      write.csv(data(), file, row.names = FALSE)
    }
  )
}

shinyApp(ui = ui, server = server)
