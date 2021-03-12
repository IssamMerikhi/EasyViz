library(tidyr)
library(ggplot2)
library(shiny)
library(shinydashboard)
library(heatmaply)
library(GGally)
source("cleandata.r")
source("graphics.r")


title = tags$span(tags$img(src="favicon.png",
                        height = '50',
                        width = '50'),
              'Easy Viz')



header <- dashboardHeader(title = title, dropdownMenuOutput(outputId = "menu"))


sidebar <- dashboardSidebar(
  sidebarMenu(
    fileInput(inputId = "file", "Upload", multiple = TRUE),
    menuItem("Data", tabName = "data", icon = icon("database")),
    menuItem("Scatter Matrix", tabName = "scat", icon = icon("cloud")),
    menuItem("Heatmap", tabName = "heat", icon = icon("chess-board")),
    menuItem("Density", tabName = "dens", icon = icon("chart-line")),
    menuItem("Network", tabName = "net", icon = icon("sitemap")),
    menuItem("Built By", tabName = "bb", icon = icon("tools"))
    
    

  )
)



body <- dashboardBody(
  fluidRow(
    tabItems(
      
      tabItem(tabName = "data",
              fluidRow(infoBoxOutput(outputId = "IBdata", width = 10)),
              fluidRow(box(tableOutput(outputId = "tabledata"), width = 10))),
      tabItem(tabName = "scat",
              fluidRow(infoBoxOutput(outputId = "IBscat", width = 10)),
              fluidRow(box(plotOutput(outputId = "scatt"), width = 10))),
      tabItem(tabName = "heat",
              fluidRow(infoBoxOutput(outputId = "IBheat", width = 10)),
              fluidRow(box(plotOutput(outputId = "heatm2"), width = 10))),
      tabItem(tabName = "dens",
              fluidRow(infoBoxOutput(outputId = "IBdens", width = 10)),
              fluidRow(box(plotOutput(outputId = "densi"), width = 10))),
      tabItem(tabName = "net",
              fluidRow(infoBoxOutput(outputId = "IBnet", width = 10)),
              fluidRow(box(plotOutput(outputId = "netw"), width = 10))),
      tabItem(tabName = "bb",
              fluidRow(infoBoxOutput(outputId = "IBbb", width = 10)))
      
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
  
  
  output$scatt <- renderPlot({
    file_to_read = input$file
    if(is.null(file_to_read)){
      return()
    }
    df = read.csv(file_to_read$datapath)
    scattermatrix(df)
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
            value = "Processing",
            subtitle = "Your cleaned Data. Keep all the numeric variables.",
            icon = shiny::icon("database"),
            fill = TRUE)
  })
  
  

  output$IBheat <- renderInfoBox({
    infoBox(title = "Heatmap InfoBox",
            value = "Correlation",
            subtitle = "Heatmap plot. Clearest cases shows the positive correlation between variables. Darkest cases shows negative correlation.",
            icon = shiny::icon("chess-board"),
            fill = TRUE)
  })
  
  
  output$IBscat <- renderInfoBox({
    infoBox(title = "Scatter InfoBox",
            value = "Distribution",
            subtitle = "Scatter Matrix plot. Visualise scatter plots of all your features.",
            icon = shiny::icon("cloud"),
            fill = TRUE)
  })
  
  
  output$IBdens <- renderInfoBox({
    infoBox(title = "Histogram InfoBox",
            value = "Distribution",
            subtitle = "Density plot. All your densities are plots one by one.",
            icon = shiny::icon("chart-line"),
            fill = TRUE)
  })
  
  
  
  output$IBnet <- renderInfoBox({
    infoBox(title = "Network InfoBox",
            value = "Connexion",
            subtitle = "Visualise the network and connexions of your variables in your data",
            icon = shiny::icon("sitemap"),
            color = 'orange',
            fill = TRUE)
  })
  
  output$IBbb <- renderInfoBox({
    infoBox(title = "Built By",
            value = "Issam Merikhi - 2021 - All right reserved",
            subtitle = "UDS - University of Strasbourg",
            icon = shiny::icon("tools"),
            color = 'green',
            href = "https://github.com/IssamMerikhi",
            fill = TRUE)
  })
  

  
  
  
  
  
  
  
}

shinyApp(ui, server)


