library(shiny)
library(RcppCNPy)
library(ggplot2)

# UI ----
ui <- fluidPage(
  titlePanel("Accuracy Comparison: DeepRIG vs STGRNS"),
  sidebarLayout(
    sidebarPanel(
      fileInput("yTrue", "Upload True Labels (y_test .npy)", accept = ".npy"),
      fileInput("deepPred", "Upload DeepRIG Predictions (.npy)", accept = ".npy"),
      fileInput("stgrnsPred", "Upload STGRNS Predictions (.npy)", accept = ".npy"),
      width = 3
    ),
    mainPanel(
      verbatimTextOutput("accText"),
      plotOutput("accPlot"),
      width = 9
    )
  )
)

# Server ----
server <- function(input, output) {
  # Reactive loaders
  yTrue <- reactive({
    req(input$yTrue)
    as.numeric(RcppCNPy::npyLoad(input$yTrue$datapath))
  })
  deepPred <- reactive({
    req(input$deepPred)
    as.numeric(RcppCNPy::npyLoad(input$deepPred$datapath))
  })
  stgrnsPred <- reactive({
    req(input$stgrnsPred)
    as.numeric(RcppCNPy::npyLoad(input$stgrnsPred$datapath))
  })

  # Simple accuracy function
  accuracy <- function(true, pred) {
    mean((pred >= 0.5) == (true == 1))
  }

  # Display accuracies
  output$accText <- renderPrint({
    y <- yTrue(); d <- deepPred(); s <- stgrnsPred()
    accDeep <- accuracy(y, d)
    accSTGRNS <- accuracy(y, s)
    cat(sprintf("DeepRIG accuracy: %.3f\nSTGRNS accuracy: %.3f", accDeep, accSTGRNS))
  })

  # Barplot of accuracies
  output$accPlot <- renderPlot({
    y <- yTrue(); d <- deepPred(); s <- stgrnsPred()
    df <- data.frame(
      Method = c("DeepRIG", "STGRNS"),
      Accuracy = c(accuracy(y, d), accuracy(y, s))
    )
    ggplot(df, aes(x = Method, y = Accuracy)) +
      geom_col() +
      ylim(0, 1) +
      labs(title = "Accuracy Comparison", x = NULL, y = "Accuracy") +
      theme_minimal()
  })
}

# Run App ----
shinyApp(ui = ui, server = server)
