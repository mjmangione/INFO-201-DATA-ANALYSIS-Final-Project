library(shiny)

source("analysis_final.R")


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
     
     output$table_city_vs_crimes <- renderTable({
       filtered_table <- population_vs_types__of_crime %>%
        filter(population >= input$population[1], population <= input$population[2]) %>%
        filter(type_of_crime == input$crime_types) %>%
         head(10)
       filtered_table
     })
    
      output$Top_counties <- renderPlot ({
          top_5
     })
      
      output$Bottom_counties <- renderPlot ({
       bottom_5
        
      })
      
}

