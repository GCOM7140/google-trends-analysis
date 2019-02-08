# The objective is to replicate the two main visuals 
# that Google Trends supplies: the line and bar graph
# with multiple TJL search term variations provided

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

# Replicate a neat google trend visual
# Ignore abnormal date_label -- for some unknown reason, axis started with Feb.

ggplot(gtrend, aes(x = week_of, y = relative_interest, 
                   color = search_term)) + 
  geom_line() + 
  labs(title = 'Interest Over Time', x = 'Month', y = 'Relative Interest', 
       color = 'Search Term:') + 
  scale_x_datetime(date_breaks = 'month', 
                   date_labels = c('Jan', month.abb[1:12])) +
  theme(legend.position = 'bottom', legend.direction = 'vertical') +
  guides(color = guide_legend(nrow = 2))

# Summarize the average interest and round to avoid a bunch of decimals

avg_trend <- gtrend %>% 
  group_by(search_term) %>% 
  summarise(round(mean(relative_interest))) %>% 
  rename('avg_interest' = 'round(mean(relative_interest))')

# Plot bar graph with stat = 'identity' to avoid a count (allowing y variable)
# Use geom_text to label interest over bars
# Notice that titles should state a conclusion

ggplot(avg_trend, aes(x = search_term, y = avg_interest)) + 
  geom_bar(stat = 'identity', fill = c('red', 'blue', 'green', 'purple')) +
  geom_text(aes(label = avg_interest, vjust = -1)) +
  labs(title = 'The search term, juice laundry, recieved the greatest average interest in 2018', x = 'Search Term', y = 'Average Interest') +
  ylim(0, 100)

## Now you have the two main visuals that Google Trends gives you









       