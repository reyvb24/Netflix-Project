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

combined_light <- read.csv("combined_light.csv")

combined_arranged <- arrange(combined_light, year_released)