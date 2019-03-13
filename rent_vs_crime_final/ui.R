source("analysis_final.R")
library(shiny)
library(shinythemes)  

crime_list <- c("Murder", "Rape", "Robbery", "Aggravated_Assault", "Burglary", "Larceny", "Car Theft", "Arson")
year_range <- range(2010:2019)

navbarPage(theme = shinytheme("flatly"), "Rent vs Crime", 
           tabPanel("Introduction", h2(class = "header", "Rent and Crime by County"),
               fluidRow(
                    column(1), column(10, htmlOutput("intro_page")), column(1)
               )
           ),
#-----------------------------------------------------------------------------------------------------------------------
           tabPanel("Question 1",
                    h3("How Does High or Low Crime Affect Rent Prices in Those Areas?"),
                              tabsetPanel(type = "tabs",
                                     tabPanel("Intro", h4(class = "header", "Introduction"),
                                     fluidRow(
                                          column(1), column(10, textOutput("q1text")), column(1)
                                     )),
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
                                     tabPanel("Analysis", h4(class = "header", "Analysis"), 
                                     fluidRow(
                                          column(1), column(10,htmlOutput("analysistext")), column(1)
                                     ))
                              )
          ),
#-------------------------------------------------------------------------------------------------
           tabPanel("Question 2",
                    h3("What is the Most Popular Type of Crime Per Each Bracket of Rent Prices?"),
                    tabsetPanel(type = "tabs",
                                tabPanel("Intro", h4(class = "header", "Introduction"),
                                fluidRow(
                                     column(1), column(10, htmlOutput("intro2")), column(1)
                                )),
                                tabPanel("Table", fluidRow(
                                   column(1),
                                   column(5, h4(class ="header", "Methodology:"),
                                          htmlOutput("table_analysis1")),
                                   column(1),
                                   column(4, h4("Most Popular Crime, Relative to Averages:"),
                                             tableOutput("table_fav_crime")),
                                   column(1)
                                   
                                ),
                                fluidRow(column(1), column(10, htmlOutput("table_analysis2")), column(1))
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
                                tabPanel("Analysis", h4(class = "header", "Introduction"),
                                fluidRow(
                                     column(1), column(10, htmlOutput("q2_analysis")), column(1)
                                ))
                    )
           ),
#----------------------------------------------------------------------------------------
           tabPanel("Question 3",
                    h3("How do Large Population Counties Compare to the Rest of the US in Terms of Their Crime Rates?"),
                    tabsetPanel(type = "tabs",
                                tabPanel("Intro", textOutput("q3text")),
                                tabPanel("Plot 1", plotOutput("Top_counties")),
                                tabPanel("Plot 2", plotOutput("Bottom_counties")),
                                tabPanel("Table", 
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
                                                  tableOutput("table_city_vs_crimes")
                                              )
                                         )
                                ),
                                tabPanel("Analysis")
                    )
                    
           ),
           tabPanel("Conclusion"),
           includeCSS("main.css")
)

