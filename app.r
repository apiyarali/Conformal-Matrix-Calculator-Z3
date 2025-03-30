#Conformal Matrices
library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(matlib)
source("jaxmat.R")   #for displaying mathematics

stylesheet <- tags$head(tags$style(HTML('
    .main-header .logo {
      font-family: "Georgia", Times, "Times New Roman", serif;
      font-weight: bold;
      font-size: 24px;
    }
    
    #matSol{
      font-size: 24px;
    }
  ')
))
#The user interface
header <- dashboardHeader(title = "Conformal Matrices",
                          titleWidth = 500)
sidebar <- dashboardSidebar(disable = TRUE)
body <- dashboardBody(
  fluidRow(stylesheet,
    column(width=3,
           h3("Nine 2 x 2 Conformal Matrices in ", jaxI("Z_3")),br(),
           uiOutput("mat1"),br(),
           uiOutput("mat2"),br(),
           uiOutput("mat3"),br(),
           uiOutput("mat4"),br(),
           uiOutput("mat5"),br(),
           uiOutput("mat6"),br(),
           uiOutput("mat7"),br(),
           uiOutput("mat8"),br()
    ),
    column(width=3,
           br(),
           selectInput("left",NULL,c("X","X2","X3","X4","X5","X6","X7","X8"),selected = "X"),
           selectize = FALSE,
           br(),
           actionBttn("btnequals","Equals"),br(),br(),
           uiOutput("matSol")
    ),
    column(width=2,
           br(),
           awesomeRadio("op",NULL,c("+","-","*","/"), width = "100px"),
    ),
    column(width=3,
           br(),
           selectInput("right",NULL,c("X","X2","X3","X4","X5","X6","X7","X8"),selected = "X"),
           selectize = FALSE
    )
  )
)
ui <- dashboardPage(header, sidebar, body, skin = "green") #other colors available

#Functions that implement the mathematics
#This file must go into the same directory as app.R
#source(".R")
#Any images, audio, or stylesheet must go into a subfolder named www

#Additional functions are OK here, but no variables


server <- function(session, input, output) {
  #Variables that are shared among server functions (use <<-)
  
  X1 <- matrix(c(1,2,
                 1,1), nrow=2, byrow=TRUE)
  
  X2 <- (X1%*%X1)%%3
  X3 <- (X2%*%X1)%%3
  X4 <- (X3%*%X1)%%3
  X5 <- (X4%*%X1)%%3
  X6 <- (X5%*%X1)%%3
  X7 <- (X6%*%X1)%%3
  X8 <- (X7%*%X1)%%3
  
  X1I <- inv(X1)
  
  X2I <- inv(X2)
  X2I[1,2] <- 2
  
  X3I <- inv(X3)
  
  X4I <- inv(X4)
  X4I[1,1] <- 2
  X4I[2,2] <- 2
  
  X5I <- inv(X5)
  X5I[1,2] <- -2
  
  X6I <- inv(X6)
  X6I[2,1] <- 2
  
  X7I <- inv(X7)
  X7I[2,1] <- -2
  
  X8I <- inv(X8)
  
  #Initialization
  
  output$mat1 <- renderUI(jax.matrix(X1, name = "X"))
  output$mat2 <- renderUI(jax.matrix(X2, name = "X2"))
  output$mat3 <- renderUI(jax.matrix(X3, name = "X3"))
  output$mat4 <- renderUI(jax.matrix(X4, name = "X4"))
  output$mat5 <- renderUI(jax.matrix(X5, name = "X5"))
  output$mat6 <- renderUI(jax.matrix(X6, name = "X6"))
  output$mat7 <- renderUI(jax.matrix(X7, name = "X7"))
  output$mat8 <- renderUI(jax.matrix(X8, name = "X8"))
  
  observeEvent(input$left,{
    if (input$left == "X"){
      sleft <<- X1
    }
    
    if (input$left == "X2"){
      sleft <<- X2
    }
    
    if (input$left == "X3"){
      sleft <<- X3
    }
    
    if (input$left == "X4"){
      sleft <<- X4
    }
    
    if (input$left == "X5"){
      sleft <<- X5
    }
    
    if (input$left == "X6"){
      sleft <<- X6
    }
    
    if (input$left == "X7"){
      sleft <<- X7
    }
    
    if (input$left == "X8"){
      sleft <<- X8
    }
    
  })
  
  observeEvent(input$right,{
    if (input$right == "X"){
      sright <<- X1
      srightI <<- X1I%%3
    }
    
    if (input$right == "X2"){
      sright <<- X2
      srightI <<- X2I%%3
    }
    
    if (input$right == "X3"){
      sright <<- X3
      srightI <<- X3I%%3
    }
    
    if (input$right == "X4"){
      sright <<- X4
      srightI <<- X4I%%3
    }
    
    if (input$right == "X5"){
      sright <<- X5
      srightI <<- X5I%%3
    }
    
    if (input$right == "X6"){
      sright <<- X6
      srightI <<- X6I%%3
    }
    
    if (input$right == "X7"){
      sright <<- X7
      srightI <<- X7I%%3
    }
    
    if (input$right == "X8"){
      sright <<- X8
      srightI <<- X8I%%3
    }
    
  })
  
  #Functions that respond to events in the input
  
  observeEvent(input$btnequals,{

    if (input$op == "+"){
      M <- (sleft + sright)%%3
      output$matSol <- renderUI(jax.matrix(M, name = "M"))
    }
    
    if (input$op == "-"){
      M <- (sleft - sright)%%3
      output$matSol <- renderUI(jax.matrix(M, name = "M"))
    }
    
    if (input$op == "*"){
      M <- (sleft%*%sright)%%3
      output$matSol <- renderUI(jax.matrix(M, name = "M"))
    }
    
    if (input$op == "/"){
      M <- (sleft%*%srightI)%%3
      output$matSol <- renderUI(jax.matrix(M, name = "M"))
    }
  })
  
 
}

#Run the app
shinyApp(ui = ui, server = server)