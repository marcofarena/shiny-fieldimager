

library(FIELDimageR)
library(raster)



shinyServer(function(input, output) {
    
    EX1<-stack("EX1_RGB.tif")
    
    
    
    
    filter_ground <- function(image){
        
        mask = fieldMask(image)
        plotRGB(mask$newMosaic, r = 1, g = 2, b = 3)
        return(mask)
        
    }
    
    getIndex <- function(image, index){
        out = fieldIndex(image, index = c(index))
        plot(out@layers[[4]])
        return(out@layers[[4]])
        
    }
    
    shape <- function(image, theta, nrows, ncols){
        rotated <- fieldRotate(image, theta = 2.3)
        shape <- fieldShape(rotated, ncols = ncols, nrows = nrows)
        
    }
    
    
    
    points <- eventReactive(input$recalc, {
        cbind(rnorm(40) * 2 + 13, rnorm(40) + 48)
    }, ignoreNULL = FALSE)
    
    output$mymap <- renderLeaflet({
        
        asd = getIndex(EX1, "NGRDI")
        pal <- colorNumeric("Spectral", values(asd), 
                            na.color = "transparent")
        leaflet() %>%
            #addProviderTiles(providers$Stamen.TonerLite,
            #                 options = providerTileOptions(noWrap = TRUE)
            #) %>%
            addProviderTiles('Esri.WorldImagery', options = providerTileOptions(maxZoom = 30)) %>%
            
            addRasterImage(asd, colors = pal, opacity = 1,
                           )
            
            
            
            #addMarkers(data = points())
    })

    
    
        
    
        
     
        
        
        output$distPlot <- renderPlot({
        
        
        
        
        
            rotated<-fieldRotate(EX1, theta = input$rotation)
            
            #asd <- filter_ground(EX1)
        
        
       
        
        
    })
    
    
    
    
    
})

# Run the application 

