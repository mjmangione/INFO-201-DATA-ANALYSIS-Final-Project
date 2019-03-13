source("analysis_final.R")
library(shiny)
crime_list <- c("Murder", "Rape", "Robbery", "Aggravated_Assault", "Burglary", "Larceny", "Car_Theft", "Arson")

navbarPage("Rent vs Crime 2",
           tabPanel("Question 1",
                    sidebarLayout(
                         sidebarPanel(
                              radioButtons("plotType", "Plot type",
                                           c("Scatter"="p", "Line"="l")
                              )
                         ),
                         mainPanel(
                              tabsetPanel(type = "tabs",
                                          tabPanel("about", textOutput("q1text")),
                                          tabPanel("high crime", tableOutput("table_high")),
                                          tabPanel("low crime", tableOutput("table_low"))
                              )
                         )
                    )
           ),
#-------------------------------------------------------------------------------------------------
           tabPanel("Question2",
                    sidebarLayout(
                         sidebarPanel(
                              selectInput("crime", "Type of Crime:", crime_list, "MURDER")
                         ),
                         mainPanel(
                              tabsetPanel(type = "tabs",
                                          tabPanel("about", textOutput("q2text")),
                                          tabPanel("plot", plotOutput("plot_crime")),
                                          tabPanel("table", tableOutput("table_fav_crime"))
                              )
                         )
                    )
           ),
#----------------------------------------------------------------------------------------
           tabPanel("Question3",
                    sidebarLayout(
                         sidebarPanel(
                           sliderInput(
                             "population",
                             label = "Population",
                             min = population_range[1],
                             max = population_range[2],
                             value = population
                           ),
                           selectInput("crime_types", "Type of Crime:", crime_list)
                         ),
                         mainPanel(
                              tabsetPanel(type = "tabs",
                                          tabPanel("about", textOutput("q3text")),
                                          tabPanel("plot", plotOutput("Top_counties"), plotOutput("Bottom_counties")),
                                          tabPanel("table", tableOutput("table_city_vs_crimes"))
                              )
                         )
                    )
           )
           
)

