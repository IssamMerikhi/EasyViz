library(shiny)

# Define UI for miles per gallon app ----
ui <- pageWithSidebar(
  
  # App title ----
  headerPanel(title = "First Try"),
  
  # Sidebar panel for inputs ----
  sidebarPanel(),
  
  # Main panel for displaying outputs ----
  mainPanel(plotOutput("correlation_plot"), width = 8)
)

# Define server logic to plot various variables against mpg ----
server <- function(input, output) {
  output$correlation_plot = renderPlot({
    plot(iris$Sepal.Length, iris$Petal.Length)
  })
}

shinyApp(ui, server)