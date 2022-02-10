library(bs4Dash)
library(xts)
library(dygraphs)

# read data

crypto <- read.csv("Dash_all_data.csv", stringsAsFactors = FALSE)

source("https://raw.githubusercontent.com/medseddik1999/Crypto_Dashbord_simulator-/main/Simulation_Functions_dash.R")

crypto$Date <- as.Date(crypto$timestamp)

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
                         
                         text = "Price/Volume",
                         tabName = "sub1"
                         
                       ),
                       
                       bs4SidebarMenuSubItem(
                         
                         text = "Some Indicators",
                         tabName = "sub2"
                         
                       )),
                     
                     bs4SidebarMenuItem(
                       
                       text = "Strategies",
                       tabName = "tab3"
                     ),
                     
                       bs4SidebarMenuItem(
                         
                         text = "Portfolio examples (WIP)",
                         tabName = "tab2"
                       ),
                     
                     bs4SidebarMenuItem(
                       
                       text = "Data",
                       tabName = "tab4"
                     ),
                     bs4SidebarMenuItem(
                       
                       text = "Team",
                       tabName = "tab5"
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
        tags$img(src = "https://upload.wikimedia.org/wikipedia/fr/4/4e/RStudio_Logo.png", width = "240px", height = "70px")
        
      ),
      
      bs4TabItem(
        tabName = "sub1",
        h4(
          # Boxes need to be put in a row (or column)
          fluidRow(
            box(title = "Graph",div(dygraphOutput("priceGraph")), width = 9, height = 480),
            
            box(
              title = "Settings",
              selectInput(inputId = "Coin",
                          label = "Select a currency",
                          choices = c('Bitcoin(BTC)'="BTCUSDT", 'Ethereum(ETH)'="ETHUSDT", 'Litecoin'="LTCUSDT", 'DASH'="DASHUSDT",'0x(ZRX)'="ZRXUSDT",'Monero(XMR)'="XMRUSDT",'XRP'="XRPUSDT"),
                          selected = "BTCUSDT"),
              br(),
              br(),
              
              selectInput('selectOutput', 'Select output', choices = c(Price = "close.",  Volume = "volume.")),
              
              br(),
              br(),
              
             dateRangeInput('selectDate', 'Select date', start = min(crypto$Date), end = max(crypto$Date)),
             width =3, height = 480
            
            
            
          )))),
      
      bs4TabItem(
        
        tabName = "sub2",
        h4(
          # Boxes need to be put in a row (or column)
          fluidRow(
            box(title = "Indicator" ,div(dygraphOutput("indGraph")), width = 5, height = 480),
            box(title = "Price" ,div(dygraphOutput("priceGraph2")), width = 4, height = 480),
            
            box(
              title = "Settings",
              selectInput(inputId = "Coin_ind",
                          label = "Select a currency",
                          choices = c('Bitcoin(BTC)'="BTCUSDT", 'Ethereum(ETH)'="ETHUSDT", 'Litecoin'="LTCUSDT", 'DASH'="DASHUSDT",'0x(ZRX)'="ZRXUSDT",'Monero(XMR)'="XMRUSDT",'XRP'="XRPUSDT"),
                          selected = "BTCUSDT"),
            br(),            
            br(),

            selectInput('selectind', 'Select an indicator', choices = c(TRIX = "TRIX.",'TRIX Singal'="TRIX_singal.", AO="AO.",WillR= "WillR.", MB200="MB200.", MB600= "MB600."), multiple = T),
              
            br(),            
            br(),
            
            dateRangeInput('selectDate_ind', 'Select date', start = min(crypto$Date), end = max(crypto$Date)),
              width =3, height = 480)))),
      
      
      bs4TabItem(
        
        tabName = "tab2",
        h4(
          # Boxes need to be put in a row (or column)
          fluidRow(
            box(title = "Graph", width = 7, height = 480),
            
            box(
              title = "Composition of the Portfolio",
              width = 5,
     
        
              selectInput(inputId = "Coin_p1",
                          label = "Select first currency",
                          choices = c('Bitcoin(BTC)'="BTCUSDT", 'Ethereum(ETH)'="ETHUSDT", 'Litecoin(LTC)'="LTCUSDT", 'DASH'="DASHUSDT",'0x(ZRX)'="ZRXUSDT",'Monero(XMR)'="XMRUSDT",'XRP'="XRPUSDT"),
                          multiple = F,
                          selected = c("BTCUSDT")),
              
             
              sliderInput(inputId = "Portfolio_1", 
                               label = "% of first currency",
                               min = 0, max = 100, value = c(90)),
            
      
            
              selectInput(inputId = "Coin_p2",
                          label = "Select second currency",
                          choices = c('Bitcoin(BTC)'="BTCUSDT", 'Ethereum(ETH)'="ETHUSDT", 'Litecoin(LTC)'="LTCUSDT", 'DASH'="DASHUSDT",'0x(ZRX)'="ZRXUSDT",'Monero(XMR)'="XMRUSDT",'XRP'="XRPUSDT"),
                          multiple = F,
                          selected = c("ETHUSDT")),
              
              
              sliderInput(inputId = "Portfolio_2", 
                          label = "% of second currency",
                          min = 0, max = 100, value = c(5)),
            

              selectInput(inputId = "Coin_p3",
                          label = "Select third currency",
                          choices = c('Bitcoin(BTC)'="BTCUSDT", 'Ethereum(ETH)'="ETHUSDT", 'Litecoin(LTC)'="LTCUSDT", 'DASH'="DASHUSDT",'0x(ZRX)'="ZRXUSDT",'Monero(XMR)'="XMRUSDT",'XRP'="XRPUSDT"),
                          multiple = F,
                          selected = c("LTCUSDT")),
              
              
              sliderInput(inputId = "Portfolio_3", 
                          label = "% of third currency",
                          min = 0, max = 100, value = c(5)),
            
          dateRangeInput('selectDate_p', 'Select date', start = min(crypto$Date), end = max(crypto$Date)),
          numericInput('money','Money invested', 10000,0,1000000))
          
          
          ))),  
      
      bs4TabItem(
      tabName = "tab3",
      h4(
        # Boxes need to be put in a row (or column)
        fluidRow(
          box(title = "1st Strategy" ,plotOutput("StartGraph"), width = 4, height = 480),
          box(title = "2nd Strategy" ,plotOutput("StartGraph2"), width = 5, height = 480),
          
          box(
            width =3, height = 480,
            title = "Settings",
            selectInput(inputId = "Coin_strat",
                        label = "Select a currency",
                        choices = c('Bitcoin(BTC)'="BTCUSDT", 'Ethereum(ETH)'="ETHUSDT", 'Litecoin'="LTCUSDT", 'DASH'="DASHUSDT",'0x(ZRX)'="ZRXUSDT",'Monero(XMR)'="XMRUSDT",'XRP'="XRPUSDT"),
                        selected = "BTCUSDT"),
           
            selectInput('select_strat', 'Select a strategy', choices = c('Trix','SuperTrend','AwosomeOs', 'ArimaPred')),
            selectInput('select_strat2', 'Select a second strategy', choices = c('Trix','SuperTrend','AwosomeOs', 'ArimaPred')),
            
            
            numericInput('money_amount','Money invested', 10000,0,1000000)
            
            )))),
      
      
      
      bs4TabItem(
        
        tabName = "tab4",
        h4("Data used come from:"),
        tags$a('href'="https://www.binance.com/fr/support/faq/c-6", "Binance API"),
        h4("Source code of our project can be found on:"),
        tags$a('href'="https://github.com/medseddik1999/Crypto_Dashbord_simulator-", "Github")),
      
      
      bs4TabItem(
        
        tabName = "tab5",
        h4("Students working on the project:"),
        h6("Lucas Jeanneau"),
        tags$a('href'="https://github.com/LucasJeanneau", "Github"),
        h6("Mohammed Seddik"),
        tags$a('href'="https://github.com/medseddik1999", "Github"),
        h6("Andrija Lucic"),
        tags$a('href'="https://github.com/andrijalucic", "Github"),
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
    coinColumns <- cryptoColumns[cryptoColumns %in% paste0(selectedOutput,selectedCoins)]
    selectedColumns <- append("Date", coinColumns)
    data <- crypto[crypto$Date >= startDate & crypto$Date <= endDate, selectedColumns, drop=FALSE]
    

  })

  # generate graph
  output$priceGraph <- renderDygraph({
    data <- getData()
    time_series <- xts(data, order.by = data$Date)
    dygraph(time_series)
  })
 
  
