#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application 
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Predict Esophageal Cancer Rates"),
  
  # Sidebar with a slider input for age group
  sidebarLayout(
    sidebarPanel(
       sliderInput("AgeGroup",
                   "Age Group:",
                   min = 1,
                   max = 6,
                   value = 1),
       sliderInput("Alcohol", 
                   "Alcohol Consumption:", 
                   min = 1,
                   max = 4, 
                   value = 1),
       sliderInput("Tobacco", 
                   "Tobacco Consumption:",
                   min = 1, 
                   max = 4, 
                   value = 1)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
        tabsetPanel(type="tabs",
                    tabPanel("Prediction", br(), textOutput("pred")),
                    tabPanel("Help", br(), htmlOutput("docs"))
        )
         )
    )
       )
    )
