#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#



# Define UI for application that draws a histogram
shinyUI(fluidPage(
library(shiny)



    # Application title
    titlePanel("Post-processing"),
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(    
            #radioButtons("proc", "Process:",
            #                      c("Remove Soil" = "remsoil",
            #                        "Custom Index" = "custom",
            #                        "NGRDI" = "ngrdi",
            #                        "Indeces" = "ind")),
                         
    
            checkboxGroupInput("proc", "Process",
                               choices = list("Remove Soil" = "remsoil",
                                              "Custom Index" = "custom",
                                              "NGRDI" = "ngrdi",
                                              "Indeces" = "ind")),
            downloadButton('downloadImage', 'Download modified image')

        mainPanel(
           plotOutput("distPlot", width = "500px", height = "400px", inline = FALSE)
        )
    )

)
