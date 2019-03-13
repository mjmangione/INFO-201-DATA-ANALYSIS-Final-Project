source("analysis_final.R")
library(shiny)
<<<<<<< HEAD
crime_list <- c("Murder", "Rape", "Robbery", "Aggravated_Assault", "Burglary", "Larceny", "Car_Theft", "Arson")
=======
crime_list <- c("Murder", "Rape", "Robbery", "Aggravated Assault", "Burglary", "Larceny", "Car Theft", "Arson")
year_range <- range(2010:2019)
>>>>>>> c1709f4ee026788b33443c5212bcb9417febdb55

navbarPage("Rent vs Crime 2",
           tabPanel("Question 1",
                    h3("How does high or low crime affect rent prices in those areas?"),
                              tabsetPanel(type = "tabs",
                                          tabPanel("Intro", textOutput("q1text")),
                                          tabPanel("Table 1", 
                                                   sidebarLayout(
                                                     sidebarPanel(
                                                       sliderInput(inputId = "years", label = "Years", 
                                                                   min = 2010, max = 2019, value = year_range, sep = "")
                                                     ),
                                                      mainPanel (
                                                        h4("Counties with High Crime Rates"),
                                                        tableOutput("table_high"), 
                                                        textOutput("table_high_caption")
                                                      )
                                                   )
                                          ),
                                          tabPanel("Table 2", 
                                                  sidebarLayout(
                                                    sidebarPanel(
                                                       sliderInput(inputId = "years", label = "Years", 
                                                                   min = 2010, max = 2019, value = year_range, sep = "")
                                                    ),
                                              mainPanel (
                                                   h4("Counties with Low Crime Rates"), 
                                                   tableOutput("table_low"), 
                                                   textOutput("table_low_caption")
                                              )
                                              )
                                          ),
                                          tabPanel("Analysis", htmlOutput("analysistext"))
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

