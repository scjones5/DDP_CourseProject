#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  levels(esoph$agegp) = seq(1, 6, 1)
  levels(esoph$alcgp) = seq(1, 4, 1)
  levels(esoph$tobgp) = seq(1, 4, 1) 
  model <- glm(cbind(ncases, ncontrols) ~ agegp + tobgp * alcgp, 
               data=esoph, family = binomial())
  
  modelPred <- reactive({
    ageGrp <- input$AgeGroup
    alcCon <- input$Alcohol
    tobCon <- input$Tobacco
    predict(model, newdata=data.frame(agegp=factor(ageGrp, 
              levels=levels(esoph$agegp)), alcgp=factor(alcCon, 
              levels=levels(esoph$alcgp)), tobgp=factor(tobCon, 
              levels=levels(esoph$tobgp))), type="response")
  })
  
  output$pred <- renderText({
    modelPred()
  })
  
  output$docs <- renderUI({
    HTML(paste("This app will determine the probability of developing esophageal cancer 
    given one's age, and amounts of alocohol and tobacco consumption. It uses
    the esoph dataset in R, which contains data from a case-control study
    in Ille-et-Vilaine, France.", "","The scales on the sliders have the following meanings:",
    "","Age group:","",
                        "1: 25-34 years",
                        "2: 35-44 years",
                        "3: 45-54 years",
                        "4: 55-64 years",
                        "5: 65-74 years",
                        "6: 75+", "",
                  "Alcohol Consumption:",
                       "1: 0-39 gm/day",
                       "2: 40-79 gm/day",
                       "3: 80-119 gm/day",
                       "4: 120+ gm/day", "",
                  "Tobacco Consumption:",
                       "1: 0-9 gm/day",
                       "2: 10-19 gm/day",
                       "3: 20-29 gm/day",
                       "4: 30+ gm/day", sep="<br/>"))
  })
})
