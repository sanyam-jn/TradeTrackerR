# Install required packages
if (!require("pacman")) install.packages("pacman")
library(pacman)

# Install and load required packages with specific versions
p_load(
  shiny = "1.7.5",           # Core Shiny framework
  shinythemes = "1.2.0",     # Bootstrap themes for Shiny
  shinyWidgets = "0.8.0",    # Additional Shiny widgets
  httr = "1.4.7",           # HTTP requests
  dplyr = "1.1.3",          # Data manipulation
  DT = "0.30",              # Interactive tables
  plotly = "4.10.2",        # Interactive plots
  lubridate = "1.9.3"       # Date handling
)

# Function to check package versions
check_versions <- function() {
  required_versions <- c(
    shiny = "1.7.5",
    shinythemes = "1.2.0",
    shinyWidgets = "0.8.0",
    httr = "1.4.7",
    dplyr = "1.1.3",
    DT = "0.30",
    plotly = "4.10.2",
    lubridate = "1.9.3"
  )
  
  installed_versions <- sapply(names(required_versions), function(pkg) {
    as.character(packageVersion(pkg))
  })
  
  version_check <- data.frame(
    Package = names(required_versions),
    Required = unname(required_versions),
    Installed = unname(installed_versions),
    Status = ifelse(installed_versions >= required_versions, "OK", "Update needed")
  )
  
  print(version_check)
}

# Check versions after installation
check_versions()
