library(shiny)

source("analysis_final.R")
# setwd("C:/Users/Matt/Documents/INFO2012/final_assignment/rent_vs_crime_final/")

function(input, output, session) {
     output$plot <- renderPlot({
          plot(cars, type=input$plotType)
     })
     
     output$summary <- renderPrint({
          summary(cars)
     })
     
     
     # Outputs for Question 1
     
     output$q1text <- renderText({
       p <- "We wanted to take a look at how rent prices were affected by crime rates (both low and high). 
       To do this, we analyzed the rent prices for the top 5 counties by crime rate and the 5 counties with the lowest crime rates for 2016. 
       There are other factors that may affect rent prices fluctuating (such as inflation) but we did not consider those variables in our analysis. 
       We formulated this question because we were interested in seeing if living in areas of high crime would correspond to a decreasing rent, and vice versa. 
      This question is important to analyze because these are two factors that people would definetly consider when moving to a new location, and
      seeing how they interact would be beneficial. Prior to any data analysis, we hypothesized that counties with particularly high crime rates would 
      have their rent prices decline, and counties with low crime rates would have their rent prices increase."
       p
     })
     
     output$table_high <- renderTable({
          filtered_table <- high_crimes %>%
            filter(year >= input$years[1] & year <= input$years[2])
          colnames(filtered_table) <- c("Year", "County", "State", "Rent Value ($)", "Crime Rate (per 100,000 people) for 2016")
          filtered_table
     })
     
     output$table_high_caption <- renderText({
       caption <- paste0("This data table displays the rent value for the top 5 highest counties in the US by crime rate in 2016 between the years of ", 
                         input$years[1], " and ", input$years[2], ". The crime rate values are all from 2016, which is why every county has one value 
                         for crime rate. Note: some counties dont have data for certain years.")
      caption
     })
     output$table_low <- renderTable({
          filtered_table <- low_crimes %>%
            filter(year >= input$years[1] & year <= input$years[2])
          colnames(filtered_table) <- c("Year", "County", "State", "Rent Value ($)", "Crime Rate (per 100,000 people) for 2016")
          filtered_table
     })
     
     output$table_low_caption <- renderText({
       caption <- paste0("This data table displays the rent value for the top 5 lowest counties in the US by crime rate in 2016 between the years of ", 
                         input$years[1], " and ", input$years[2], ". The crime rate values are all from 2016, which why is every county has one value 
                         for crime rate. Note: some counties dont have data for certain years.")
       caption
     })
     
     output$plot_high <- renderPlot({
       p <- ggplot(data = high_crimes) +
         geom_point(mapping = aes(x = year, y = rent_value, color = RegionName))
       p
     })
     
     output$plot_low <- renderPlot({
       p <- ggplot(data = low_crimes) +
            geom_point(mapping = aes(x = rent_value , y = crime_rate_per_100000, color = RegionName))
       p
     })
     
     output$analysistext <- renderText({
       analysis_text <- paste("<p>The five counties with the highest crime rates per 100,000 people for 2016 were District of Columbia (DC), Philadelphia 
                          County (PA), and Shelby, Madison, and Davidson counties, all in Tennessee. It is interesting to note one state having three counties on 
                          this list, which probably signifies that some public policies need to change in Tennessee, but that is a topic for further research. Out of 
              the five highest crime-rate counties shown,", strong("all five"), "counties had their average rent price go down at least one year after 2016. The most 
                          significant of these declines was in Philadelphia County, who saw its average rent price go down 75 dollars in 2016 due to 
                          having a very high crime rate of 1,150 per 100,000 people. Although a small sample size, these observations support the conclusion that having a 
                          high crime rate will lead to rent prices in the county decreasing.</p><p>
       The five counties with the lowest crime rates per 100,000 people for 2016 were Lafayette County (MS), Hamilton and Boone 
                          Counties (IN), Tolland County (CT), and Hunterdon County (NJ). Out of these five counties,", strong("only one"), "county (Lafayette County 
                          in Mississippi) saw a decrease in its average rent price in any year after 2016. This decrease in rent value also didn't happen until
                          2019, and could have easily been affected by other variables. For the most part however, these five counties saw a steady increase in 
                          their rent prices after 2016. The most significant of these increases was in Hunterdon County (NJ), as after it had one of the 
                          top 5 lowest crime rates for any county in the US in 2016, its average rent saw a steady increase by an average of 100 dollars a 
                          month until 2019. These observations support the conclusion that having a low crime rate will lead to rent prices in the county increasing.
                             </p> <p>
       One major takeaway from this analysis is that a high crime rate does not necessarily correspond to a low average rent value. 
                      For example, the District of Columbia landed as one of the five counties with the highest crime rates for 2016, yet it also 
                      consistently had a higher rent value than any county from the five lowest crime rates. The District of Columbia in 2016 had 
                      the second highest crime rate in the United States at 1,216 per 100,000 people, yet also had the highest rent value out of the 
10 counties analyzed for this question at $2,536.</p> <p>
       Thus, high crime does not always signify cheap rent. However, a high crime rate does consistently correspond to a <i>decrease </i>
                          in average rent value for years to come, so cheaper rent relative to what it was before. This analysis supports  
                          that there is an inverse correlation between crime rate and rent prices inclining or declining. A high crime rate consistently
                          leads to a decline in rent prices, and vice versa. </p>")
       analysis_text
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
     

}