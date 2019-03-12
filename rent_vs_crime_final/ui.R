library(shiny)
crime_list <- c("Murder", "Rape", "Robbery", "Aggravated Assault", "Burglary", "Larceny", "Car Theft", "Arson")

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

