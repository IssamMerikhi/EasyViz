library(tidyr)
library(ggplot2)
library(shiny)
library(shinydashboard)
library(heatmaply)

df.team_data <- expand.grid(teams = c("Team A", "Team B", "Team C", "Team D")
                            ,metrics = c("Metric 1", "Metric 2", "Metric 3", "Metric 4", "Metric 5")
)
# add variable: performance
set.seed(41)
df.team_data$performance <- rnorm(nrow(df.team_data))






header <- dashboardHeader(title = "First RShiny Dashboard")


sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Histogram", tabName = "hist", icon = icon("dashboard")),
    menuItem("Heatmap", tabName = "heat", icon = icon("th"))
    )
  )



body <- dashboardBody(
  tabItems(
    tabItem(tabName = "hist",
            fluidRow(box(plotOutput("plot1", height = 400, width = 400),
                         title = "Histogram"))),
    
    tabItem(tabName = "heat",
            fluidRow(box(plotOutput("plot2", height = 400, width = 400),
                         title = "Heatmap")))
    )
  )












ui <- dashboardPage(header, sidebar, body)

server <- function(input, output) {
  
  output$plot1 <- renderPlot({
    ggplot(gather(mtcars), aes(value)) + 
      geom_bar() + 
      facet_wrap(~key, scales = 'free_x')
  })
  
  
  output$plot2 <- renderPlot({ggplot(data = df.team_data, aes(x = metrics, y = teams)) +
      geom_tile(aes(fill = performance)) })
  
}

shinyApp(ui, server)


