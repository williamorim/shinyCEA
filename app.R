library(shiny)
library(ggplot2)
library(magrittr)

#minha_base <- read("caminho/para/base")

ui <- fluidPage(
  titlePanel("Shiny para o CEA"),
  sidebarLayout(
    sidebarPanel = sidebarPanel(
      selectInput(
        "varX",
        label = "Variável do eixo X",
        choices = names(mtcars),
        selected = "wt"
      ),
      selectInput(
        "varY",
        label = "Variável do eixo Y",
        choices = names(mtcars),
        selected = "mgp"
      )
      # uiOutput("select_y")
    ),
    mainPanel = mainPanel(
      plotOutput("grafico")
    )
  )
)

server <- function(input, output, session) {

  # observe({
  #   escolhas <- names(mtcars)
  #   escolhas <- escolhas[escolhas != input$varX]
  #   updateSelectInput(
  #     session,
  #     "varY",
  #     choices = escolhas
  #   )
  # })

  # output$select_y <- renderUI({
  #
  #   escolhas <- names(mtcars)
  #   escolhas <- escolhas[escolhas != input$varX]
  #
  #   # escolhas <- mtcars %>%
  #   #   dplyr::select(-input$varX) %>%
  #   #   names()
  #
  #   selectInput(
  #     "varY",
  #     label = "Variável do eixo Y",
  #     choices = escolhas,
  #     selected = "mgp"
  #   )
  # })


  output$grafico <- renderPlot({
    mtcars %>%
      # mutate(mpg = mpg*0.7) %>%
      ggplot(aes(x = .data[[input$varX]], y = .data[[input$varY]])) +
      geom_point()
  })

}

shinyApp(ui, server)
