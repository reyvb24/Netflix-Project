#import libs
library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(DT)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(plotly)
library(readr)
library(scales)
library(glue)
library(GGally)
library(lubridate)
library(keras)
library(shinythemes)
library(dashboardthemes)

combined_light <- read.csv("combined_lighter")

combined_arranged <- arrange(combined_light, year_released)

model_netflix <- load_model_hdf5("../model_netflix.h5")

model_bias <- load_model_hdf5("../model_bias.h5")