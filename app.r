library(tidyr)
library(ggplot2)
library(shiny)
library(shinydashboard)
library(heatmaply)
source("cleandata.r")
source("graphics.r")



df.team_data <- expand.grid(teams = c("Team A", "Team B", "Team C", "Team D")
                            ,metrics = c("Metric 1", "Metric 2", "Metric 3", "Metric 4", "Metric 5")
)
# add variable: performance
set.seed(41)
df.team_data$performance <- rnorm(nrow(df.team_data))






header <- dashboardHeader(title = "EasyViz", dropdownMenuOutput(outputId = "menu"))


sidebar <- dashboardSidebar(
  sidebarMenu(
    fileInput(inputId = "file", "Upload", multiple = TRUE),
    menuItem("Data", tabName = "data", icon = icon("database")),
    menuItem("Histogram", tabName = "file", icon = icon("chart-bar")),
    menuItem("Heatmap", tabName = "heat", icon = icon("chess-board")),
    menuItem("Density", tabName = "dens", icon = icon("chart-line")),
    menuItem("Network", tabName = "net", icon = icon("sitemap"))
    
    

  )
)



body <- dashboardBody(
  fluidRow(
    tabItems(
      
      tabItem(tabName = "data", tableOutput(outputId = "tabledata")),
      tabItem(tabName = "file", plotOutput(outputId = "input_file")),
      tabItem(tabName = "heat", plotOutput(outputId = "heatm")),
      tabItem(tabName = "dens", plotOutput(outputId = "densi")),
      tabItem(tabName = "net", plotOutput(outputId = "netw"))
      
      )
    )
  )












ui <- dashboardPage(header, sidebar, body)

server <- function(input, output) {
  
  output$tabledata <- renderTable({
    file_to_read = input$file
    if(is.null(file_to_read)){
      return()
    }
    c = read.csv(file_to_read$datapath)
    cleanData(c)
    
  })
  
  
  output$input_file <- renderPlot({
    file_to_read = input$file
    if(is.null(file_to_read)){
      return()
    }
    df = read.csv(file_to_read$datapath)
    a = as.numeric(df[,2], drop=FALSE)
    barplot(a)
  })
  
  
  output$heatm <- renderPlot({
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


}

shinyApp(ui, server)
