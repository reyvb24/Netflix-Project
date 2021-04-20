# ui.R
header <- dashboardHeader(
  title = tags$a(href = "https://www.netflix.com/hk-en/", tags$img(src = "www/netflix-logo.png",height="60",width="200"))
)
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem(text = "Home", tabName = "page_home"),
    menuItem(text = "Data Visualization", tabName = "page_one"),
    menuItem(text = "How our Model is Constructed", tabName = "pageTwo"),
    menuItem(text = "Predict for a user", tabName = "page_three"),
    # menuItem(text = "Custom plot", tabName = "pageFive"),
    menuItem(text = "Raw data", tabName = "pageFour")
  )
)
body <- dashboardBody(
  shinyDashboardThemeDIY(
    appFontFamily = "Arial"
    ,appFontColor = "rgb(0,0,0)"
    ,primaryFontColor = "rgb(0,0,0)"
    ,infoFontColor = "rgb(0,0,0)"
    ,successFontColor = "rgb(0,0,0)"
    ,warningFontColor = "rgb(0,0,0)"
    ,dangerFontColor = "rgb(0,0,0)"
    ,bodyBackColor = "rgb86,77,77)"
    
    ### header
    ,logoBackColor = "rgb(229,29,20)"
    
    ,headerButtonBackColor = "rgb(0,0,0)"
    ,headerButtonIconColor = "rgb(248,248,248)"
    ,headerButtonBackColorHover = "rgb(210,210,210)"
    ,headerButtonIconColorHover = "rgb(0,0,0)"
    
    ,headerBackColor = "rgb(0,0,0)"
    ,headerBoxShadowColor = "#aaaaaa"
    ,headerBoxShadowSize = "2px 2px 2px"
    
    ### sidebar
    ,sidebarBackColor = cssGradientThreeColors(
      direction = "down"
      ,colorStart = "rgb(204,31,31)"
      ,colorMiddle = "rgb(145,29,29)"
      ,colorEnd = "rgb(89,20,20)"
      ,colorStartPos = 0
      ,colorMiddlePos = 50
      ,colorEndPos = 100
    )
    ,sidebarPadding = 0
    
    ,sidebarMenuBackColor = "transparent"
    ,sidebarMenuPadding = 0
    ,sidebarMenuBorderRadius = 0
    
    ,sidebarShadowRadius = "3px 5px 5px"
    ,sidebarShadowColor = "#aaaaaa"
    
    ,sidebarUserTextColor = "rgb(255,255,255)"
    
    ,sidebarSearchBackColor = "rgb(55,72,80)"
    ,sidebarSearchIconColor = "rgb(153,153,153)"
    ,sidebarSearchBorderColor = "rgb(55,72,80)"
    
    ,sidebarTabTextColor = "rgb(255,255,255)"
    ,sidebarTabTextSize = 13
    ,sidebarTabBorderStyle = "none none solid none"
    ,sidebarTabBorderColor = "rgb(35,106,135)"
    ,sidebarTabBorderWidth = 1
    
    ,sidebarTabBackColorSelected = cssGradientThreeColors(
      direction = "right"
      ,colorStart = "rgba(242,59,59,1)"
      ,colorMiddle = "rgba(247,80,80,1)"
      ,colorEnd = "rgba(247,179,80,1)"
      ,colorStartPos = 0
      ,colorMiddlePos = 30
      ,colorEndPos = 100
    )
    ,sidebarTabTextColorSelected = "rgb(0,0,0)"
    ,sidebarTabRadiusSelected = "0px 20px 20px 0px"
    
    ,sidebarTabBackColorHover = cssGradientThreeColors(
      direction = "right"
      ,colorStart = "rgba(242,59,59,1)"
      ,colorMiddle = "rgba(247,80,80,1)"
      ,colorEnd = "rgba(247,179,80,1)"
      ,colorStartPos = 0
      ,colorMiddlePos = 30
      ,colorEndPos = 100
    )
    ,sidebarTabTextColorHover = "rgb(50,50,50)"
    ,sidebarTabBorderStyleHover = "none none solid none"
    ,sidebarTabBorderColorHover = "rgb(75,126,151)"
    ,sidebarTabBorderWidthHover = 1
    ,sidebarTabRadiusHover = "0px 20px 20px 0px"
    
    ### boxes
    ,boxBackColor = "rgb(255,255,255)"
    ,boxBorderRadius = 5
    ,boxShadowSize = "0px 1px 1px"
    ,boxShadowColor = "rgba(0,0,0,.1)"
    ,boxTitleSize = 16
    ,boxDefaultColor = "rgb(210,214,220)"
    ,boxPrimaryColor = "rgba(44,222,235,1)"
    ,boxInfoColor = "rgb(210,214,220)"
    ,boxSuccessColor = "rgba(0,255,213,1)"
    ,boxWarningColor = "rgb(244,156,104)"
    ,boxDangerColor = "rgb(255,88,55)"
    
    ,tabBoxTabColor = "rgb(255,255,255)"
    ,tabBoxTabTextSize = 14
    ,tabBoxTabTextColor = "rgb(0,0,0)"
    ,tabBoxTabTextColorSelected = "rgb(0,0,0)"
    ,tabBoxBackColor = "rgb(255,255,255)"
    ,tabBoxHighlightColor = "rgba(44,222,235,1)"
    ,tabBoxBorderRadius = 5
    
    ### inputs
    ,buttonBackColor = "rgb(245,245,245)"
    ,buttonTextColor = "rgb(0,0,0)"
    ,buttonBorderColor = "rgb(200,200,200)"
    ,buttonBorderRadius = 5
    
    ,buttonBackColorHover = "rgb(235,235,235)"
    ,buttonTextColorHover = "rgb(100,100,100)"
    ,buttonBorderColorHover = "rgb(200,200,200)"
    
    ,textboxBackColor = "rgb(255,255,255)"
    ,textboxBorderColor = "rgb(200,200,200)"
    ,textboxBorderRadius = 5
    ,textboxBackColorSelect = "rgb(245,245,245)"
    ,textboxBorderColorSelect = "rgb(200,200,200)"
    
    ### tables
    ,tableBackColor = "rgb(255,255,255)"
    ,tableBorderColor = "rgb(240,240,240)"
    ,tableBorderTopSize = 1
    ,tableBorderRowSize = 1
    
  ),
  tabItems(
    tabItem(
      tabName = "page_home", 
      fluidPage(
        fluidRow(
          column(
            width = 4,
            tags$h4("this is home")
          )
        )
      )
    ),
    tabItem(
      tabName = "page_one", 
      fluidPage(
        fluidRow(
          column(width = 12,
                 titlePanel(title = tags$b("Netflix Recommender System")),
                 align = "center"
          )
        ),
        tags$br(),
        tags$br(),
        div(style =  "padding: 2% 0; margin: 0 auto; width: 80%;",
            sliderInput(
              inputId = "movie_year",
              label = "Choose the starting year:",
              min = combined_arranged %>% 
                head(1) %>% 
                select(year_released) %>% 
                pull(),
              max = combined_arranged %>% 
                tail(1) %>% 
                select(year_released) %>% 
                pull(),
              value = combined_arranged %>% 
                head(1) %>% 
                select(year_released) %>% 
                pull(),
              timeFormat = "%Y",
              animate = T,
              width = "100%"
            )
        ),
        fluidRow(
          column(plotlyOutput(outputId = "movie_distribution"),
                 width = 6)
        )
      )
    ),
    tabItem(
      tabName = "page_three",
      fluidPage(
        fluidRow(
          column(
            width = 12,
            titlePanel(title = tags$b("Make a Prediction for a Customer")),
            align = "center"
          )
        ),
        fluidRow(
          column(
            width = 8,
            dataTableOutput(
              outputId = "prediction"
            )
          ),
          column(
            width = 4,
            numericInput(
              inputId = "customer_id",
              label = "Choose which customer to predict:",
              min = min(combined_light$movie_id_dense),
              max = max(combined_light$movie_id_dense),
              value = 1,
              step = 1
            ),
            actionButton(
              inputId = "predict_button",
              label = "predict"
            )
          ),
          column(
            width = 12,
            dataTableOutput(outputId = "not_watched_prediction")
          )
        )
      )
    )
  )
)

ui <- dashboardPage(
  header = header,
  sidebar = sidebar,
  body = body
)