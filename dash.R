library(bs4Dash)
library(xts)
library(dygraphs)

# read data
crypto <- read.csv("dataset.csv", stringsAsFactors = FALSE)
crypto$Date <- as.Date(crypto$Date)

## User interface

ui <- bs4DashPage(
  dashboardHeader(title = "Cryptocurrencies dashboard"),
  dashboardSidebar(skin = "light",
                   status = "gray",
                   title = "Sidebar menu",
                   
                   bs4SidebarMenu(
                     
                     bs4SidebarMenuItem(
                       
                       text = "Home",
                       tabName = "home"
                       
                     ),
                     
                     bs4SidebarMenuItem(
                       
                       text = "Trends of main cryptocurrencies",
                       tabName = "tab1",
                       bs4SidebarMenuSubItem(
                         
                         text = "Price/Market Cap/Volume",
                         tabName = "sub1"
                         
                       ),
                       
                       bs4SidebarMenuSubItem(
                         
                         text = "Some Indicators",
                         tabName = "sub2"
                         
                       )),
                       bs4SidebarMenuItem(
                         
                         text = "Portfolio examples",
                         tabName = "tab2"
                       ),
                     
                     bs4SidebarMenuItem(
                       
                       text = "Data",
                       tabName = "tab3"
                     ),
                     bs4SidebarMenuItem(
                       
                       text = "Team",
                       tabName = "tab4"
                     )
                      
                     )),
  
  body = dashboardBody(
    
    
    bs4TabItems(
      
      bs4TabItem(
        tabName = "home",
        h2("Dashboard Home Page"),
        tags$p("This dashboard is a project realized by 4 data science students for a data architecture course."),
        tags$p("The project aims to provide a historical cryptocurrencies price database and some useful statistics to have in mind before investing. This dashboard also presents sample portfolios from the academic literature and their profits over time. "),
        tags$img(src = "https://thumbor.forbes.com/thumbor/fit-in/900x510/https://www.forbes.com/advisor/wp-content/uploads/2021/06/top-cryptocurrencies.jpeg", width = "470px", height = "200px"),
        h4("Software used:"),
        tags$img(src = "https://upload.wikimedia.org/wikipedia/fr/4/4e/RStudio_Logo.png", width = "240px", height = "70px"),
        
      ),
      
      bs4TabItem(
        tabName = "sub1",
        h4(
          # Boxes need to be put in a row (or column)
          fluidRow(
            box(div(dygraphOutput("priceGraph", width = "100%", height = "800px"))),
            
            box(
              title = "Currencies",
              selectInput(inputId = "Coin",
                          label = "Select a currency",
                          choices = c("Bitcoin", "eth", "ltc"),
                          multiple = T,
                          selected = c("Bitcoin")),
              
              box(selectInput('selectOutput', 'Select output', choices = c('Market Cap' = "market", Price = "price", Volume = "volume"))),
              
              
              box(dateRangeInput('selectDate', 'Select date', start = min(crypto$Date), end = max(crypto$Date)))
            )
            
          ))),
      
      bs4TabItem(
        
        tabName = "sub2",
        h4("test")),
      
      bs4TabItem(
        
        tabName = "tab2",
        h4("portfolio")),
      
      bs4TabItem(
        
        tabName = "tab3",
        h4("data")),
      
      bs4TabItem(
        
        tabName = "tab4",
        h4("Students working on the project:"),
        h6("Lucas Jeanneau"),
        tags$a('href'="https://github.com/LucasJeanneau", "Github"),
        h6("Mohammed Seddik"),
        h6("Andrija Lucic"),
        h6("Rafa Moussa"),
        h4("Referent teacher:"),
        h6("Moritz Mueller"))
      )))

server <- function(input, output) {
  # get data
  getData <- reactive({
    selectedCoins <- input$Coin
    selectedOutput <- input$selectOutput
    dates <- input$selectDate
    startDate <- dates[1]
    endDate <- dates[2]
    
    # filter data
    cryptoColumns <- colnames(crypto)
    coinColumns <- cryptoColumns[cryptoColumns %in% paste0(selectedCoins, selectedOutput)]
    selectedColumns <- append("Date", coinColumns)
    data <- crypto[crypto$Date >= startDate & crypto$Date <= endDate, selectedColumns, drop=FALSE]
    

  })
  
  # generate graph
  output$priceGraph <- renderDygraph({
    data <- getData()
    time_series <- xts(data, order.by = data$Date)
    dygraph(time_series)
  })
}


shinyApp(ui, server)