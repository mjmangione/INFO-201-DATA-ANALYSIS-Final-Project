library(shiny)
crime_list <- c("Murder", "Rape", "Robbery", "Aggravated Assault", "Burglary", "Larceny", "Car Theft", "Arson")
year_range <- range(2010:2019)

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

