library(shiny)
library(shinydashboard)

shinyUI(dashboardPage(
    dashboardHeader(title = "Post-processing"),
    dashboardSidebar(
        sidebarMenu(
            menuItem("Filters and Indices", tabName = "filters", icon = icon("image"))
        )
    ),
    dashboardBody(
        # Boxes need to be put in a row (or column)
        tabItems(
            tabItem(tabName = "filters",
                fluidRow(
                    box(width= 9, plotOutput("distPlot")),
            
                    box(width= 3,
                        selectInput("proc", "Process:",
                                    c("Remove Soil" = "remsoil",
                                      "Custom Index" = "custom",
                                      "NGRDI" = "ngrdi",
                                      "Indeces" = "ind")),
                        
#                        checkboxGroupInput("proc", "Process",
#                                   choices = list("Remove Soil" = "remsoil",
#                                                  "Custom Index" = "custom",
#                                                  "NGRDI" = "ngrdi",
#                                                  "Indeces" = "ind")),
                                    downloadButton('downloadImage', 'Download')))
            )
        )
    )
))

