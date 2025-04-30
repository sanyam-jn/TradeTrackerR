# Alpha Vantage Stock Data Dashboard

![R](https://img.shields.io/badge/R-4.1.0-blue)
![Shiny](https://img.shields.io/badge/Shiny-1.7.0-brightgreen)


An interactive stock market analysis dashboard built with R Shiny that fetches real-time stock data from Alpha Vantage API. The application allows users to analyze multiple stocks simultaneously, visualize price trends, and download historical data.

## 🚀 Features

- **Multi-Stock Selection**: Analyze multiple stocks simultaneously using an interactive picker
- **Interactive Date Range**: Filter data by custom date ranges
- **Real-time Data**: Fetch latest stock data from Alpha Vantage API
- **Interactive Visualizations**: Dynamic plots using Plotly
- **Summary Statistics**: Monthly aggregated statistics for each stock
- **Data Export**: Download analyzed data in CSV format
- **Responsive Design**: Built with Bootstrap theme for better user experience

## 📋 Prerequisites

- R (>= 4.0.0)
- RStudio (recommended for development)
- Alpha Vantage API Key ([Get it here](https://www.alphavantage.co/support/#api-key))

## 📦 Required Packages

```R
install.packages(c(
  "shiny",
  "shinythemes",
  "shinyWidgets",
  "httr",
  "dplyr",
  "DT",
  "plotly",
  "lubridate"
))
```

## 🔧 Installation & Setup

1. Clone this repository:
```bash
git clone <repository-url>
cd alpha-vantage-dashboard
```

2. Set up your Alpha Vantage API key:
   - Replace `77YQU4Y9CBQRHAW4` in the code with your API key
   - For better security, consider using environment variables:
     ```R
     Sys.setenv(ALPHA_VANTAGE_API_KEY="your-api-key")
     ```

3. Run the application:
```R
shiny::runApp()
```

## 💻 Usage

1. **Select Stocks**:
   - Use the dropdown picker to select one or more stock symbols
   - Search functionality available for quick selection

2. **Choose Date Range**:
   - Select start and end dates for analysis
   - Default range is last 30 days

3. **Fetch Data**:
   - Click "Get Data" button to fetch latest stock information
   - Data is retrieved from Alpha Vantage API

4. **Analyze**:
   - View interactive price charts in the "Plot" tab
   - Check summary statistics in the "Summary" tab
   - Download data using the "Download Data" button

## 📊 Features Breakdown

### Visualization Tab
- Interactive line chart showing closing prices
- Multiple stocks displayed with different colors
- Hover tooltips with detailed information
- Zoom and pan capabilities

### Summary Tab
- Monthly aggregated statistics including:
  - Maximum closing price
  - Minimum closing price
  - Average closing price
  - Standard deviation
  - Total trading volume
  - Number of trading days

### Data Export
- Download complete dataset in CSV format
- Includes all selected stocks and date ranges
- Perfect for further analysis in other tools

## ⚠️ API Rate Limits

Alpha Vantage has the following rate limits:
- 5 API calls per minute for free tier


## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request



## 🙏 Acknowledgments

- [Alpha Vantage](https://www.alphavantage.co/) for providing the stock market data API
- [Shiny](https://shiny.rstudio.com/) for the web application framework
- [Plotly](https://plotly.com/) for interactive visualizations
