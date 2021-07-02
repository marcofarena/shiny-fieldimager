#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

# Define server logic required to draw a histogram
library(FIELDimageR)
library(raster)



shinyServer(function(input, output) {
    
    
    
    
    output$distPlot <- renderPlot({
        
        
        EX1<-stack("EX1_RGB.tif")
        
        #EX1.Crop <- fieldCrop(mosaic = EX1)
        
        
        plot(EX1@layers[[1]])#, r = 1, g = 2, b = 3)
        #plotPNG(EX1, filename = tempfile(fileext = ".png"), width = 400,
        #        height = 400)#(EX1, r = 1, g = 2, b = 3)
        
        
        mask = fieldMask(mosaic = EX1)
        
        #        imag <- switch(input$proc,
        #                       
        #                       "resoil" = mask,
        #                      
        #                      "ind" = fieldIndex(mosaic = mask$newMosaic,
        #                                          c("NGRDI","BGI"), #index = c("BGI")),
        #                                         myIndex = c("(Red-Blue)/Green")),
        #                       
        #                       
        #                      "ngrdi" = fieldIndex(mosaic = mask$newMosaic,
        #                                          #Red = NULL, Green = NULL, Blue = NULL,
        ##                                          index = c("NGRDI") ),
        #                       
        #                       "custom" = fieldIndex(mosaic = mask$newMosaic,
        #                                             
        #                                             myIndex = c("(Red-Blue)/Green")),
        #                       
        #                      mask)
        
        output$img <- if(input$proc=="resoil")
            img <- mask
        
        if(input$proc=="ind")
            img <- fieldIndex(mosaic = mask$newMosaic,
                              index = c("BGI"))
        
        if(input$proc=="ngrdi")
            img <- fieldIndex(mosaic = mask$newMosaic,
                              #Red = NULL, Green = NULL, Blue = NULL,
                              index = c("NGRDI") )
        if(input$proc=="custom")
            img <- fieldIndex(mosaic = mask$newMosaic,
                              myIndex = c("(Red-Blue)/Green"))
        else
            img <- mask
        
        
    
        
        
        EX1.Img <- img
        #        EX1.Indices<- fieldIndex(mosaic = EX1.RemSoil$newMosaic,
        #                                 index = c("NGRDI","BGI"), 
        #                                 myIndex = c("(Red-Blue)/Green"))
        
        
        
        
    })
    
    
    
    
    
})

# Run the application 

