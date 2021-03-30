server <- function(input,output){
  
  output$movie_distribution <- renderPlotly({
    data_light <- combined_light %>% 
      filter(combined_light$year_released>=input$movie_year)
    data <- data_light %>% 
      group_by(rating) %>% 
      count(rating)
    data$prob <- data$n/sum(data$n)*100
    label_percent <- label_dollar(suffix = '%' ,prefix = '')
    data <- data %>% 
      mutate(tooltip = glue("distribution: {label_percent(prob)}"))
    p <- ggplot(data, aes(x = rating, y = prob, text = tooltip, fill = prob)) +
      geom_col(position = "identity") +
      labs(title = "Probability Distribution of Movie Ratings (Top 2000 Movies)",
           subtitle = paste("For data set 1 (", unique(data_light$movie_id), " movies, ", unique(data_light$customers), " customers, and ", nrow(data$rating), " ratings"),
           x = "Movie rating",
           y = "Probability") +
      scale_fill_gradient(low = "#e4333e", high = "#52171a") +
      theme(title = element_text(face = "bold", color = "black"), axis.title = element_text(face = "bold", color = "black"), panel.grid.major.x = element_blank()) +
      theme_minimal() 
    
    ggplotly(p)
  })
}