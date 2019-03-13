library(shiny)
source("analysis_final.R")
<<<<<<< HEAD
#<<<<<<< HEAD

#=======
# setwd("C:/Users/Matt/Documents/INFO2012/final_assignment/rent_vs_crime_final/")
#>>>>>>> c1709f4ee026788b33443c5212bcb9417febdb55
=======
>>>>>>> e198e33cf7257fbc81dad7e5920f26ba2a886532

function(input, output, session) {
#-------------------------------------------INTRO---------------------------------------------------
     
     output$intro_page <- renderText({
          p <- "<p>The two data sets that we utilized for this presentation are rent prices by county and crime rates by county. The rent value data comes from Zillow,
          and online real estate database company. There are a lot different data sets that Zillow provides which can be found on their website (link the website here).
          Specifically, we used data provided for average rental listings and set the geography filter to county. The crime rate data come from Kaggle, an online community
          that allows users to create and share data sets. We were able to find a dataset in Kaggle which showed crime rates by county in the US. More information about the
          data can be found here (link to Kaggle website).
          </p><p>
          One thing to note about the data is that Zillow does not provide rental statistics for every county in the US. However, we believe that we still have a large 
          enough sample size of counties to have meaningful results. It should also be noted that the reason for Zillow not providing statistics for all counties could be due
          to sample bias. For example, Zillow may not provide data for very low-income counties because they don't think it is necessary for their target audience.
          </p><p>
          We choose these two data sets because analyzing rent and crime rates can be used as an indicator to whether a certain area needs to focus on improving its public
          policies to offer additional help to the counties. Moreover, rent price and crime are two factors that people take into account when finding a place to live, thus
          investigating how these two factors interact would be beneficial information.
          <h4>Our Questions</h4>
          </p>The main questions that we investigated about these two data sets are:<p>
          <ol><li>How do crime rates affect rent prices in counties with particularly high and low crime rates?</li>
              <li>What is the most popular type of crime for each bracket of rent prices?</li>
              <li>How do large population counties compare to the rest of the US in terms of their crime rates?</li>
          </ol>
          </p>
          "
          
     })
     
#--------------------------------------------Q1---------------------------------------------------     
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
#-----------------------------------------------Q2-----------------------------------------------------
     output$table_fav_crime <- renderTable({
          t <- fav_crime_by_rent
          t
     })
     output$table_analysis1 <- renderText({
          p <- paste("<p>The table to the right shows the most popular crime per each category of rent prices, relative to the average crime rate
               per each crime. To find this, the following procedure was used:</p>
               <ul>
               <li>First, the total crime per each county is divided by the population of the county, in order to make the number of occurances per 
                    each crime independent of the county's population. </li>
               <li>Next, the average and standard deviation of each crime is found, using the data from each rent bracket.</li>
               <li>Then, a z-score is assigned to each crime for every rent bracket, using the averages and standard deviations assigned above</li>
               <li>Finally, for each rent bracket, the highest z-score is picked out of all the crimes, and this is decidedly the most popular type of 
               crime.</li></ul><p><br>")
          p
     })
     
     output$table_analysis2 <- renderText({
          p <- paste("<p>
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
               </p>")
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
     
<<<<<<< HEAD
#<<<<<<< HEAD
     output$q1text <- renderText({
          p <- "This is output generated text. Fill in later"
=======
     output$q2_analysis <- renderText({
          p <- "
               <p>This question is complicated, and thus requires a complicated response. When analyzing the variations of crime across a range of rent values, we are
                    not looking for a simple answer, but instead, hunting for potential trends and connections between the two. Overall this analysis brought some interesting
                    conclusions, between the overt information provided by the various rent versus crime plots, and the subtle, almost hidden information provided by the table.
               </p>
               <p>The information pulled from the table was more or less unexpected: assigning comparatively uncommon crimes like arson and rape to some of these rent brackets.
                    However, when the methodology used to gather this table is kept in mind, it is apparent that these crimes are not chosen purely on the amount of occurrences,
                    but instead the amount of occurrences relative to the other rental brackets, and the prevalence of other crimes included in this category of rent. By comparing
                    the categories together rather than displaying them on their own, this shows the subliminal trends of the crimes versus the rent, like how there are generally
                    more violent crimes in the lower brackets, while petty theft and other forms of stealing are more abundant in the upper levels. This conclusion makes sense when
                    you consider the wealth disparity faced in many counties with an expensive median rent. 
               </p>
               <p>The plots provided explicitly show trends between each type of crime specified and the rent, which gives clear insight into some of these relationships.
                    Most evident, there is an overarching trend that high crime rates are found in both high and low rent counties, with most crimes showing a bimodal distribution
                    between the two, with a minimum somewhere in the middle. Per each county, the plot shows the total occurrences of the crime divided by the population, in order
                    to give information devoid of confounders, as there is a positive relationship between the median rent of the county and its population, and therefore the individual
                    amounts of crime. Because of this, these plots provide more insightful information, and more accurately show these trends.
               </p>
               <p>Overall, the analysis of this question has been useful in showing the trends, most notably that counties with both low and high rent show above average occurrences of crime,
                    with specifically more violent crimes being committed towards the lower spectrum of rent prices ($1500 and below) and more theft related crimes towards the upper end
                    of the spectrum ($2000 and above). This conclusion does not exactly match up with our hypothesis, which expected a negative association between the median rent and general crime.
                    However when you account for large population counties with higher rent, our conclusion matches up better with our hypothesis, which estimated that cities would play a factor.
               </p>
               "
>>>>>>> e198e33cf7257fbc81dad7e5920f26ba2a886532
          p
     })
     
     output$plot_title <- renderText({
          p <- paste("How", input$crime, "Per County Population Compares to its Median Rent Price")
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

<<<<<<< HEAD
#=======

#}
#>>>>>>> c1709f4ee026788b33443c5212bcb9417febdb55
=======

>>>>>>> e198e33cf7257fbc81dad7e5920f26ba2a886532
