library(tidyr)
library(ggplot2)
library(shiny)
library(shinydashboard)


header <- dashboardHeader(title = "First RShiny Dashboard")


sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
    menuItem("Widgets", tabName = "widgets", icon = icon("th"))
    )
  )



body <- dashboardBody(
  tabItems(
    tabItem(tabName = "dashboard",
            fluidRow(box(plotOutput("plot1", height = 500),
                         title = "Histogram")))
    )
  )












ui <- dashboardPage(header, sidebar, body)

server <- function(input, output) {
  
  output$plot1 <- renderPlot({
    ggplot(gather(mtcars), aes(value)) + 
      geom_bar() + 
      facet_wrap(~key, scales = 'free_x')
  })
  
}

shinyApp(ui, server)


