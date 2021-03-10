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
      
      tabItem(tabName = "data",
              fluidRow(infoBoxOutput(outputId = "IBdata", width = 10)),
              fluidRow(box(tableOutput(outputId = "tabledata")))),
      tabItem(tabName = "hist",
              fluidRow(infoBoxOutput(outputId = "IBhist", width = 10)),
              fluidRow(box(plotOutput(outputId = "histo"), width = 10))),
      tabItem(tabName = "heat",
              fluidRow(infoBoxOutput(outputId = "IBheat", width = 10)),
              fluidRow(box(plotOutput(outputId = "heatm2"), width = 10))),
      tabItem(tabName = "dens",
              fluidRow(infoBoxOutput(outputId = "IBdens", width = 10)),
              fluidRow(box(plotOutput(outputId = "densi"), width = 10))),
      tabItem(tabName = "net",
              fluidRow(infoBoxOutput(outputId = "IBnet", width = 10)),
              fluidRow(box(plotOutput(outputId = "netw"), width = 10)))
      
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

  
  output$IBdata <- renderInfoBox({
    infoBox(title = "Data InfoBox",
            subtitle = "Your cleaned Data",
            icon = shiny::icon("database"),
            fill = TRUE)
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
  
  
  output$IBdens <- renderInfoBox({
    infoBox(title = "Histogram InfoBox",
            subtitle = "Your Histogram sucks",
            icon = shiny::icon("chart-line"),
            fill = TRUE)
  })
  
  
  
  output$IBnet <- renderInfoBox({
    infoBox(title = "Network InfoBox",
            subtitle = "Visualise your network Data",
            icon = shiny::icon("sitemap"),
            color = 'orange',
            fill = TRUE)
  })
  
  
  
  
  
  
  
  
}

shinyApp(ui, server)
