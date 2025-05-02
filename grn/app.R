library(shiny)

# Define UI for the application
ui <- fluidPage(
    titlePanel("Shiny App Template"),
    
    sidebarLayout(
        sidebarPanel(
            # Add input elements here
            textInput("text", "Enter text:", ""),
            actionButton("action", "Submit")
        ),
        
        mainPanel(
            # Add output elements here
            textOutput("outputText")
        )
    )
)

# Define server logic
server <- function(input, output, session) {
    output$outputText <- renderText({
        paste("You entered:", input$text)
    })
}

# Run the application
shinyApp(ui = ui, server = server)