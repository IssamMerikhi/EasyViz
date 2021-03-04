library(tidyr)
library(ggplot2)
library(shiny)
library(shinydashboard)
library(heatmaply)
source("cleandata.r")



df.team_data <- expand.grid(teams = c("Team A", "Team B", "Team C", "Team D")
                            ,metrics = c("Metric 1", "Metric 2", "Metric 3", "Metric 4", "Metric 5")
)
# add variable: performance
set.seed(41)
df.team_data$performance <- rnorm(nrow(df.team_data))






header <- dashboardHeader(title = "EasyViz")


sidebar <- dashboardSidebar(
  sidebarMenu(
    fileInput("file", "Upload", multiple = TRUE),
    menuItem("Histogram", tabName = "file", icon = icon("dashboard"))
    

  )
)



body <- dashboardBody(
  tabItems(
    tabItem(tabName = "file", plotOutput("input_file"))
  )
)












ui <- dashboardPage(header, sidebar, body)

server <- function(input, output) {
  
  
  
  
  output$input_file <- renderPlot({
    file_to_read = input$file
    if(is.null(file_to_read)){
      return()
    }
    df = read.csv(file_to_read$datapath)
    a = as.numeric(df[,2], drop=FALSE)
    barplot(a)
  })
  
  
  
  
  
}

shinyApp(ui, server)