### Indicators
  
  # get data
  getData_ind <- reactive({
    selectedCoins_ind <- input$Coin_ind
    selectedind <- input$selectind
    dates_ind <- input$selectDate_ind
    startDate_ind <- dates_ind[1]
    endDate_ind <- dates_ind[2]
    
    # filter data
    cryptoColumns_ind <- colnames(crypto)
    coinColumns_ind <- cryptoColumns_ind[cryptoColumns_ind %in% paste0(selectedind,selectedCoins_ind)]
    selectedColumns_ind <- append("Date", coinColumns_ind)
    data_ind <- crypto[crypto$Date >= startDate_ind & crypto$Date <= endDate_ind, selectedColumns_ind, drop=FALSE]
    
  })
  
  # generate graph
  output$indGraph <- renderDygraph({
    data_ind <- getData_ind()
    # data_ind$p <- crypto[paste0("close.",input$Coin_ind)]
    time_series <- xts(data_ind, order.by = data_ind$Date)
    dygraph(time_series)
  })
  

  
  ### Strategies
  
  # get data
  getData_start <- reactive({
    selectedCoins_strat <- input$Coin_strat
    selectedstrat <- input$select_strat
    selectedstrat2 <- input$select_strat2
    money_nb <- input$money_amount
  })
  
  # generate graph
  output$StartGraph <- renderPlot({
  b = Dash_Simule(m=input$money_amount, pair=input$Coin_strat, stg=input$select_strat, df= crypto)
  plot(as.Date(b$date), b$portfolio,type = "l", xlab = 'Date', ylab= "Value of the portfolio", col = "red")
    })  
  
  # generate graph2
  output$StartGraph2 <- renderPlot({
    b = Dash_Simule(m=input$money_amount, pair=input$Coin_strat, stg=input$select_strat2, df= crypto)
    plot(as.Date(b$date), b$portfolio,type = "l", xlab = 'Date', ylab= "Value of the portfolio", col = "red")
  })  
  
  ## Prices bellow strat
  
  # get data
  getData_strat2 <- reactive({
    selectedCoins_strat <- input$Coin_ind
    
    # filter data
    cryptoColumns_dt <- colnames(crypto)
    coinColumns_dt <- cryptoColumns_dt[cryptoColumns_dt %in% paste0("close.",selectedCoins_strat)]
    data_strat_2 <- crypto[coinColumns_dt, drop=FALSE]
  })
  
  # generate graph
  output$priceGraph2 <- renderDygraph({
    data_strat_2 <- getData_strat2()
    time_series_dt<- xts(data_strat_2, order.by = crypto$Date)
    dygraph(time_series_dt)
  })
  
  
}


shinyApp(ui, server)