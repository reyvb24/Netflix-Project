# ui.R
header <- dashboardHeader(
  title = "Netflix Recommender System"
)
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem(text = "Data Visualization",tabName = "page_one"),
    menuItem(text = "How our Model is Constructed",tabName = "pageTwo"),
    menuItem(text = "Dividends", tabName = "pageThree"),
    # menuItem(text = "Custom plot", tabName = "pageFive"),
    menuItem(text = "Raw data", tabName = "pageFour")
  )
)
body <- dashboardBody(
  tabItems(
    tabItem(
      tabName = "page_one", 
      fluidPage(
        setBackgroundColor(
          color = "#fefeff",
          shinydashboard = T
        ),
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
              width = '100%'
            )
        ),
        fluidRow(
          column(plotlyOutput(outputId = "movie_distribution"),
                 width = 6)
        )
      )
    )
  )
)

ui<- dashboardPage(
  header = header,
  sidebar = sidebar,
  body = body
)