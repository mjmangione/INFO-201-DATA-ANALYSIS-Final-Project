
library(shiny)
source("analysis_final.R")

server <- function(input, output) {
   
  output$high_crimes_table <- renderTable({
    t <- high_crimes
    t <- c("fer", "FRE", "sgrs", "srg")
    t
  })
  
}
