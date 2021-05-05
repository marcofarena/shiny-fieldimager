#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(FIELDimageR)
library(raster)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    

    output$distPlot <- renderPlot({
        
        
        EX1<-stack("C:/Users/marcoarena/Downloads/EX1_RGB.tif")
        
        #EX1.Crop <- fieldCrop(mosaic = EX1)
        plotRGB(EX1)#, r = 1, g = 2, b = 3)
        #plotPNG(EX1, filename = tempfile(fileext = ".png"), width = 400,
         #        height = 400)#(EX1, r = 1, g = 2, b = 3)
        
        mask = fieldMask(mosaic = EX1)
        
        imag <- switch(input$proc,
                       "resoil" = mask,
                       "ind" = fieldIndex(mosaic = mask$newMosaic,
                                          index = c("NGRDI","BGI"), 
                                          myIndex = c("(Red-Blue)/Green"))
                       
                       ,
                       "ngrdi" = fieldIndex(mosaic = mask$newMosaic,
                                          #Red = NULL, Green = NULL, Blue = NULL,
                                          index = c("NGRDI") ),
                       
                       "custom" = fieldIndex(mosaic = mask$newMosaic,
                                             
                                             myIndex = c("(Red-Blue)/Green")),
                       mask)
        
        output$img <- if("edge" %in% input$effects)
                        img <- image_edge(image)
            
                      if("charcoal" %in% input$effects)
                            img <- image_charcoal(image)
            
                      if("negate" %in% input$effects)
                           img <- image_negate(image)    
            
            if("flip" %in% input$effects)
                image <- image_flip(image)
            
            if("flop" %in% input$effects)
                image <- image_flop(image)
        
        
        #EX1.RemSoil<- fieldMask(mosaic = EX1)
        EX1.Img = imag
#        EX1.Indices<- fieldIndex(mosaic = EX1.RemSoil$newMosaic,
#                                 index = c("NGRDI","BGI"), 
#                                 myIndex = c("(Red-Blue)/Green"))
        
        
        
        
    })

    
    
    
    }

# Run the application 
shinyApp(ui = ui, server = server)
