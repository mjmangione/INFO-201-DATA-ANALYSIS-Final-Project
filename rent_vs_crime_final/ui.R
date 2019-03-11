#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
# Define UI for application that draws a histogram
shinyUI(navbarPage("Old Faithful Geyser Data", theme = "www/main.css",
#-------------------------- ABOUT PANEL ---------------------------------------#
     tabPanel("Home",
              h1("RENT PRICES VS CRIME: CORRELATIONS")
     ),              
#-----------------------------QUESTION 1 -------------------------------------#
     tabPanel("Question 1",
          sidebarLayout(
               sidebarPanel(
                    sliderInput("bins", "Number of bins:", min = 1, max = 50, value = 30)
               ),
               mainPanel(
                    plotOutput("distPlot")
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
                    helpText("JUST CHECKING TO SEE IF THIS WILL WORK")
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
                   plotOutput("distPlot")
              )
         )
     )
#----------------------------END---------------------------------
))
