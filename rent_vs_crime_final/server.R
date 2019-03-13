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
     output$table_analysis <- renderText({
          p <- paste("<p>The below table shows the most popular crime per each category of rent prices, relative to the average crime rate
               per each crime. To find this, the following procedure was used:</p>
               <ul>
               <li>First, the total crime per each county is divided by the population of the county, in order to make the number of occurances per 
                    each crime independent of the county's population. </li>
               <li>Next, the average and standard deviation of each crime is found, using the data from each rent bracket.</li>
               <li>Then, a z-score is assigned to each crime for every rent bracket, using the averages and standard deviations assigned above</li>
               <li>Finally, for each rent bracket, the highest z-score is picked out of all the crimes, and this is decidedly the most popular type of 
               crime.</li></ul><p>
               Note: this", strong("does not"), "mean that each category has the most of
               this crime out of all the categories,", strong("nor"), "does it mean that it is the most popular 
               crime out of this particular bracket of rent prices. What it", strong("does"), "mean, however,
               is that this type of crime is violated an abnormally high amount in this rent category, when compared to the other crimes versus
               their averages.</p><p> 
               This methodology was chosen to remove common confounders which would typically plague a question like this.
               For example, counties which include cities are expected both to have expensive rent prices, along with abnormally large
               occurances of crime, which would skew these results if population was not accounted for. This is why this table and plot was
               created using the crime rates per the county's population. Along with this, A lot of these crimes, like larceny, are significantly
               more prevalent than others, like arson. If this table purely showed the most common type of crime commited in each rent bracket, 
               they would most likely all be larceny. Therefore, in order to find data with more insight, the relatively highest type of crime is found
               using z-scores, with the methodology described above.
               </p><br>")
          p
     })
     output$intro2 <- renderText({
          p <- "<h4>Overview</h4>
               <p>The intent of this question is to gain insight into the frequency and type of crime committed by counties with various median rent values. 
               To do this, the following tabs include a table and graph that help show the trends in crime as a response to the value of the median rent.
               One way to analyze this is to break down all of the county rental prices into digestable groups, in 
               which it is easier to distinguish the differences. The displayed table in the next table uses this method, where every county has been 
               sorted into the following brackets based on their median rent value.
               </p>
               <ul><li> $0 to $1000 </li>
                   <li> $1000 to $1500</li>
                   <li> $1500 to $2000</li>
                   <li> $2000 to $2500</li>
                   <li> $2500 and above</li>
               </ul>
               <h4>Hypothesis</h4>
               <p>
               Based on prior knowledge of the distribution of wealth and crime, as a group, we predict that, generally,
               crime will be highest for counties with a lower median rent value, and will decrease as the rent increase. 
               However, this does not account for counties with a larger wealth disparty, like many cities, in which there will likely
               be a lot of crime and also have a large median rent.
               </p>"
     })
     
     output$plot_crime <- renderPlot({
          p <- ggplot(data = crime_trends_vs_rent) +
                    geom_smooth(mapping = aes_string(x = "rent_value", y = input$crime)) +
                    geom_point(mapping = aes_string(x = "rent_value", y = input$crime)) +
                    xlab("Median Rent Per County (Dollars)") +
                    ylab(paste(input$crime, "Per Population of Each County")) 
                     
          p
     })
     
     output$q2_analysis <- renderText({
          p <- "<h4>Table Analysis<h4>
               <p>The information pulled from the table was unexpected, because crimes like arson and rape do not seem common place
                  in any bracket of rent. However, it makes more sense when the table is viewed in conjunction with the plots of each
                  type of crime. Overall, there is a general trend that the crime rate starts high, lowers as the price of rent increases,
                  but then increases again as the rent exceeds $2500. At some points, it almost appears parabolic, such as the rent versus 
                  larceny plot. This helps explain the results. For example, the $1500 to $2000 bracket has arson as its most popular crime,
                  which is a relatively rare offense. But knowing that this bracket has some of the lowest crime rates across all types of crime,
                  it doesn't mean that this group committed an obscenely large amount of arson, but that all of the counties in this grouping
                  generally commit less crimes, however they commit arson a small, but relatively larger amount. 
               </p><p>
                  
               </p>
               "
          p
     })
     
     output$plot_title <- renderText({
          p <- paste("How", input$crime, "Per County Population Compares to its Median Rent Price")
          p 
     })
     
     output$q1text <- renderText({
          p <- "This is output generated text. Fill in later"
          p
     })
}