# The objective is to compare google trends data and gtrendsR data
# And to ensure they are identical

# Required packages

library(tidyverse)
library(gtrendsR)

# Specify google trend csv file path, search term(s), and timespan (2018 here)
# You must download 2019-02-09-google-trends-homepage.csv found in 
# the data folder and replace the path below to your own local path

csv <- "/Users/malcolm_mashig/Downloads/2019-02-09-google-trends-homepage.csv"
search_term <- '"juice laundry"'
time_span <- "2018-01-01 2018-12-31"

# Read in google trends csv 
# Specify column type so that it matches gtrends

google_trend <- read_csv(
  csv, skip = 3, col_names = c('week_of', 'relative_interest')
  ) %>% 
  as_tibble() %>% 
  mutate('search_term' = search_term) %>% 
  select(c('week_of', 'search_term', 'relative_interest'))

# Run gtrends to obtain list of data frames

gtrends_list <- gtrends(
  search_term,  geo = "US", time = time_span
)

# Write a csv to save gtrends data in data folder

write_csv(gtrends_list[["interest_over_time"]], "2019-02-09-google-trends-gtrendsr.csv")

# Convert gtrends interest_over_time into data table that matches google trend

gtrend <- gtrends_list[["interest_over_time"]] %>% 
  as_tibble() %>% 
  rename('relative_interest' = 'hits', 'week_of' = 'date', 
         'search_term' = 'keyword') %>% 
  select(c('week_of', 'search_term', 'relative_interest'))

# Instead of generating new gtrends sample, download csv I used
# named '2019-02-09-google-trends-gtrendsr.csv' in the data folder
# and insert your local path

gtrendsr_csv <- '/Users/malcolm_mashig/Box Sync/google-trends-analysis/data/2019-02-09-google-trends-gtrendsr.csv'

gtrend <- read_csv(gtrendsr_csv) %>% 
  select('relative_interest' = hits)

# Prove that the relative_interest columns match

identical(google_trend[, 3], gtrend[, 1])

## TRUE

# We have shown that gtrendsR is reliable in extracting the exact data 
# from Google Trends

