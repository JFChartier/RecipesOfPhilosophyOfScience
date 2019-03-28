#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library(arules)
library(arulesViz)
library(visNetwork)
library(igraph)
library(shiny)
#library(markdown)
library(shinythemes)

network.visualizer=readRDS("network.visualizer.rds")

ui <- fluidPage(theme = shinytheme("paper"), inverse=F, windowTitle= "PhiloSci network", title = "PhiloSci network", 
                fluidRow(
                  column(
                    width = 2,
                    selectInput(inputId = "id.node", 
                                label = "Id node", 
                                choices = c("all"), 
                                selected = "all",
                                multiple = T),
                    selectInput(inputId = "cluster",
                                label="Clusters of articles",
                                choices = c("all"), 
                                selected = "all",
                                multiple = T),
                    selectInput(inputId = "id.rule",
                                label="Associative rules",
                                choices = c("all"), 
                                selected = "all",
                                multiple = T),
                    selectInput(inputId = "node.size",
                                label="Node sizes",
                                choices = c("support", "confidence", "chi2", "count"), 
                                selected = "count",
                                multiple = F)
                  ),
                  column(
                    width = 10,
                    visNetworkOutput(outputId = "network", width = "100%", height = "100vh")
                  )
                )
)





server <- function(input, output) {
  output$network <- renderVisNetwork({
    network.visualizer
  })
  
  #observe({
  #visNetworkProxy("network") %>% visNodes(id = input$id.node)
  #})
}

shinyApp(ui = ui, server = server)
