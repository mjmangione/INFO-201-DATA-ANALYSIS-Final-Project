library(shiny)
crime_list <- c("Murder", "Rape", "Robbery", "Aggravated_Assault", "Burglary", "Larceny", "Car_Theft", "Arson")

navbarPage("Rent vs Crime 2",
           tabPanel("Question 1",
                    h3("What is the most popular type of crime per each grouping of Rent?"),
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
                    h3("What is the most popular type of crime per each bracket of rent prices?"),
                    tabsetPanel(type = "tabs",
                                tabPanel("intro", htmlOutput("intro2")),
                                tabPanel("table", 
                                         sidebarLayout(
                                             sidebarPanel(
                                                  
                                             ),
                                             mainPanel(
                                                  h4("Methodology:"),
                                                  htmlOutput("table_analysis"),
                                                  h4("Most Popular Crime, Relative to Averages:"),
                                                  tableOutput("table_fav_crime")
                                             )
                                         )
                                ),
                                tabPanel("plot",
                                         sidebarLayout(
                                              sidebarPanel(
                                                   selectInput("crime", "Type of Crime to Plot:", crime_list, "MURDER")
                                              ),
                                              mainPanel(
                                                  h4(textOutput("plot_title")),
                                                  plotOutput("plot_crime"))
                                              )
                                         ),
                                tabPanel("analysis")
                    )
           ),
#----------------------------------------------------------------------------------------
           tabPanel("Question3",
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
           )
           
)

