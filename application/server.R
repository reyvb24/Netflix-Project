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
  
  check_prediction <- eventReactive(input$predict_button, {
    input$customer_id
  })
  
  output$prediction <- renderDataTable({
    new_customer_id <- check_prediction()

    # get movies watched by our user
    movies_watched <- combined_light %>%
      filter(customer_id_dense == new_customer_id) %>%
      pull(movie_id_dense)

    # get all available movies
    all_movies <- combined_light %>%
      distinct(movie_id_dense) %>%
      pull()

    # identify movies not watched
    movies_not_watched <- setdiff(all_movies, movies_watched)

    movie_options <- combined_light %>%
      filter(movie_id_dense %in% movies_not_watched) %>%
      distinct(movie_id_dense, title)

    customer_options <- expand.grid(
      user_id = new_customer_id,
      movie_id_dense= movies_not_watched
    ) %>%
      as.matrix()

    inputs <- list(
      customer_options[, "user_id", drop = FALSE],
      customer_options[, "movie_id_dense", drop = FALSE]
    )
    pred <- model_netflix %>% predict(inputs)

    customer_options %>%
      as_tibble() %>%
      mutate(predictions = as.vector(pred)) %>%
      left_join(movie_options, by = "movie_id_dense") %>%
      arrange(desc(predictions))
  })
  
  output$not_watched_prediction <- renderDataTable({
    new_customer_id <- check_prediction()

    # get movies watched by our user
    movies_watched <- combined_light %>%
      filter(customer_id_dense == new_customer_id) %>%
      pull(movie_id_dense)

    combined_light %>%
      filter(movie_id_dense %in% movies_watched) %>%
      filter(customer_id_dense == new_customer_id) %>%
      distinct(title, movie_id_dense, rating) %>%
      arrange(desc(rating))
  })
}