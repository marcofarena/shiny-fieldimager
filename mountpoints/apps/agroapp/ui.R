library(shiny)






library(shinydashboard, warn.conflicts = FALSE)
library(leaflet)

header <- dashboardHeader(
    title = "Aerial Crop Analysis"
)

sidebar <-     dashboardSidebar(
    sidebarMenu(
        menuItem("Filters and Indices", tabName = "filters", icon = icon("image")),
        menuItem("Crop and shape field", tabName = "shape", icon = icon("image"))
    )
)


body <- dashboardBody(
        tabItems(
          tabItem(tabName = "filters",
                         fluidRow(
            column(width = 9,
               box(width = NULL, solidHeader = TRUE,
                   leafletOutput("mymap", height = 500),
               ),
               #box(width = NULL,
                #   uiOutput("numVehiclesTable")
               #)
        ),
        column(width = 3,
               box(width = NULL, status = "warning",
                   #uiOutput("routeSelect"),
                   checkboxGroupInput("directions", "Show",
                                      choices = c(
                                          Northbound = 4,
                                          Southbound = 1,
                                          Eastbound = 2,
                                          Westbound = 3
                                      ),
                                      selected = c(1, 2, 3, 4)
                   ),
                   p(
                       class = "text-muted",
                       paste("Note: a route number can have several different trips, each",
                             "with a different path. Only the most commonly-used path will",
                             "be displayed on the map."
                       )
                   ),
                   actionButton("zoomButton", "Zoom to fit buses")
               ),
               box(width = NULL, status = "warning",
                   selectInput("interval", "Add refraction index layer",
                               choices = c("Remove Soil" = "remsoil",
                                           "Custom Index" = "custom",
                                           "NGRDI" = "ngrdi",
                                           "Indeces" = "ind"),
                               selected = "Remove Soil"
                   ),
                   #uiOutput("timeSinceLastUpdate"),
                   actionButton("addsrl", "Add Layer"),
                   p(class = "text-muted",
                     br(),
                     "Source data updates every 30 seconds."
                   )
               )
        )
    )
),
tabItem(tabName = "shape",
        fluidRow(
            column(width = 9,
                   box(width = NULL, solidHeader = TRUE,
                       plotOutput("distPlot", height = 500)
                   ),
            ),
            column(width = 3,
                   box(width = NULL, status = "warning",
                       
                       p(
                           class = "text-muted",
                           paste("Select the corners of the area you want to process",
                                 "Make sure it's a regular region that you can ",
                                 "fit into a gridded array with the shape that you specyfied."
                           )
                       ),
                       actionButton("zoomButton", "Zoom to fit buses")
                   ),
                   box(width = NULL, status = "warning",
                       
                       actionButton("detect", "Detect"),
                       p(class = "text-muted",
                         br(),
                         "Detect and locate plants."
                       )
                   ),
                   box(width = NULL, status = "warning",
                       
                       
                       numericInput(
                           "rotation",
                           "Rotation angle",
                           0,
                           min = NA,
                           max = NA,
                           step = 0.1,
                           width = NULL
                       ),
                       actionButton("rotate", "Rotate"),
                       p(class = "text-muted",
                         br(),
                         "Detect and locate plants."
                       )
                   )
            )
        )
)))

dashboardPage(
    header,
    sidebar,
    body
)














