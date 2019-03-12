
library(shiny)
# Define UI for application that draws a histogram
ui <- navbarPage("Rent vs Crime",
#-------------------------- ABOUT PANEL ---------------------------------------#
     tabPanel("Home",
              h1("RENT PRICES VS CRIME: CORRELATIONS")
     ),              
#-----------------------------QUESTION 1-------------------------------------#
     tabPanel("Question 1",     
          sidebarLayout(
               sidebarPanel(
                    sliderInput("bins", "Number of bins:", min = 1, max = 50, value = 30)
               ),
               mainPanel(
                    tabsetPanel(type = "tabs",
                        tabPanel("about",
                        helpText(
                              "We wanted to take a look at how rent prices were affected by crime rates for counties that had particularly high and low crime rates for 2016. 
                              We analyzed the rent prices for the top 5 counties by crime rate and the 5 counties with the lowest crime rates for 2016. There are other factors 
                              that may affect rent prices fluctuating (such as inflation) but we did not consider those variables in our analysis. Prior to any data analysis, we 
                              believe that there will be a correlation between rent prices and crime rates. We think that area's with particularly high crime rates will have 
                              their rent prices decline, and vice versa. "),
                         helpText(
                              "The five counties with the highest crime rates per 100,000 people as of 2016 are District of Columbia (DC), Philadelphia County (PA), and Shelby, 
                              Madison, and Davidson counties, all in Tennessee. It is interesting to note one state having three counties on this list, which probably signifies 
                              that some public policies need to change in Tennessee. Out of the five highest crimerate counties shown, all five counties had their average rent 
                              price go down at least one year after 2016. The most significant of these declines was in Philadelphia County, who saw its average rent price go 
                              down 75 dollars in 2016 due to having a crime rate of 1150 per 100,000 people. Although a small sample size, these observations support the conclusion 
                              that having a high crime rate will lead to rent prices in the county declining. "),
                         helpText("The five counties with the lowest crime rates per 100,000 people as of 2016 are Lafayette County (MS), Hamilton and Boone Counties (IN), Tolland 
                              County (CT), and Hunterdon County (NJ). Out of these five counties, only one county (Lafayette County in Mississippi) saw a decrease in its average
                              rent price in any year after 2016. This decrease in rent value happened between 2018-2019, and was probably affected by other variables. For the most 
                              part however, these five counties saw a steady increase in their rent prices after 2016. The most significant of these increases was in Hunterdon 
                              County (NJ), as after it had one of the top 5 lowest crime rates for any county in the US in 2016, its average rent saw a steady increase by an average 
                              of 100 dollars a month until 2019. These observations support the conclusion that having a low crime rate will lead to rent prices in the county increasing."),
                         helpText("One major takeaway from this analysis is that a high crime rate does not necessarily correspond to a low average rent value. For example, the District of 
                              Columbia landed as one of the five counties with the highest crime rates for 2016, yet it also consistently has a higher rent value than any county from 
                              the five lowest crime rates. The District of Columbia in 2016 had the second highest crime rate in the country at 1216 per 100,000 people, yet also had 
                              the highest rent value analyzed for this question at $2,536. "),
                         helpText("Thus, high crime does not always signify cheap rent. However, a high crime rate does consistently correspond to a decrease in average rent value for years
                              to come, so cheaper rent relative to what it was before. This analysis supports our hypothesis that there is an inverse correlation between crime rate and
                              rent prices inclining or declining. A high crime rate consistently leads to a decline in rent prices, and vice versa.")
                         ),
                         tabPanel("plot", plotOutput("distPlot")),
                         tabPanel("Table", tableOutput("high_crimes_table"))
                    )
               )
          )
               
     ),
#-----------------------------QUESTION 2 -------------------------------------#
     tabPanel("Question 2",
          h3("Q2: MOST COMMON CRIME?"),
          helpText(""),
          sidebarLayout(
               sidebarPanel(
                    sliderInput("bins", "Number of bins:", min = 1, max = 50, value = 30)
               ),                  
               mainPanel(
                    tabsetPanel(type = "tabs",
                                tabPanel("About", helpText("INSERT PARAGRAPH")),
                                tabPanel("Plot", plotOutput("distPlot")),
                                tabPanel("Table", helpText("INSERT DATA FRAME"))
                    )
               )
          )
     ),
#----------------------------QUESTION 3 ---------------------------------------#
     tabPanel("Question 3",
         sidebarLayout(
              sidebarPanel(
                   sliderInput("bins", "Number of bins:", min = 1, max = 50, value = 30)
              ),
              mainPanel(
                   tabsetPanel(type = "tabs",
                               tabPanel("About", helpText("INSERT PARAGRAPH")),
                               tabPanel("Plot", plotOutput("distPlot")),
                               tabPanel("Table", helpText("INSERT DATA FRAME"))
                   )
              )
         )
     )
#----------------------------END---------------------------------
)
