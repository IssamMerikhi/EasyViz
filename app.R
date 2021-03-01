df = read.csv("C:/Users/Elève/Desktop/PL.csv")
library(tidyr)
library(ggplot2)
library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(),
  dashboardSidebar(),
  dashboardBody()
)

server <- function(input, output) { }

shinyApp(ui, server)


ggplot(gather(mtcars), aes(value)) + 
  geom_bar() + 
  facet_wrap(~key, scales = 'free_x')