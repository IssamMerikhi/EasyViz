library(tidyr)
library(ggplot2)
library(shiny)
library(shinydashboard)
library(heatmaply)
source("cleandata.r")
source("graphics.r")






header <- dashboardHeader(title = "EasyViz", dropdownMenuOutput(outputId = "menu"))


sidebar <- dashboardSidebar(
  sidebarMenu(
    fileInput(inputId = "file", "Upload", multiple = TRUE),
    menuItem("Data", tabName = "data", icon = icon("database")),
    menuItem("Histogram", tabName = "hist", icon = icon("chart-bar")),
    menuItem("Heatmap", tabName = "heat", icon = icon("chess-board")),
    menuItem("Density", tabName = "dens", icon = icon("chart-line")),
    menuItem("Network", tabName = "net", icon = icon("sitemap"))
    
    

  )
)



body <- dashboardBody(
  fluidRow(
    tabItems(
      
      tabItem(tabName = "data", h2 = "Your clear Data", tableOutput(outputId = "tabledata")),
      tabItem(tabName = "hist",
              fluidRow(infoBoxOutput(outputId = "IBhist", width = 10)),
              fluidRow(box(plotOutput(outputId = "histo")))),
      tabItem(tabName = "heat",
              fluidRow(infoBoxOutput(outputId = "IBheat", width = 10)),
              fluidRow(box(plotOutput(outputId = "heatm2", width = 20, height = "600px")))),
      tabItem(tabName = "dens", plotOutput(outputId = "densi")),
      tabItem(tabName = "net", plotOutput(outputId = "netw"))
      
      )
    )
  )











ui <- dashboardPage(header, sidebar, body, skin = "black")

server <- function(input, output) {
  
  output$tabledata <- renderTable({
    file_to_read = input$file
    if(is.null(file_to_read)){
      return()
    }
    c = read.csv(file_to_read$datapath)
    cleanData(c)
    
  })
  
  
  output$histo <- renderPlot({
    file_to_read = input$file
    if(is.null(file_to_read)){
      return()
    }
    df = read.csv(file_to_read$datapath)
    a = as.numeric(df[,2], drop=FALSE)
    barplot(a)
  })
  
  

  
  
  output$heatm2 <- renderPlot({
    file_to_read = input$file
    if(is.null(file_to_read)){
      return()
    }
    df = read.csv(file_to_read$datapath)
    df = cleanData(df)
    heatgraph(df)
  })
  
  
  
  
  output$densi <- renderPlot({
    file_to_read = input$file
    if(is.null(file_to_read)){
      return()
    }
    df = read.csv(file_to_read$datapath)
    densgraph(df)
  })
  
  
  output$netw <- renderPlot({
    file_to_read = input$file
    if(is.null(file_to_read)){
      return()
    }
    df = read.csv(file_to_read$datapath)
    net(df)
  })


  output$IBheat <- renderInfoBox({
    infoBox(title = "Heatmap InfoBox",
            subtitle = "Your Heatmap sucks",
            icon = shiny::icon("chess-board"),
            fill = TRUE)
  })
  
  
  output$IBhist <- renderInfoBox({
    infoBox(title = "Histogram InfoBox",
            subtitle = "Your Histogram sucks",
            icon = shiny::icon("chart-bar"),
            fill = TRUE)
  })
  
  
  
  
  
  
  
  
  
}

shinyApp(ui, server)
