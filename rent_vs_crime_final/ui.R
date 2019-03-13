library(shiny)
library(shinythemes)

crime_list <- c("Murder", "Rape", "Robbery", "Aggravated_Assault", "Burglary", "Larceny", "Car_Theft", "Arson")
year_range <- range(2010:2019)

navbarPage(theme = shinytheme("flatly"), "Rent vs Crime",
           tabPanel("Introduction", h2("Rent and Crime by County"),htmlOutput("intro_page")),
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
                                                        textOutput("table_high_caption"),
                                                        tableOutput("table_high") 
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
                                                   textOutput("table_low_caption"),
                                                   tableOutput("table_low") 
                                                   
                                              )
                                              )
                                          ),
                                          tabPanel("Analysis", htmlOutput("analysistext"))
                              )
          ),
#-------------------------------------------------------------------------------------------------
           tabPanel("Question 2",
                    h3("What is the most popular type of crime per each bracket of rent prices?"),
                    tabsetPanel(type = "tabs",
                                tabPanel("Intro", htmlOutput("intro2")),
                                tabPanel("Table", 
                                   h4("Methodology:"),
                                   htmlOutput("table_analysis"),
                                   h4("Most Popular Crime, Relative to Averages:"),
                                   tableOutput("table_fav_crime")
                                ),
                                tabPanel("Plot",
                                         sidebarLayout(
                                              sidebarPanel(
                                                   selectInput("crime", "Type of Crime to Plot:", crime_list, "MURDER")
                                              ),
                                              mainPanel(
                                                  h4(textOutput("plot_title")),
                                                  plotOutput("plot_crime"))
                                              )
                                         ),
                                tabPanel("Analysis", htmlOutput("q2_analysis"))
                    )
           ),
#----------------------------------------------------------------------------------------
           tabPanel("Question 3",
                    sidebarLayout(
                         sidebarPanel(
                              radioButtons("plotType", "Plot type",
                                           c("Scatter"="p", "Line"="l")
                              )
                         ),
                         mainPanel(
                              tabsetPanel(type = "tabs",
                                          tabPanel("about", textOutput("q3text")),
                                          tabPanel("plot", plotOutput("q3_plot")),
                                          tabPanel("table", tableOutput("table3"))
                              )
                         )
                    )
           ),
           tabPanel("Conclusion")
           
)

