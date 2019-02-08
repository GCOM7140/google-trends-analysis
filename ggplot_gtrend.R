# The objective is to compile a tidy data set using gtrendsR
# With multiple search terms chosen

# Required Packages

library(tidyverse)
library(gtrendsR)

# Specify search terms and date (2018) 
# Notice that quoting terms makes a difference
# Ex. The Juice Laundry vs. "The Juice Laundry"
# But capitalization would not make a difference
# Ex. the juice laundry vs. The Juice Laundry

search_terms <- c('The Juice Laundry', '"The Juice Laundry"', 
                  '"Juice Laundry"', "juice laundry")
time_span <- "2018-01-01 2018-12-31"

# run gtrends to obtain list of data frames

gtrends_list <- gtrends(keyword = search_terms, geo = "US", time = time_span,
                        gprop = "web")

# Create tidy table

gtrend <- gtrends_list[["interest_over_time"]] %>% 
  as_tibble() %>% 
  rename('relative_interest' = 'hits', 'week_of' = 'date', 
         'search_term' = 'keyword') %>% 
  select(c('week_of', 'search_term', 'relative_interest'))

# Replicate google trend visual

ggplot(gtrend, aes(x = week_of, y = relative_interest, 
                   color = search_term)) + 
  geom_line() + 
  geom_smooth(se = FALSE) +
  labs(title = 'Interest Over Time', x = 'Month', y = 'Relative Interest', 
       color = 'Search Term') +
  theme(legend.position = 'top', legend.direction = "horizontal", 
        legend.box = "horizontal")


       