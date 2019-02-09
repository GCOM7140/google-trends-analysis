# The objective is to compare google trends data and gtrendsR data
# And to ensure they are identical

# Required packages

library(tidyverse)
library(gtrendsR)

# Specify google trend csv file path, search term(s), and time period
# You must download google-trends.csv found in the data folder

csv <- "YOUR_FILE/PATH"
search_term <- '"juice laundry"'
time_span <- "2018-01-01 2018-12-31"

# Read in google trend csv as tibble object
# Specify column type so that it matches gtrends

google_trend <- read_csv(
  csv, skip = 3, col_names = c('week_of', 'relative_interest'),
  col_types = cols(relative_interest = col_integer())
) %>% 
  as_tibble() %>% 
  mutate('search_term' = search_term) %>% 
  select(c('week_of', 'search_term', 'relative_interest'))

# Run gtrends to obtain list of data frames

gtrends_list <- gtrends(
  search_term,  geo = "US", time = time_span
)

# Convert gtrends interest_over_time into data table that matches google trend

gtrend <- gtrends_list[["interest_over_time"]] %>% 
  as_tibble() %>% 
  rename('relative_interest' = 'hits', 'week_of' = 'date', 
         'search_term' = 'keyword') %>% 
  select(c('week_of', 'search_term', 'relative_interest'))

# Prove that the relative_interest (3rd) columns match

identical(google_trend[, 3], gtrend[, 3])

## TRUE

