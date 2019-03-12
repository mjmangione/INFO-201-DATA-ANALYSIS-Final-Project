library(shiny)

source("analysis_final.R")
setwd("C:/Users/Matt/Documents/INFO2012/final_assignment/rent_vs_crime_final/")

function(input, output, session) {
     output$plot <- renderPlot({
          plot(cars, type=input$plotType)
     })
     
     output$summary <- renderPrint({
          summary(cars)
     })
     
     output$table_high <- renderTable({
          t <- high_crimes
          t
     })
     output$table_low <- renderTable({
          t <- low_crimes
          t
     })
     output$table_fav_crime <- renderTable({
          t <- fav_crime_by_rent
          t
     })
     
     output$plot_crime <- renderPlot({
          p <- ggplot(data = crime_trends_vs_rent) +
                    geom_smooth(mapping = aes_string(x = "rent_value", y = input$crime)) +
                    geom_point(mapping = aes_string(x = "rent_value", y = input$crime))
          p
     })
     
     output$q1text <- renderText({
          p <- "This is output generated text. Fill in later"
          p
     })
}